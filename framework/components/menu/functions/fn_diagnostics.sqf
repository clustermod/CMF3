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
 * call cmf_menu_fnc_diagnostics
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
        private _action = ([QGVAR(fps), "FPS:", "a3\ui_f\data\gui\rsc\rscdisplayoptionsvideo\icon_performance.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            private _longestFrame = missionNamespace getVariable [QEGVAR(diagnostic,longestFrame), "?"];
            private _shortestFrame = missionNamespace getVariable [QEGVAR(diagnostic,shortestFrame), "?"];
            (_this select 3) set [1, format ["FPS: %1 (%2s - %3s)", diag_fps, _shortestFrame, _longestFrame]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Spawned scripts */
        private _action = ([QGVAR(fps), "Spawned Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["Spawn Scripts: %1", diag_activeScripts select 0]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* execVM scripts */
        private _action = ([QGVAR(fps), "ExecVM Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["ExecVM Scripts: %1", diag_activeScripts select 1]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* exec scripts */
        private _action = ([QGVAR(fps), "Exec Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["Exec Scripts: %1", diag_activeScripts select 2]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* execFSM scripts */
        private _action = ([QGVAR(fps), "ExecFSM Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
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
        private _action = ([QGVAR(fps), "FPS:", "a3\ui_f\data\gui\rsc\rscdisplayoptionsvideo\icon_performance.paa", {  }, { true }, {}, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["FPS: %1", missionNamespace getVariable [QEGVAR(diagnostic,serverFPS), "?"]]];
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Spawned scripts */
        private _action = ([QGVAR(fps), "Spawned Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["Spawn Scripts: %1", (missionNamespace getVariable [QEGVAR(diagnostic,serverScripts), ["?","?","?","?"]]) select 0]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* execVM scripts */
        private _action = ([QGVAR(fps), "ExecVM Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["ExecVM Scripts: %1", (missionNamespace getVariable [QEGVAR(diagnostic,serverScripts), ["?","?","?","?"]]) select 1]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* exec scripts */
        private _action = ([QGVAR(fps), "Exec Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["Exec Scripts: %1", (missionNamespace getVariable [QEGVAR(diagnostic,serverScripts), ["?","?","?","?"]]) select 2]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* execFSM scripts */
        private _action = ([QGVAR(fps), "ExecFSM Scripts:", "a3\3den\data\cfgwaypoints\scripted_ca.paa", {  }, { true }, { }, [], "", 4, [false, false, false, true, false], {
            (_this select 3) set [1, format ["ExecFSM Scripts: %1", (missionNamespace getVariable [QEGVAR(diagnostic,serverScripts), ["?","?","?","?"]]) select 3]]
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        _actions;
    }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* Error Count */
    private _action = ([QGVAR(fps), "Errors: 0", ["a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa", (EGVAR(common,notificationColors) get "ERROR") call BIS_fnc_colorRGBtoHTML], { }, { true }, { }, [], "", 4, [false, false, false, true, false], {
        (_this select 3) set [1, format ["Errors: %1", count EGVAR(diagnostic,errorOut)]]
    }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    _actions;
}] call ace_interact_menu_fnc_createAction);

_action;