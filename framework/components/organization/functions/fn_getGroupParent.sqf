#include "script_component.hpp"
/*
 * Author: Eric
 * Returns the unit data at given path
 * 
 * Arguments:
 * 0: Path <ARRAY>
 * 
 * Return Value:
 * Unit Data <ARRAY>
 * 
 * Example:
 * [["1", "1", "1", "Alpha"]] call cmf_organization_fnc_getGroupParent
 * 
 * Public: Yes
 */
params ["_path"];

private _value = missionNamespace getVariable [QGVAR(configParameters), ["", [], ([] call CBA_fnc_hashCreate)]];
{
    private _key = _x;
    if !([_value select 2] call CBA_fnc_isHash) exitWith { };
    if !([_value select 2, _key] call CBA_fnc_hashHasKey) exitWith { _value = nil };
    _value = [_value select 2, _key, nil] call CBA_fnc_hashGet;
} forEach _path;