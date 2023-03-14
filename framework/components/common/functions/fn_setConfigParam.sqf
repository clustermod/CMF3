#include "script_component.hpp"
/*
 * Author: Eric
 * Sets a config parameter at the given path
 *
 * Arguments:
 * 0: Parameter Path <ARRAY>
 *
 * Return Value:
 * Parameter Value <ANY>
 *
 * Example:
 * [["SETTINGS", "init", "CLEAR_VEHICLE_CARGO"], 0] call cmf_common_fnc_setConfigParam
 *
 * Public: Yes
 */
SCRIPT(setConfigParam);
params [["_path", [], [[]]], ["_value", nil]];

/* If config array doesn't exist already define it and make it global */
private _root = missionNamespace getVariable [QGVAR(configParameters), [] call CBA_fnc_hashCreate];
private _parents = [_root];
private _parent = _root;

/* Split nested Hashes and create non-existing ones */
{
    if (_forEachIndex isEqualTo count _path - 1) exitWith {  };
    _parent = [_parent, _x, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    _parents PushBack _parent;
} forEach _path;

_parents pushBack _value;
reverse _parents;
reverse _path;

/* Set the new value */
private _child = _parents select 0;
{
    private _parent = _forEachIndex + 1;

    if (_parent > (count _parents - 1)) exitWith { };
    _parent = _parents select _parent;

    _child = [_parent, _path select _forEachIndex, _child] call CBA_fnc_hashSet;
} forEach _parents;

/* Update the global config hash */
missionNamespace setVariable [QGVAR(configParameters), _child, true];
