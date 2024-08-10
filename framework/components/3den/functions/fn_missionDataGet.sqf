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
