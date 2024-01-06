#include "script_component.hpp"
/*
 * Author: Eric
 * Parses ORBAt array into CBA Hash
 * 
 * Arguments:
 * 0: ORBAT Array <ARRAY>
 * 
 * Return Value:
 * Groups Hash
 * 
 * Example:
 * [_orbat] call cmf_organization_fnc_parseOrbat
 * 
 * Public: Yes
 */
params ["_orbat"];

private _orbatArr = [_orbat apply {
    [_x select 0, [[((_x select 1) select 0) apply {
        [_x select 0, [(_x select 1) select 0, [(_x select 1) select 1] call CBA_fnc_hashCreate]];
    }] call CBA_fnc_hashCreate, (_x select 1) select 1]];
}] call CBA_fnc_hashCreate;

_orbatArr;