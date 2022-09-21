#include "script_component.hpp"
/*
 * Author: Eric
 * Open settings dialog
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_viewdistance_openDialog
 *
 * Public: Yes
 */
SCRIPT(openDialog);

[] spawn {
	if (missionNamespace getVariable [QGVAR(loadingDialog),false]) exitWith {true};

	if (isNull (findDisplay 2900)) then {
		private _dialog = createDialog QGVAR(dialog);
		if (!_dialog) exitWith {systemChat "CH View Distance: Error: can't open dialog."};
	};

	disableSerialization;
	GVAR(loadingDialog) = true;

	{
		ctrlSetText _x;
	} forEach [[1006, str round GVAR(foot)],[1007, str round GVAR(footObj)],[1013, str round GVAR(car)],[1014, str round GVAR(carObj)],[1017, str round GVAR(air)],[1018, str round GVAR(airObj)],[1400, str GVAR(footTerrain)],[1401, str GVAR(carTerrain)],[1402, str GVAR(airTerrain)]];

	{
		sliderSetRange [_x select 0, 0, _x select 2];
		sliderSetRange [_x select 3, 0, (_x select 5) min (_x select 1)];
		sliderSetSpeed [_x select 0, 500, 500];
		sliderSetSpeed [_x select 3, 500, 500];
		sliderSetPosition [_x select 0, _x select 1];
		sliderSetPosition [_x select 3, (_x select 4) min (_x select 1)];
	} forEach [[1900,GVAR(foot),GVAR(maxView),1901,GVAR(footObj),GVAR(maxObj)],[1902,GVAR(car),GVAR(maxView),1903,GVAR(carObj),GVAR(maxObj)],[1904,GVAR(air),GVAR(maxView),1905,GVAR(airObj),GVAR(maxObj)]];

	{
		private _ctrl = ((findDisplay 2900) displayCtrl (_x select 0));

		_ctrl lbAdd "Disabled";
		_ctrl lbAdd "Dynamic";
		_ctrl lbAdd "FOV";

		private _mode = call compile ("cmf_viewdistance_" + (_x select 1) + "SyncMode");
		_ctrl lbSetCurSel _mode;

		_ctrl ctrlSetEventHandler ["LBSelChanged",
			format ["[_this select 1, '%1',%2,%3,%4] call cmf_viewdistance_fnc_LBSetSyncMode", _x select 1, _x select 2, _x select 3, _x select 4]
		];
	} forEach [[1404,"foot",1410,1901,1007], [1406,"car",1409,1903,1014], [1408,"air",1411,1905,1018]];

	{
		private _ctrl = _x select 0;
		private _mode = call compile ("cmf_viewdistance_" + (_x select 1) + "SyncMode");

		switch (_mode) do {
			case 1: {
				private _percentage = call compile ("cmf_viewdistance_" + (_x select 1) + "SyncPercentage");
				ctrlSetText [_ctrl, format ["%1",_percentage * 100] + "%"];
				ctrlEnable [_ctrl, true];
			};
			default {
				ctrlEnable [_ctrl, false];
			};

		};
		private _ctrlDisplay = (findDisplay 2900) displayCtrl _ctrl;
		_ctrlDisplay ctrlSetEventHandler ["keyDown",
			format ["[_this select 0, '%1',%2,%3] call cmf_viewdistance_fnc_setInputSyncmode", _x select 1, _x select 2, _x select 3]
		];
	} forEach [[1410,"foot",1901,1007], [1409,"car",1903,1014], [1411,"air",1905,1018]];

	{
		private _ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		_ctrl lbAdd "Standard";
		_ctrl lbAdd "High";
		_ctrl lbAdd "Very High";
		_ctrl lbAdd "Ultra";

		private _sel = switch (true) do {
			case ((_x select 1) >= 49): {0};
			case ((_x select 1) >= 48.99): {1};
			case ((_x select 1) >= 25): {2};
			case ((_x select 1) >= 12.5): {3};
			case ((_x select 1) >= 3.125): {4};
			default {1};
		};
		_ctrl lbSetCurSel (_sel - 1);
	} forEach [[1500,GVAR(footTerrain)],[1501,GVAR(carTerrain)],[1502,GVAR(airTerrain)]];

	{
		private _ctrl = ((findDisplay 2900) displayCtrl (_x select 0));
		_ctrl ctrlSetEventHandler ["LBSelChanged",
			format ["[_this select 1, '%1', %2] call cmf_viewdistance_fnc_onLBSelChanged", _x select 1, _x select 2]
		];
	} forEach [[1500,QGVAR(footTerrain),1400],[1501,QGVAR(carTerrain),1401],[1502,QGVAR(airTerrain),1402]];

	if (GVAR(footSyncMode) isEqualTo 1) then {
		ctrlEnable [1901,false];
		ctrlEnable [1007,false];
	} else {
		ctrlEnable [1901,true];
		ctrlEnable [1007,true];
	};

	if (GVAR(carSyncMode) isEqualTo 1) then {
		ctrlEnable [1903,false];
		ctrlEnable [1014,false];
	} else {
		ctrlEnable [1903,true];
		ctrlEnable [1014,true];
	};

	if (GVAR(airSyncMode) isEqualTo 1) then {
		ctrlEnable [1905,false];
		ctrlEnable [1018,false];
	} else {
		ctrlEnable [1905,true];
		ctrlEnable [1018,true];
	};

	GVAR(loadingDialog) = false;
};
