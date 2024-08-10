#include "script_component.hpp"
/*
 * Author: Eric
 * Removes a line to a 3den entity's init
 *
 * Arguments:
 * 0: 3DEN Entity <OBJECT>
 * 1: Line to remove <STRING>
 *
 * Return Value:
 * Deleted Success <BOOLEAN>
 *
 * Example:
 * [_entity, "this allowDamage false"] call cmf_3den_fnc_removeFromInit
 *
 * Public: No
 */

params ["_entity", "_line"];

private _init = (_entity get3DENAttribute "Init") select 0;

private _index = _init find _line;
if (_index isEqualTo -1) exitWith { false };
private _p1 = _init select [0, _index];

private _deleteRange = count _line + _index;
if (_init select [count _line + _index, 1] isEqualTo ";") then {
    _deleteRange = count _line + 1 + _index;
};
private _p2 = _init select [_deleteRange, count _init];

_init = _p1 + _p2 splitString toString [13, 10];
_init = _init select { _x != " " && { _x != "" } };
_init = _init joinString toString [13, 10];

_entity set3DENAttribute ["Init", _init];
true;