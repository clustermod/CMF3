#include "script_component.hpp"

waitUntil { !isNil { missionNameSpace getVariable QEGVAR(3den,menu_entity) } };

private _path = missionNameSpace getVariable QEGVAR(3den,menu_entity);

/* Action to add a radio rack to a vehicle */
private _acreRadioRackAction = [
	"Add Radio Rack (ACRE)",
	"a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa",
	{
		if (count get3DENSelected "object" == 0) exitWith {
			["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
		};

		private _display3DEN = uiNamespace getVariable "Display3DEN";
		private _display = _display3DEN createDisplay QEGVAR(3den,addRack);

		private _addCtrl = _display displayCtrl 1;
		private _radioCtrl = _display displayCtrl 100;

		{
			private _index = _radioCtrl lbAdd ([(_x select 1) + "_ID_1"] call acre_api_fnc_getDisplayName);
			_radioCtrl lbSetData [_index, str _x];
		} forEach [["ACRE_VRC103", "ACRE_PRC117F"], ["ACRE_VRC64", "ACRE_PRC77"], ["ACRE_VRC110", "ACRE_PRC152"], ["ACRE_VRC111", "ACRE_PRC148"], ["ACRE_SEM90", "ACRE_SEM70"]];
		_radioCtrl lbSetSelected [1, true];

		_addCtrl ctrlAddEventHandler ["ButtonClick", {
			params ["_ctrl"];

			private _display = ctrlParent _ctrl;
			private _vehicles = get3DENSelected "object";
			private _comboCtrl = _display displayCtrl 100;
			private _radio = call compile (_comboCtrl lbData (lbCurSel _comboCtrl));

			if (isNil "_radio") exitWith {
				["You need to select a radio", 1, 1] call BIS_fnc_3DENNotification;
			};

			if (count _vehicles isEqualTo 0) exitWith {
				["You need to select at least one object", 1, 1] call BIS_fnc_3DENNotification;
			};

			{
				private _oldInit = (_x get3DENAttribute "Init") select 0;
				private _newInit = format["[this, {[_this, [""%1"", ""Rack"", ""Rack"", false, [""crew""], [], ""%2"", [], []], true, {}], acre_api_fnc_addRackToVehicle}] remoteExec [""call"", 0, true];", (_radio select 0), (_radio select 1)];

				_x set3DENAttribute ["Init", _oldInit + _newInit];
			} forEach _vehicles;

			["Added radio to vehicles", 0, 1] call BIS_fnc_3DENNotification;
		}];
	}
];

private _simulationAction = [
	LSTRING(toggle_sim_3den_displayName),
	"a3\modules_f\data\editterrainobject\textureunchecked_wall_ca.paa",
	{
		if (count get3DENSelected "object" == 0) exitWith {
			["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
		};
		
		private _selections = get3DENSelected "object";
		private _first = (_selections) select 0;
		private _toggle = (simulationEnabled _first);

		{
			_x enableSimulation _toggle;
		} forEach _selections;

		private _statusText = format ["%1 3DEN Simulation for %2 object(s)", ["Disabled", "Enabled"] select _toggle, count _selections];
		[_statusText, 0, 1] call BIS_fnc_3DENNotification;
	}
];

private _simpleAction = [
	LSTRING(make_obj_simple_displayName),
	"z\ace\addons\zeus\ui\icon_module_zeus_editable_objects_ca.paa",
	{
		if (count get3DENSelected "object" == 0) exitWith {
			["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
		};
		
		{
			_command = toString {
				this spawn {
					private _obj = createSimpleObject[(typeof _this), (getposASL _this), false];
					_obj setVectorDirAndUp [(vectorDir _this), (vectorUp _this)];
					deleteVehicle _this;
				};
			};

			if !([_x, _command] call EFUNC(3den,inInit)) then {            
				[_x, _command] call EFUNC(3den,addToInit);
				_x set3DENAttribute ["enableSimulation", false];
				_x set3DENAttribute ["allowDamage", false];
			} else {
				[_x, _command] call EFUNC(3den,removeFromInit);
				_x set3DENAttribute ["enableSimulation", true];
				_x set3DENAttribute ["allowDamage", true];
			};
		} forEach get3DENSelected "object";

		["Toggled Simplified selected objects", 0, 1] call BIS_fnc_3DENNotification;
	}
];

[
	_path, 
	"General",
	"a3\3den\data\displays\display3den\toolbar\open_ca.paa",
	{},
	[],
	[
		_acreRadioRackAction,
		_simulationAction,
		_simpleAction
	]
] call EFUNC(3den,addMenuItem);

private _carryAction = [
	"Toggle ACE Carryable",
	"z\ace\addons\dragging\ui\icons\box_carry.paa",
	{
		if (count get3DENSelected "object" == 0) exitWith {
			["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
		};

		private _enableCommand = "[this, true] call ace_dragging_fnc_setCarryable";
		private _disableCommand = "[this, fales] call ace_dragging_fnc_setCarryable";
		
		private _selections = get3DENSelected "object";
		private _first = (_selections) select 0;
		private _isSet = ([_first, _enableCommand] call EFUNC(3den,inInit) || [_first, _disableCommand] call EFUNC(3den,inInit));
		private _toggle = ([_first, _enableCommand] call EFUNC(3den,inInit) || !_isSet);

		{
			if (_toggle) then {
				if ([_x, _disableCommand] call EFUNC(3den,inInit)) then {
					[_x, _disableCommand] call EFUNC(3den,removeFromInit);
				};

				[_x, _enableCommand] call EFUNC(3den,addToInit);
			} else {
				if ([_x, _enableCommand] call EFUNC(3den,inInit)) then {
					[_x, _enableCommand] call EFUNC(3den,removeFromInit);
				};

				[_x, _disableCommand] call EFUNC(3den,addToInit);
			};
		} forEach _selections;

		private _statusText = format ["%1 Carrying for %2 object(s)", ["Disabled", "Enabled"] select _toggle, count _selections];
		[_statusText, 0, 1] call BIS_fnc_3DENNotification;
	}
];

private _dragAction = [
	"Toggle ACE Draggable",
	"z\ace\addons\dragging\ui\icons\box_carry.paa",
	{
		if (count get3DENSelected "object" == 0) exitWith {
			["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
		};

		private _enableCommand = "[this, true] call ace_dragging_fnc_setDraggable";
		private _disableCommand = "[this, fales] call ace_dragging_fnc_setDraggable";
		
		private _selections = get3DENSelected "object";
		private _first = (_selections) select 0;
		private _isSet = ([_first, _enableCommand] call EFUNC(3den,inInit) || [_first, _disableCommand] call EFUNC(3den,inInit));
		private _toggle = ([_first, _enableCommand] call EFUNC(3den,inInit) || !_isSet);

		{
			if (_toggle) then {
				if ([_x, _disableCommand] call EFUNC(3den,inInit)) then {
					[_x, _disableCommand] call EFUNC(3den,removeFromInit);
				};

				[_x, _enableCommand] call EFUNC(3den,addToInit);
			} else {
				if ([_x, _enableCommand] call EFUNC(3den,inInit)) then {
					[_x, _enableCommand] call EFUNC(3den,removeFromInit);
				};

				[_x, _disableCommand] call EFUNC(3den,addToInit);
			};
		} forEach _selections;

		private _statusText = format ["%1 Dragging for %2 object(s)", ["Disabled", "Enabled"] select _toggle, count _selections];
		[_statusText, 0, 1] call BIS_fnc_3DENNotification;
	}
];

[
	_path, 
	"ACE3",
	"z\ace\addons\common\data\logo_ace3_ca.paa",
	{},
	[],
	[
		_carryAction,
		_dragAction
	]
] call EFUNC(3den,addMenuItem);