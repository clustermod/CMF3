#include "script_component.hpp"
/*
 * Author: Eric
 * Returns the config parameter at the given path
 *
 * Arguments:
 * 0: Parameter Path <ARRAY>
 *
 * Return Value:
 * Parameter Value <ANY>
 *
 * Example:
 * [["SETTINGS", "init", "CLEAR_VEHICLE_CARGO"]] call emf_common_fnc_getConfigParam
 *
 * Public: Yes
 */

params [["_path", [], [[]]]];

/* If config array doesn't exist already define it and make it global */
if (isNil QGVAR(configParameters)) then {
    missionNamespace setVariable [QGVAR(configParameters), createHashMap, true];
};

/* Check if there is a value in the configparameters variable */
private _value = GVAR(configParameters);
{
    private _key = _x;
    if !(IS_HASHMAP(_value)) exitWith {_value = _value};
    if !(_key in _value) exitWith {_value = nil};
    _value = _value get _key;
} forEach _path;

/* If there is no value defined check the config */
if (isNil "_value") then {
    _value = (["EMF"] + _path) call BIS_fnc_getCfgData;
};

/* If it's still nil return empty string */
if (isNil "_value") then {
    _value = "";
};

_value;
