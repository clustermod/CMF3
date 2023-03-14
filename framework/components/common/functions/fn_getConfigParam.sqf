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
 * [["SETTINGS", "init", "CLEAR_VEHICLE_CARGO"]] call cmf_common_fnc_getConfigParam
 *
 * Public: Yes
 */
SCRIPT(getConfigParam);
params [["_path", [], [[]]]];

/* Check if there is a value in the configparameters variable */
private _value = missionNamespace getVariable [QGVAR(configParameters), ([] call CBA_fnc_hashCreate)];
{
    private _key = _x;
    if !([_value] call CBA_fnc_isHash) exitWith { };
    if !([_value, _key] call CBA_fnc_hashHasKey) exitWith { _value = nil };
    _value = [_value, _key, nil] call CBA_fnc_hashGet;
} forEach _path;

/* If there is no value defined check the config */
if (isNil "_value") then {
    _value = (["CMF"] + _path) call BIS_fnc_getCfgData;

    /* Update global config hash */
    if (!isNil "_value") then {
        [_path, _value] call FUNC(setConfigParam);
    };
};

/* If it's still nil return empty string */
if (isNil "_value") exitWith {
    _value = "";
};

_value;
