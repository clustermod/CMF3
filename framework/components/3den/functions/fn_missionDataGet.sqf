#include "script_component.hpp"
/*
 * Author: Eric
 * Sets variables that can be accessed in the mission
 * 
 * Arguments:
 * 0: Variable Name <STRING>
 * 1: Variable Value <ANY>
 * 2: Namespace (optional, default: { missionNameSpace }) <Code>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myVariable", _myValue, missionNameSpace] call cmf_3den_fnc_missionSettings
 * 
 * Public: Yes
 */
params ["_varName", ["_defaultValue", nil]];

/* Find logic */
private _logics = (all3DENEntities select 0) select { (_x get3DENAttribute 'Name') isEqualTo [QGVAR(missionDataLogic)] };
if (count _logics isEqualTo 0) exitWith { _defaultValue; };

private _logic = _logics select 0;

private _logicInit = (_logic get3DENAttribute "Init") select 0;

call compile _logicInit;

private "_hash";
if (!isNil QEGVAR(common,missionData)) then {
    _hash = [EGVAR(common,missionData)] call CBA_fnc_hashCreate;
} else {
    _hash = [] call CBA_fnc_hashCreate;
};

_value = [_hash, _varName, _defaultValue] call CBA_fnc_hashGet;

_value;