#include "script_component.hpp"
/*
 * Author: Gekkibi, Eric
 * Simulates authentic map by not showing the entire map.
 * 
 * Arguments:
 * 0: Center <ARRAY>
 * 1: Size <ARRAY>
 *	- Width <NUMBER>
 *	- Height <NUMBER>
 * 2: Topbar Text <ARRAY>
 *	- Left <STRING>
 *	- Center <STRING>
 *	- Right <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [_centerPos, [1000, 1000]] call cmf_map_fnc_coverMap
 * 
 * Public: Yes
 */
if (!hasInterface || !local player) exitWith {};

#define mapAdjustment worldSize * 2 + 10000
#define SCALE(var1) (sqrt ((_size select 0) * (_size select 1)) * 0.000089663) * var1

params ["_position", "_size", "_topBar"];

if is3DEN exitWith {
    for "_y" from 1 to 9001 do {
        _marker = QGVAR(markerID_) + str _y;
        if (markerShape _marker isEqualTo "") exitWith {};
    };

    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerSizeLocal [(_size select 0) / 2, (_size select 1) / 2];
    _marker setMarkerColorLocal "ColorBlack";
    _marker setMarkerBrushLocal "Border";
};

private "_marker";

{
    for "_y" from 1 to 9001 do {
        _marker = QGVAR(markerID_) + str _y;
        if (markerShape _marker isEqualTo "") exitWith {};
    };
    createMarkerLocal [_marker, [(_position select 0) + (_x select 0 select 0), (_position select 1) + (_x select 0 select 1)]];
    _marker setMarkerShapeLocal "RECTANGLE";
    _marker setMarkerSizeLocal (_x select 1);
    _marker setMarkerColorLocal (_x select 2 select 0);
    _marker setMarkerBrushLocal (_x select 2 select 1);
} forEach [
    // blackout box
    [[(_size select 0) / -2 - mapAdjustment, 0], [mapAdjustment, mapAdjustment], ["ColorBlack", "SolidFull"]],
    [[(_size select 0) / 2 + mapAdjustment, 0], [mapAdjustment, mapAdjustment], ["ColorBlack", "SolidFull"]],
    [[0, (_size select 1) / 2 + mapAdjustment], [mapAdjustment, mapAdjustment], ["ColorBlack", "SolidFull"]],
    [[0, (_size select 1) / -2 - mapAdjustment], [mapAdjustment, mapAdjustment], ["ColorBlack", "SolidFull"]],
    // borders
    [[(_size select 0) / -2 - SCALE(140), 0], [SCALE(140), (_size select 1) / 2], ["ColorWhite", "SolidFull"]],
    [[(_size select 0) / 2 + SCALE(140), 0], [SCALE(140), (_size select 1) / 2], ["ColorWhite", "SolidFull"]],
    [[0, (_size select 1) / 2 + SCALE(300)], [(_size select 0) / 2 + 2 * SCALE(140), SCALE(300)], ["ColorWhite", "SolidFull"]],
    [[0, (_size select 1) / -2 - SCALE(1500)], [(_size select 0) / 2 + 2 * SCALE(140), SCALE(1500)], ["ColorWhite", "SolidFull"]],
    // map border
    [[0, 0], [(_size select 0) / 2, (_size select 1) / 2], ["ColorBlack", "Border"]]
];

private _x1 = (_position select 0) - (_size select 0) / 2;
private _x2 = (_position select 0) + (_size select 0) / 2;
_x1 = _x1 + (100 - _x1 % 100);
_x2 = _x2 - _x2 % 100;

private _y1 = (_position select 1) - (_size select 1) / 2;
private _y2 = (_position select 1) + (_size select 1) / 2;
_y1 = _y1 + (100 - _y1 % 100);
_y2 = _y2 - _y2 % 100;

/* Draw Latitude Grid Numbers */
for "_i" from _x1 to _x2 step 100 do {
    private _symbol = str (_i / 100);

    for "-" from 0 to 2 - count _symbol do {
        _symbol = "0" + _symbol;
    };

    private _scale = SCALE(4);
    private _yOffset = (15 * _scale);

    private _textWidth = 0;
    for "_i" from 0 to count _symbol do {
        _textWidth = _textWidth + ((_symbol select [_i, _i + 1] call FUNC(mapFont)) select 1) * _scale;
    };

    if (_i % 1000 isNotEqualTo 0) then {
        _scale = SCALE(2.5);
        _symbol = _symbol select [count _symbol - 1, count _symbol];
        _textWidth = 0;
        _yOffset = 0;
    };

    [
        [_i - _textWidth / 2, ((_position select 1) + 22 * _scale + (_size select 1) / 2) + _yOffset],
        [0, _scale],
        [_symbol, "ColorBlack", 1]
    ] call FUNC(writeText);

    [
        [_i - _textWidth / 2, ((_position select 1) - 22 * _scale - (_size select 1) / 2) - _yOffset],
        [0, _scale],
        [_symbol, "ColorBlack", 1]
    ] call FUNC(writeText);
};

/* Draw Longitude Grid Numbers */
for "_i" from _y1 to _y2 step 100 do {
    private _symbol = str (_i / 100);

    for "-" from 0 to 2 - count _symbol do {
        _symbol = "0" + _symbol;
    };

    private _scale = SCALE(4);
    private _textWidth = 0;
    for "_i" from 0 to count _symbol do {
        _textWidth = _textWidth + ((_symbol select [_i, _i + 1] call FUNC(mapFont)) select 1) * _scale;
    };

    if (_i % 1000 isNotEqualTo 0) then {
        _scale = SCALE(2.5);
        _symbol = _symbol select [count _symbol - 1, count _symbol];
        _textWidth = 0;
    };

    [
        [((_position select 0) + 22 * _scale + (_size select 0) / 2) , _i],
        [0, _scale],
        [_symbol, "ColorBlack", 1]
    ] call FUNC(writeText);

    [
        [((_position select 0) - 22 * _scale - (_size select 0) / 2) - _textWidth, _i],
        [0, _scale],
        [_symbol, "ColorBlack", 1]
    ] call FUNC(writeText);
};

if (isNil "_topBar" || { count _topBar != 3 }) then {
    _mapName = getText (configFile >> "CfgWorlds" >> worldName >> "description");
    _topBar = [_mapName, format ["%1 topographic map", _mapName], ""];
};

{
    private "_scale";
    private "_textPos";
    private "_textWidth";

    if (_forEachIndex isEqualTo 0) then {
        _scale = SCALE(7);
        _textWidth = ([_x, _scale] call FUNC(textWidth));
        _textPos = _x1;
    };

    if (_forEachIndex isEqualTo 1) then {
        _scale = SCALE(9);
        _textWidth = ([_x, _scale] call FUNC(textWidth));
        _textPos = _x1 + ((_x2 - _x1) / 2 - _textWidth / 2);
    };

    if (_forEachIndex isEqualTo 2) then {
        _scale = SCALE(7);
        _textWidth = ([_x, _scale] call FUNC(textWidth));
        _textPos = (_x2 - _textWidth);
    };

    [
        [_textPos, ((_position select 1) + SCALE(396) + (_size select 1) / 2)],
        [0, _scale],
        [_x, "ColorBlack", 1]
    ] call FUNC(writeText);
} forEach _topBar;