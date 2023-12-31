#include "script_component.hpp"
/*
 * Author: Eric
 * Returns the closest match from array
 * 
 * Arguments:
 * 0: Array of Numbers <ARRAY>
 * 1: Number to match <NUMBER>
 * 
 * Return Value:
 * Nearest Match <NUMBER>
 * 
 * Example:
 * [] call cmf_common_fnc_nearestNumber
 * 
 * Public: Yes
 */

params ["_arr", "_number"];

private _max = -log 0;
private _nearest = [0,0,0];

{
    private _dist = abs (_x - _number);
    if (_dist < _max) then {
        _max = _dist; 
        _nearest = _x;
    };
} count _arr;

_nearest;