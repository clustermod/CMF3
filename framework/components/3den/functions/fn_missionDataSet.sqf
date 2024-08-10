#include "script_component.hpp"
/*
 * Author: Eric
 * Gets variables that can be accessed in the mission
 * 
 * Arguments:
 * 0: Variable Name <STRING>
 * 1: Default Variable Value <ANY>
 * 
 * Return Value:
 * Value of variable <ANY>
 * 
 * Example:
 * ["M_TITLE", "My Mission Title"] call cmf_3den_fnc_missionDataGet
 * 
 * Public: Yes
 */
params ["_varName", "_varValue"];

/* Find logic */
private _logics = (all3DENEntities select 0) select { (_x get3DENAttribute 'Name') isEqualTo [QGVAR(missionDataLogic)] };
private _logic = objNull;
if (count _logics isEqualTo 0) then {
    _logic = create3DENEntity ['Object', 'Logic', [0,0,0], true];
    _logic set3DENAttribute ['Name', QGVAR(missionDataLogic)];

    _logic addEventHandler ['UnregisteredFromWorld3DEN', {
        params ['_entity'];
        ['Deleted CMF Data! It is recommended to undo deletion!', 1, 5] call BIS_fnc_3DENNotification;
    }];
} else {
    _logic = _logics select 0;

    _logic addEventHandler ['UnregisteredFromWorld3DEN', {
        params ['_entity'];
        ['Deleted CMF Data! It is recommended to undo deletion!', 1, 5] call BIS_fnc_3DENNotification;
    }];
};

GVAR(missionDataLogic) = _logic;

private _logicInit = (_logic get3DENAttribute "Init") select 0;

call compile _logicInit;

private "_hash";
if (!isNil QEGVAR(common,missionData)) then {
    _hash = [EGVAR(common,missionData)] call CBA_fnc_hashCreate;
} else {
    _hash = [] call CBA_fnc_hashCreate;
};

_hash = [_hash, _varName, _varValue] call CBA_fnc_hashSet;

/* Set data */
GVAR(missionDataLogic) set3DENAttribute [
    "Init", 
    format [
        "if (!isServer) exitWith { }; missionNamespace setVariable [""%1"", call compile '%2', true];",
        QEGVAR(common,missionData),
        str _hash
    ]
];
