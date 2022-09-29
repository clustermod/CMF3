#include "script_component.hpp"
/*
 * Author: Eric
 * Get settings from GUI and update viewdistance
 *
 * Arguments:
 * 0: Variable Type <STRING>
 * 1: TextCtrl <CONTROL>
 * 2: ListCtrl <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["foot", _myTextCtrl, _myListCtrl] call cmf_viewdistance_fnc_LBsetSyncMode
 *
 * Public: No
 */
SCRIPT(onEBterrainInput);

private _varType = [_this, 0, "", [""]] call BIS_fnc_param;
private _textCtrl = [_this, 1, controlNull, [0, controlNull]] call BIS_fnc_param;
private _listbox = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;

private _textValue = [ctrlText _textCtrl, "0123456789."] call BIS_fnc_filterString;
_textValue = if (_textValue == "") then {50} else {call compile _textValue min 50 max 3.125};

_textValue = _textValue min 48.99;

/* update listbox */
private _listboxCtrl = (finddisplay 2900) displayCtrl _listbox;
/* remove EH not to cause huge lag */
_listboxCtrl ctrlRemoveAllEventHandlers "LBSelChanged";
private _sel = switch (true) do {
	case (_textValue >= 49): {0};
	case (_textValue >= 48.99): {1};
	case (_textValue >= 25): {2};
	case (_textValue >= 12.5): {3};
	case (_textValue >= 3.125): {4};
	default {1};
};
_listboxCtrl lbSetCurSel (_sel - 1);
/* add EH again */
_listboxCtrl ctrlSetEventHandler ["LBSelChanged",
	format ["[_this select 1, '%1', %2] call cmf_viewdistance_fnc_onLBSelChanged", _varType, _textCtrl]
];

call compile format ["%1 = %2",_varType, _textValue];
call compile format ["profileNamespace setVariable ['%1',%1]", _varType];

switch (GVAR(vehType)) do {
	case 0: {setTerrainGrid GVAR(footTerrain)};
	case 1: {setTerrainGrid GVAR(carTerrain)};
	case 2: {setTerrainGrid GVAR(airTerrain)};
};
