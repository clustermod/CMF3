#include "script_component.hpp"
/*
 * Author: Eric
 * Draws an arrow on the map. Should be called from event "cmf_map_drawArrow".
 * 
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Arrow Parameters <ARRAY>
 *	- 0: Direction <NUMBER>
 *	- 1: Length <NUMBER>
 *	- 2: Width <NUMBER>
 *	- 3: Thickness <NUMBER>
 * 2: Arrow Visual <ARRAY>
 *	- 0: Color <STRING>
 *	- 1: Alpha <NUMBER>
 * 3: Arrow Text (optional) <ARRAY>
 *	- 0: Text <STRING>
 *	- 1: Offset <STRING>
 *	- 2: Color <STRING>
 *	- 3: Alpha <NUMBER>
 * 
 * Return Value:
 * Marker Array <ARRAY>
 * 
 * Example:
 * [arrowPosition, [270, 300, 10, 100], ["ColorRed", 1]] call cmf_map_fnc_drawArrow
 * 
 * Public: No
 */
params ["_position", "_arrowParameters", "_arrowVisual", "_arrowText"];
_arrowParameters params ["_direction", "_length", "_width", "_thickness"];
_arrowVisual params ["_color", "_alpha"];

private _positionArray = [_position];
{
    _positionArray set [count _positionArray,
        [
            (_position select 0) + sin (270 + _direction + (_x select 0)) * sqrt (_x select 1),
            (_position select 1) + cos (270 + _direction + (_x select 0)) * sqrt (_x select 1)

        ]
    ];
} forEach [
    [-_width atan2 -_width, 2 * _width ^ 2],
    [-_width atan2 (_width / -2), 1.25 * _width ^ 2],
    [-_length atan2 (_width / -2), _length ^ 2 + (_width / 2) ^ 2],
    [-(_length atan2 (_width / 2)), _length ^ 2 + (_width / 2) ^ 2],
    [-(_width atan2 (_width / 2)), 1.25 * _width ^ 2],
    [-(_width atan2 _width), 2 * _width ^ 2]
];

_positionArray set [count _positionArray, _position];

private _markerArray = [
    _positionArray,
    _thickness,
    [_color, _alpha]
] call FUNC(drawBorder);

private "_markerTextArray";
if (!isNil "_arrowText") then {
    private ["_symbol", "_textOffset", "_textDirection"];
    _arrowText params ["_text", "_textPosition", "_textColor", ["_textAlpha", 1]];

    private _textLength = 0;
    {
        _symbol = toString [_x] call FUNC(mapFont);
        _textLength = _textLength + (_symbol select 1) * _width / 30;
    } forEach toArray _text;

    if (_direction / 360 mod 1 <= 0.5) then {
        _textDirection = 90 - _direction;
        call {
            if (_textPosition isEqualTo "front") exitWith {
                _textOffset = _width + _textLength;
            };
            if (_textPosition isEqualTo "back") exitWith {
                _textOffset = _length;
            };
            if (_textPosition isEqualTo "center") exitWith {
                _textOffset = (_length + _textLength) / 2;
            };
        };
    } else {
        _textDirection = -90 - _direction;
        call {
            if (_textPosition isEqualTo "front") exitWith {
                _textOffset = _width;
            };
            if (_textPosition isEqualTo "back") exitWith {
                _textOffset = _length - _textLength;
            };
            if (_textPosition isEqualTo "center") exitWith {
                _textOffset = (_length - _textLength) / 2;
            };
        };
    };

    _markerTextArray = [
        [
            (_position select 0) + sin (180 + _direction) * _textOffset,
            (_position select 1) + cos (180 + _direction) * _textOffset
        ],
        [_textDirection, _width / 30],
        [_text, _textColor, _textAlpha]
    ] call FUNC(writeText);
} else {
    _markerTextArray = [];
};

{
    _markerArray set [count _markerArray, _x];
} forEach _markerTextArray;

_markerArray