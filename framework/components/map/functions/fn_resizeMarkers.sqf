#include "script_component.hpp"
/*
 * Author: KillzoneKid, Eric
 * Keeps a consistent size on map markers regrardless of player map zoom.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_player_fnc_resizeMapMarkers
 *
 * Public: Yes
*/
SCRIPT(resizeMapMarkers);

if (!hasInterface) exitWith {};

[{ !isNull findDisplay 12 }, {
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if !SETTING(consistentMarkers) exitWith {};

        if visibleMap then {
            private _scale = 0.05 / ctrlMapScale (_this select 0);
            {
                if (markerShape _x isNotEqualTo "ICON" ) then { continue };

                private _m = format [QGVAR(marker_size_%1), _x];
                if (isNil {missionNamespace getVariable _m}) then {
                    missionNamespace setVariable [_m, markerSize _x];
                };

                private _worldModifier = worldSize / 12800;
                private _sX = (((missionNamespace getVariable _m) select 0) * _scale) / _worldModifier max 0.35;
                private _sY = (((missionNamespace getVariable _m) select 1) * _scale) / _worldModifier max 0.35;
                private _markerSizeFinal = [_sX, _sY];

                /* Check if marker is currently moused over (will reset scale if marker is moused over) */
                ctrlMapMouseOver (findDisplay 12 displayCtrl 51) params ["_mouseOverType", "_marker"];
                if (_mouseOverType isEqualTo "marker") then {
                    if (_marker isEqualTo _x) then {
                        _markerSizeFinal = missionNamespace getVariable [_m, [1,1]];
                    };
                };

                if (markerType _x isEqualTo "respawn_inf") then {
                    _markerSizeFinal = missionNamespace getVariable [_m, [1,1]];
                };

                if !(markerShape _x isEqualTo "ICON") then {
                    _markerSizeFinal = missionNamespace getVariable [_m, [1,1]];
                };

                _x setMarkerSizeLocal _markerSizeFinal;
            } forEach allMapMarkers;
        };
    }];

    /* Reset map marker size when map is closed */
    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if !SETTING(consistentMarkers) exitWith {};

        if (!_mapIsOpened) then {
            private _m = format [QGVAR(marker_size_%1), _x];
            {
                if (markerShape _x isNotEqualTo "ICON") then { continue };
                _markerSizeFinal = missionNamespace getVariable [_m, [1,1]];
                _x setMarkerSizeLocal _markerSizeFinal;
            } forEach allMapmarkers;
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;