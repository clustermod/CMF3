#include "script_component.hpp"

/* NATO Phonetic alphabet */
GVAR(phoneticAlphabet) = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", 
    "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whisky", "Xray", "Yankee", "Zulu"];

/* Add groupVehicles */
if isServer then {
    /* Create groups hash for dynamic group system */
    GVAR(groups) = [[
        [west, [] call CBA_fnc_hashCreate],
        [east, [] call CBA_fnc_hashCreate],
        [independent, [] call CBA_fnc_hashCreate],
        [civilian, [] call CBA_fnc_hashCreate]
    ]] call CBA_fnc_hashCreate;
    publicVariable QGVAR(groups);

    /* Parse Orbat */
    private _orbat = call compile preprocessFileLineNumbers "rsc\organization\orbat.sqf";
    _orbat = [_orbat] call FUNC(parseOrbat);
    GVAR(orbat) = _orbat;
    publicVariable QGVAR(orbat);

    GVAR(groupVehicles) = [[
        [west, []],
        [east, []],
        [independent, []],
        [civilian, []]
    ]] call CBA_fnc_hashCreate;
    publicVariable QGVAR(groupVehicles);

    [QGVAR(groupRegistered), {
        params ["_group", "_groupData"];

        private _level = _groupData select 0;
        private _type = _groupData select 1;
        private _index = [_group, false] call FUNC(groupGetIndex);

        private _vehiclesHash = [GVAR(groupVehicles), side _group, []] call CBA_fnc_hashGet;

        private _vehicleIndex = _vehiclesHash findIf { [((_x select 0) select 0), ((_x select 0) select 1), ((_x select 0) select 2)] isEqualTo [_level, _index, ""] };

        if (_vehicleIndex isEqualTo -1) then {
            _index = [_group, true] call FUNC(groupGetIndex);
            _vehicleIndex = _vehiclesHash findIf { [((_x select 0) select 0), ((_x select 0) select 1), ((_x select 0) select 2)] isEqualTo [_level, _index, _type] };
        };

        if (_vehicleIndex isEqualTo -1) exitWith {};

        private _vehicleData = _vehiclesHash select _vehicleIndex;
        private _vehicle = _vehicleData select 1;
        private _children = (_vehicleData select 0) param [3, false];

        [_group, _vehicle] call FUNC(groupAssignVehicle);

        if _children then {
            {
                [_x, _vehicle] call FUNC(groupAssignVehicle);
            } forEach (_groupData select 3);
        };
    }] call CBA_fnc_addEventHandler;
};


call FUNC(warno);
call FUNC(roster);
call FUNC(ToE);
call FUNC(groupActions);

/* Load Shacktack UI changes */
call compile preprocessFileLineNumbers "components\organization\shacktacInit.sqf";