#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes the CC menu in ace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_menu_fnc_init
 *
 * Public: No
 */
SCRIPT(init);

if (!hasInterface) exitWith {};

[{ alive player && !isNull player }, {
    /* Add configurable hotkeys */
    ["CMF: Common", QGVAR(toggleHUD), [LSTRING(toggle_hud_displayname), LSTRING(toggle_hud_tooltip)], {}, FUNC(toggleHUDAction), [15, [false, true, false]]] call CBA_fnc_addKeybind;

    /* Menu items for the selfActions menu */
    private _childrenSelf = {
        params ["_target"];
        private _actions = [];

        /* Bug fixes */
        private _action = ([QGVAR(bug_menu), "Bug Fixes", "rsc\data\icon_ace_bug_ca.paa", {}, { true }, {
            private _actions = [];

            /* Fix endless loading bug Action */
            private _action = ([QGVAR(loadingbug), LSTRING(loading_bug_displayname), "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixLoadingBug) }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);
            _actions pushBack [_action, [], _target];

            /* Suicide action */
            private _action = ([QGVAR(suicide), "Suicide", "a3\ui_f_curator\data\cfgmarkers\kia_ca.paa", {
                _target spawn {
                    private _result = ["Are you sure?", "Confirm", true, true] call BIS_fnc_guiMessage;
                    if (_result) then {
                        player setDamage 1;
                    };
                };
            }, { alive player }] call ace_interact_menu_fnc_createAction);
            _actions pushBack [_action, [], _target];

            _actions;
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Disable safestart action */
        private _action = ([QGVAR(safestart_menu), LSTRING(disable_safestart_displayname), "rsc\data\icon_ace_startgame_ca.paa", {
            _this call FUNC(delayedSafestartAction);
        }, { is3DENPreview || (!(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false]) && !isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0 && !(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false])) }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Diagnostic menu */
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
        _actions pushBack [_action, [], _target];

        /* Report Bug action */
        private _action = ([QGVAR(reportBug), ELSTRING(3den,report_bug), "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", { createDialog EGVAR(utility,reportBug) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* After Action Report Action */
        private _action = ([QGVAR(submitAAR), LSTRING(aar_displayname), "rsc\data\icon_ace_debrief_ca.paa", { _this call EFUNC(aar,submitAAR) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Hide HUD Action */
        private _action = ([QGVAR(toggleHUD), LSTRING(hide_hud_displayname), "rsc\data\icon_ace_viewDistance_ca.paa", { _this call FUNC(toggleHUDAction) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Open View Distance Action */
        private _action = ([QGVAR(viewDistance), LSTRING(viewdistance_displayname), "rsc\data\icon_ace_viewDistance_ca.paa", { _this call FUNC(viewDistanceAction) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        _actions;
    };

    /* Menu items for the zeusActions menu */
    private _childrenZeus = {
        params ["_target"];
        private _actions = [];

        /* Bug fixes */
        private _action = ([QGVAR(bug_menu), "Bug Fixes", "rsc\data\icon_ace_bug_ca.paa", {}, { true }, {
            private _actions = [];

            /* Fix endless loading bug Action */
            private _action = ([QGVAR(loadingbug), LSTRING(loading_bug_displayname), "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixLoadingBug) }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);
            _actions pushBack [_action, [], _target];
            /* Fix Map Bug Action */
            private _action = ([QGVAR(mapbug), LSTRING(map_bug_displayname), "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixMapAction) }, { true }] call ace_interact_menu_fnc_createAction);
            _actions pushBack [_action, [], _target];

            _actions;
        }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Disable safestart action */
        private _action = ([QGVAR(safestart_menu), LSTRING(disable_safestart_displayname), "rsc\data\icon_ace_startgame_ca.paa", {
            _this call FUNC(delayedSafestartAction);
        }, { is3DENPreview || (!(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false]) && !isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0 && !(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false])) }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Diagnostic menu */
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
        _actions pushBack [_action, [], _target];

        /* Report Bug action */
        private _action = ([QGVAR(reportBug), ELSTRING(3den,report_bug), "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", { createDialog EGVAR(utility,reportBug) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* After Action Report Action */
        private _action = ([QGVAR(submitAAR), LSTRING(aar_displayname), "rsc\data\icon_ace_debrief_ca.paa", { _this call EFUNC(aar,submitAAR) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        _actions;
    };

    private _selfAction = [QGVAR(main), LSTRING(cc_menu_displayname), "rsc\data\icon_ace_settings_ca.paa", {}, { true }, _childrenSelf] call ace_interact_menu_fnc_createAction;
    private _zeusAction = [QGVAR(main), LSTRING(cc_menu_displayname), "rsc\data\icon_ace_settings_ca.paa", {}, { true }, _childrenZeus] call ace_interact_menu_fnc_createAction;

    /* Add actions */
    ["CAManBase", 1, ["ACE_SelfActions"], _selfAction] call ace_interact_menu_fnc_addActionToClass;
    [["ACE_ZeusActions"], _zeusAction] call ace_interact_menu_fnc_addActionToZeus;

    LOG("Added CC menu");

    /* Raise event */
    [QGVAR(addedMenu), []] call CBA_fnc_localEvent;
}] call CBA_fnc_waitUntilAndExecute;

