#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes AAR recording on server
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_aar_fnc_record
 *
 * Public: No
 */
SCRIPT(record);

if (!isServer) exitWith { };

/* handle new entities */
addMissionEventHandler ["EntityCreated", {
    params ["_entity"];

    if ((_entity in allUnits || _entity in allMapMarkers || _entity in vehicles) && !isNull _entity) then {
        _entity addEventHandler ["Fired", {
            params ["_unit", "_weapon", "", "", "", "", "_projectile"];

            [_unit, _projectile, _weapon] spawn {
                params ["_unit", "_projectile", "_weapon"];
                private _fireData = _unit getVariable [QGVAR(fire_data), []];
                private _projectilePos1 = getPosASL _projectile;
                sleep 0.1;

                if (!isNull _projectile) then {
                    private _projectilePos2 = getPosASL _projectile;

                    _fireData pushBack [_weapon, [_projectilePos1, _projectilePos2]];
                    _unit setVariable [QGVAR(fire_data), _fireData, true];
                };
            };
        }];
    };
}];

_this spawn {
    /* Get title of mission */
    private _missionTitle = if (!isNil { missionNameSpace getVariable QGVAR(safestart_title) }) then {
        missionNameSpace getVariable QGVAR(safestart_title)
    } else {
        [getMissionConfigValue ['IntelBriefingName', briefingName]] call cmf_utility_fnc_hexToASCII;
    };

    /* Set base AAR data (and overwrite any old data) */
    profileNamespace setVariable [QGVAR(AAR_data), [_missionTitle, worldName, time, [], []]];
    private _recordStep = 1;

    LOG("Started AAR recording");
    while {missionNamespace getVariable [QGVAR(recordActive), true]} do {
        _prevData = profileNamespace getVariable [QGVAR(AAR_data), ["Failed", "Failed", [], []]];
        private _time = EGVAR(main,unifiedTime);

        /* Get object data */
        private _objects = _prevData select 2;
        {
            private _fireData = _x getVariable [QGVAR(fire_data), []];
            _objects pushBack [_x, typeof _x, side _x, lifeState _x, getPosASL _x, getDir _x, crew _x, _fireData];

            _x setVariable [QGVAR(fire_data), [], true];
        } forEach (allUnits + allDead);
        private _objectArray = [_time, _objects];

        /* get marker data */
        private _markers = _prevData select 3;
        {
            _markers pushBack [_x, markerText _x, markerType _x, markerColor _x, markerSize _x, getMarkerPos _x, markerDir _x];
        } forEach allMapMarkers;
        private _markerArray = [_time, _markers];

        profileNamespace setVariable [QGVAR(AAR_data), [_prevData select 0, _prevData select 1, _objectArray, _markerArray]];
        private _prevData = nil;
        private _objects = nil;
        private _markers = nil;

        sleep _recordStep;
    };
};
