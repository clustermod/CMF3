#include "script_component.hpp"
/*
 * Author: Gekkibi, Eric
 * Draw border on the map
 * 
 * Arguments:
 * 0: Positions <ARRAY>
 * 1: Width <NUMBER>
 * 2: Effect <ARRAY>
 *	- 0: Color <ARRAY>
 *	- 1: Alpha <NUMBER>
 * 3: Texts <ARRAY>
 * 
 * Return Value:
 * Value <TYPE>
 * 
 * Example:
 * call cmf_map_fnc_drawBorder
 * 
 * Public: No
 */
if (!hasInterface || !local player) exitWith {};

params ["_posArray", "_width", "_effect", "_textArray"];

_effect params ["_color", "_alpha"];
private _markerArray = [];

private ["_center", "_direction", "_length", "_marker"];
for "_x" from 0 to count _posArray - 2 do {
    _center = [((_posArray select _x select 0) + (_posArray select _x + 1 select 0)) / 2, ((_posArray select _x select 1) + (_posArray select _x + 1 select 1)) / 2];
    _direction = ((_posArray select _x + 1 select 0) - (_posArray select _x select 0)) atan2 ((_posArray select _x + 1 select 1) - (_posArray select _x select 1));
    _length = sqrt (((_posArray select _x select 0) - (_posArray select _x + 1 select 0)) ^ 2 + ((_posArray select _x select 1) - (_posArray select _x + 1 select 1)) ^ 2);
    for "_y" from 1 to 9001 do {
        _marker = format [QGVAR(markerID_%1), str _y];
        if (markerShape _marker isEqualTo "") exitWith {};
    };

    createMarkerLocal [_marker, _center];
    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerBrushLocal "SolidFull";
    _marker setMarkerSizeLocal [_width / 2, _length / 2];
    _marker setMarkerDirLocal _direction;
    _marker setMarkerAlphaLocal _alpha;
    _marker setMarkerColorLocal _color;
    _markerArray set [count _markerArray, _marker];
};

{
    for "_y" from 1 to 9001 do {
        _marker = format [QGVAR(markerID_%1), str _y];
        if (markerShape _marker isEqualTo "") exitWith {};
    };

    createMarkerLocal [_marker, _x];
    _marker setMarkerShapeLocal "ELLIPSE";
    _marker setMarkerBrushLocal "SolidFull";
    _marker setMarkerSizeLocal [_width / 2, _width / 2];
    _marker setMarkerAlphaLocal _alpha;
    _marker setMarkerColorLocal _color;
    _markerArray set [count _markerArray, _marker];
} forEach _posArray;

if (!isNil "_textArray") then {
    {
        _x params ["_from", "_to", "_text", ["_scale", 1], ["_textOffset", 0], ["_textColor", _color], ["_textAlpha", _alpha]];

        private _lineDir = ((_posArray select _from) getDir (_posArray select _to));
        private _textDir = -(_lineDir - 90);
        private _textWidth = [_text, _scale] call FUNC(textWidth);
        private _textPos = (_posArray select _from) getPos [(((_posArray select _from) distance (_posArray select _to)) / 2) - (_textWidth / 2), _lineDir];
        
        [
            _textPos getPos [_textOffset, _textDir + 90],
            [_textDir, _scale],
            [_text, _textColor, _textAlpha]
        ] call FUNC(writeText);
    } forEach _textArray;
};

_markerArray;