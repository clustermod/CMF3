#include "script_component.hpp"
/*
 * Author: Eric
 * Approximates text width
 * 
 * Arguments:
 * 0: Text <STRING>
 * 1: Scale <NUMBER>
 * 2: Direction (optional, default: 0) <NUMBER>
 * 
 * Return Value:
 * Width <NUMBER>
 * 
 * Example:
 * call cmf_map_fnc_textWidth
 * 
 * Public: Yes
 */
params ["_text", "_scale", ["_direction", 0]];

if (_text isEqualType "") then {
    _text = toArray _text;
};

private _offset = [0, 0];
for "_y" from 1 to count _text do {
    _symbol = [toString [_text select _y - 1]] call FUNC(mapFont);
    _offset = [
        (_offset select 0) + (_symbol select 1) * _scale * cos _direction,
        (_offset select 1) + (_symbol select 1) * _scale * sin _direction
    ];
};

[0, 0] distance _offset;