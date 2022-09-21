#include "script_component.hpp"
/*
 * Author: Eric
 * Handle increasing / decreasing terrain quality by hotkey
 *
 * Arguments:
 * 0: Update type (0: decrease, 1: increase) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [0] call cmf_viewdistance_fnc_keyDown
 *
 * Public: No
 */
SCRIPT(keyDownTerrain);

if (GVAR(keyDown)) exitWith {};
GVAR(keyDown) = true;

private ["_vehTypeString"];
private _updateType = [_this, 0, 0, [0]] call BIS_fnc_param;
if (_updateType isEqualTo 0) exitWith {};
private _terrainGridArray = [50, 48.99, 25, 12.5, 3.125];

if (!isNull (findDisplay 2900)) then {call FUNC(openDialog)};

switch (GVAR(vehType)) do {
	case 1: {
		_vehTypeString = "car";
	};
	case 2: {
		_vehTypeString = "air";
	};
	default {
		_vehTypeString = "foot";
	};
};

private _terrainGridVar = "cmf_viewdistance_" + _vehTypeString + "Terrain";
private _terrainGrid = call compile _terrainGridVar;
private _terrainIndex = switch (true) do {
	case (_terrainGrid >= 49): {0};
	case (_terrainGrid >= 48.99): {1};
	case (_terrainGrid >= 25): {2};
	case (_terrainGrid >= 12.5): {3};
	case (_terrainGrid >= 3.125): {4};
	default {1};
};
_terrainIndex = (_terrainIndex + _updateType) max 0 min 4 max 1;
_terrainGrid = _terrainGridArray select _terrainIndex min 48.99;

call compile format ["%1 = %2", _terrainGridVar, _terrainGrid];
call compile format ["profileNamespace setVariable ['%1',%1]", _terrainGridVar];

switch (GVAR(vehType)) do {
	case 0: {setTerrainGrid GVAR(footTerrain)};
	case 1: {setTerrainGrid GVAR(carTerrain)};
	case 2: {setTerrainGrid GVAR(airTerrain)};
};

private _terrainString = "";
for "_i" from (37.125) to 3.125 step -1 do {
	if (round ((sqrt _terrainGrid) * 10) -18  >= 53 / 37.125 * _i) then {
		_terrainString = _terrainString + "·";
	} else {
		_terrainString = _terrainString + "I";
	};
};

private _terrainQualityArray = [
	"Low",
	"Standard",
	"High",
	"Very High",
	"Ultra"
];
private _terrainQuality = _terrainQualityArray select _terrainIndex;

hintSilent parseText format [
	"<t align='left' size='1.33'>
		%2: <t align='right'>%3</t>
		<br />
		%4: <t align='right'>%5</t>
		<br />
		<t size='2' shadow='0' color='%1'>%6</t>
	</t>",
	[
		profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843], profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019], profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862],
		profilenamespace getvariable ['GUI_BCG_RGB_A',0.7]
	] call BIS_fnc_colorRGBAtoHTML,
	"Terrain Quality",
	_terrainQuality,
	"Terrain Grid",
	_terrainGrid,
	_terrainString
];

terminate (missionNamespace getVariable [QGVAR(hintHandle), scriptNull]);
GVAR(hintHandle) = [] spawn {
	uiSleep 2;
	hintSilent "";
};

[] spawn {
	uiSleep 0.05;
	GVAR(keyDown) = false;
};
