#include "script_component.hpp"
/*
 * Author: Eric
 * Checks if a line is in a 3den entity's init
 *
 * Arguments:
 * 0: 3DEN Entity <OBJECT>
 * 1: Line to add <STRING>
 *
 * Return Value:
 * In Init <BOOLEAN>
 *
 * Example:
 * [] call cmf_3den_fnc_inInit
 *
 * Public: No
 */
params ["_entity", "_line"];

private _init = (_entity get3DENAttribute "Init") select 0;
toUpper _line in toUpper _init;