#include "script_component.hpp"
/*
 * Author: Gekkibi, Eric
 * Write text on map locally. Use event to draw for everyone.
 * 
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Placement <ARRAY>
 *	- Direction <NUMBER>
 *	- Scale <NUMBER>
 * 2: Font
 *	- Text <STRING>
 *	- Color <STRING>
 *	- Alpha <NUMBER>
 * 
 * Return Value:
 * Markers <ARRAY>
 * 
 * Example:
 * call cmf_map_fnc_writeText
 * 
 * Public: No
 */
if (!hasInterface || !local player) exitWith {};

params ["_position", "_placement", "_font"];

_placement params ["_direction", "_scale"];
_font params ["_text", "_color", "_alpha"];
private _markerArray = [];
private _offset = [0, 0];

if (_text isEqualType "") then {
    _text = toArray _text;
};

private ["_createMarker", "_marker", "_symbol"];
for "_y" from 1 to count _text do {
    _symbol = [toString [_text select _y - 1]] call FUNC(mapFont);
    {
        private _vectorDirection = (_x select 0 select 0) atan2 (_x select 0 select 1) - _direction;
        private _vectorLength = sqrt ((_x select 0 select 0) ^ 2 + (_x select 0 select 1) ^ 2);
        private _adjustPosition = [sin _vectorDirection * _vectorLength * _scale, cos _vectorDirection * _vectorLength * _scale];
        private _adjustSize = _x select 1;
        private _adjustDirection = (_x select 2) - _direction;
        for "_z" from 1 to 9001 do {
            _marker = format[QGVAR(markerID_%1_%2), str _y, str _z];
            if (markerShape _marker isEqualTo "") exitWith {};
        };

        createMarkerLocal [_marker, [(_position select 0) + (_adjustPosition select 0) + (_offset select 0), (_position select 1) + (_adjustPosition select 1) + (_offset select 1)]];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerBrushLocal "SolidFull";
        _marker setMarkerSizeLocal [_scale, _scale * _adjustSize];
        _marker setMarkerDirLocal _adjustDirection;
        _marker setMarkerAlphaLocal _alpha;
        _marker setMarkerColorLocal _color;
        _markerArray set [count _markerArray, _marker];
    } forEach (_symbol select 0);
    
    _offset = [
        (_offset select 0) + (_symbol select 1) * _scale * cos _direction,
        (_offset select 1) + (_symbol select 1) * _scale * sin _direction
    ];
};

_markerArray;