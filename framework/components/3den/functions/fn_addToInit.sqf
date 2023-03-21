#include "script_component.hpp"
/*
 * Author: Eric
 * Adds a line to a 3den entity's init
 *
 * Arguments:
 * 0: 3DEN Entity <OBJECT>
 * 1: Line to add <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_3den_fnc_addToInit
 *
 * Public: No
 */

params ["_entity", "_line"];

private _init = (_entity get3DENAttribute "Init") select 0;
_init = _init splitString toString [13, 10];

if (_line isEqualType {}) then {
	_line = toString _line;
};

if ((_line select [(count _line - 1), 1]) != ";") then {
	_line = [_line, ";"] joinString "";
};

_init pushBack _line;
_init = _init joinString endl;

_entity set3DENAttribute ["Init", _init];