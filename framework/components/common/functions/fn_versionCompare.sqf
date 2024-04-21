#include "script_component.hpp"
/*
 * Author: Eric
 * Compares to version strings and returns tru if string 2 is larger than string 1
 *
 * Arguments:
 * 0: Version Number 1 <STRING>
 * 1: Version Number 2 <STRING>
 *
 * Return Value:
 * (a0 < a1): 1, (a0 == a1): 0 or (a0 > a1): -1 <NUMBER>
 *
 * Example:
 * ["2.1.0.0", "2.1.1.41"] call cmf_common_fnc_versionCompare
 *
 * Public: Yes
 */

params ["_ver1", "_ver2"];

private _ver1Arr = (_ver1 splitString ".") apply { call compile _x };
private _ver2Arr = (_ver2 splitString ".") apply { call compile _x };

private _ret = 0;

{
    if (count _ver1Arr isEqualTo  _forEachIndex) exitWith { };

    private _seg1 = _ver1Arr select _forEachIndex;
    private _seg2 = _x;

    if (_seg1 < _seg2) exitWith { _ret = 1 };
    if (_seg1 > _seg2) exitWith { _ret = -1 };

} forEach _ver2Arr;

_ret;
