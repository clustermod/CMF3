#include "script_component.hpp"
/*
 * Author: Eric
 * Parses CBA keybinds to strings
 *
 * Arguments:
 * 0: CBA Keybind <ARRAY>
 *
 * Return Value:
 * Keybind string <STRING>
 *
 * Example:
 * [[33, [false, true, false]]] call cmf_utility_fnc_keybindToString
 *
 * Public: Yes
 */
params["_keybind"];

private _dikCode = _keybind select 0;
(_keybind select 1) params ["_shift", "_ctrl", "_alt"];

_keyString = call compile keyName _dikCode;

if (_shift && {_dikCode != 42}) then {
    _keyString = format ["Shift + %1", _keyString];
};

if (_alt && {_dikCode != 56}) then {
    _keyString = format ["Alt + %1", _keyString];
};

if (_ctrl && {_dikCode != 29}) then {
    _keyString = format ["Ctrl + %1", _keyString];
};

_keyString
