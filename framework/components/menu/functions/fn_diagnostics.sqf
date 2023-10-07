#include "script_component.hpp"
/*
 * Author: Eric
 * Shows diagnostics
 * 
 * Arguments:
 * 0: Target <OBJECT>
 * 
 * Return Value:
 * Child Action <ARRAY>
 * 
 * Example:
 * [] call cmf_menu_fnc_diagnostics
 * 
 * Public: Yes
 */
params ["_target"];

private _action = ([QGVAR(diag_menu), "Diagnostics", "z\ace\addons\medical_gui\data\categories\advanced_treatment.paa", {}, { true }, {
	private _actions = [];

	/* Client */
	private _action = ([QGVAR(client), "Client", "a3\ui_f\data\gui\rsc\rscdisplaymultiplayersetup\disabledai_ca.paa", {}, { true }, {
		private _actions = [];

		/* FPS */
		private _action = ([QGVAR(fps), "FPS:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["FPS: %1", diag_fps]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* Spawned scripts */
		private _action = ([QGVAR(fps), "Spawned Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["Spawn Scripts: %1", diag_activeScripts select 0]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* execVM scripts */
		private _action = ([QGVAR(fps), "ExecVM Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["ExecVM Scripts: %1", diag_activeScripts select 1]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* exec scripts */
		private _action = ([QGVAR(fps), "Exec Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["Exec Scripts: %1", diag_activeScripts select 2]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* execFSM scripts */
		private _action = ([QGVAR(fps), "ExecFSM Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["ExecFSM Scripts: %1", diag_activeScripts select 3]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		_actions;
	}] call ace_interact_menu_fnc_createAction);
	_actions pushBack [_action, [], _target];

	/* Server */
	private _action = ([QGVAR(server), "Server", "a3\3den\data\displays\display3den\statusbar\server_ca.paa", {}, { !isServer }, {
		private _actions = [];

		/* FPS */
		private _action = ([QGVAR(fps), "FPS:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, {}, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["FPS: %1", missionNamespace getVariable [QEGVAR(main,serverFPS), "?"]]];
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* Spawned scripts */
		private _action = ([QGVAR(fps), "Spawned Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["Spawn Scripts: %1", (missionNamespace getVariable [QEGVAR(main,serverScripts), ["?","?","?","?"]]) select 0]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* execVM scripts */
		private _action = ([QGVAR(fps), "ExecVM Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["ExecVM Scripts: %1", (missionNamespace getVariable [QEGVAR(main,serverScripts), ["?","?","?","?"]]) select 1]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* exec scripts */
		private _action = ([QGVAR(fps), "Exec Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["Exec Scripts: %1", (missionNamespace getVariable [QEGVAR(main,serverScripts), ["?","?","?","?"]]) select 2]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		/* execFSM scripts */
		private _action = ([QGVAR(fps), "ExecFSM Scripts:", "a3\structures_f_argo\commercial\billboards\data\billboard_transparent_co.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
			(_this select 3) set [1, format ["ExecFSM Scripts: %1", (missionNamespace getVariable [QEGVAR(main,serverScripts), ["?","?","?","?"]]) select 3]]
		}] call ace_interact_menu_fnc_createAction);
		_actions pushBack [_action, [], _target];

		_actions;
	}] call ace_interact_menu_fnc_createAction);
	_actions pushBack [_action, [], _target];

	_actions;
}] call ace_interact_menu_fnc_createAction);

_action;