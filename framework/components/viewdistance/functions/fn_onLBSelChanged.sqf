#include "script_component.hpp"
/*
 * Author: Eric
 * Update terrain quality
 *
 * Arguments:
 * 0: Index <NUMBER>
 * 1: Variable Type <STRING>
 * 2: Textbox <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1, "foot", _myTextCtrl, _mySliderCtrl, _mySliderTextCtrl] call cmf_viewdistance_fnc_LBsetSyncMode
 *
 * Public: No
 */
SCRIPT(onLBSelChanged);

private ["_terrainGrid"];
private _index = _this select 0;
private _varType = _this select 1;
private _text = _this select 2;

_index = _index + 1;

switch (_index) do {
    case 0: {_terrainGrid = 50};
    case 1: {_terrainGrid = 48.99};
    case 2: {_terrainGrid = 25};
    case 3: {_terrainGrid = 12.5};
    case 4: {_terrainGrid = 3.125};
};

_terrainGrid = _terrainGrid min 48.99;
ctrlSetText [_text, str _terrainGrid];
call compile format ["%1 = %2",_varType, _terrainGrid];
call compile format ["profileNamespace setVariable ['%1',%1]", _varType];

switch (GVAR(vehType)) do {
    case 0: {setTerrainGrid GVAR(footTerrain)};
    case 1: {setTerrainGrid GVAR(carTerrain)};
    case 2: {setTerrainGrid GVAR(airTerrain)};
};
