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

/* Waituntil player is alive */
waitUntil { alive player && !isNull player };

/* Add configurable hotkeys */
["CMF Common", QGVAR(toggleHUD), [LSTRING(toggle_hud_displayname), LSTRING(toggle_hud_tooltip)], {}, FUNC(toggleHUDAction), [15, [false, true, false]]] call CBA_fnc_addKeybind;

/* Menu items for the selfActions menu */
private _childrenSelf = {
    params ["_target"];
    private _actions = [];

    /* Fix endless loading bug Action */
    private _action = ([QGVAR(loadingbug), LSTRING(loading_bug_displayname), "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixLoadingBug) }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];
    /* Fix Map Bug Action */
    private _action = ([QGVAR(mapbug), LSTRING(map_bug_displayname), "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixMapAction) }, { true }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* Disable safestart action */
    private _action = ([QGVAR(safestart_menu), LSTRING(disable_safestart_displayname), "rsc\data\icon_ace_startgame_ca.paa", {}, { is3DENPreview || (!(missionNamespace getVariable ["EMF_missionSafeStart", false]) && !isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0 && !(missionNamespace getVariable ["EMF_missionSafeStart", false])) }, {
        private _actions = [];

        /* Disable instantly */
        private _action = ([QGVAR(safestart_instant), LSTRING(instant_displayname), "rsc\data\icon_ace_instant_ca.paa", { missionNamespace setVariable [QEGVAR(gameplay,safestart_disable), true, true] }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Delayed disable */
        private _action = ([QGVAR(safestart_delayed), LSTRING(delayed_displayname), "rsc\data\icon_ace_delayed_ca.paa", { _this call FUNC(delayedSafestartAction) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        _actions;
    }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* Report Bug action */
    private _action = ([QGVAR(reportBug), ELSTRING(3den,report_bug), "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", { createDialog "cmf_utility_reportBug" }, { true }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* After Action Report Action */
    private _action = ([QGVAR(submitAAR), LSTRING(aar_displayname), "rsc\data\icon_ace_debrief_ca.paa", { _this call EFUNC(utility,submitAAR) }, { (serverName isEqualTo "Clustercommunity") }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* Player Role List Action */
    private _action = ([QGVAR(submitAAR), LSTRING(player_roled_displayname), "rsc\data\icon_ace_team_ca.paa", { _this call FUNC(displayRolesAction) }, { true }] call ace_interact_menu_fnc_createAction);
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

    /* Disable safestart action */
    private _action = ([QGVAR(safestart_menu), LSTRING(disable_safestart_displayname), "rsc\data\icon_ace_startgame_ca.paa", {
        private _actions = [];

        /* Disable instantly */
        private _action = ([QGVAR(safestart_instant), LSTRING(instant_displayname), "rsc\data\icon_ace_instant_ca.paa", { missionNamespace setVariable [QEGVAR(gameplay,disable), true, true] }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        /* Delayed disable */
        private _action = ([QGVAR(safestart_delayed), LSTRING(delayed_displayname), "rsc\data\icon_ace_delayed_ca.paa", { _this call FUNC(delayedSafestartAction) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        _actions;
    }, { !(missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false]) }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* Fix endless loading bug Action */
    private _action = ([QGVAR(loadingbug), LSTRING(loading_bug_displayname), "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixLoadingBug) }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    _actions;
};

private _selfAction = [QGVAR(main), LSTRING(cc_menu_displayname), "rsc\data\icon_ace_settings_ca.paa", {}, { true }, _childrenSelf] call ace_interact_menu_fnc_createAction;
private _zeusAction = [QGVAR(main), LSTRING(cc_menu_displayname), "rsc\data\icon_ace_settings_ca.paa", {}, { true }, _childrenZeus] call ace_interact_menu_fnc_createAction;

/* Add actions */
[typeOf player, 1, ["ACE_SelfActions"], _selfAction] call ace_interact_menu_fnc_addActionToClass;
[["ACE_ZeusActions"], _zeusAction] call ace_interact_menu_fnc_addActionToZeus;

LOG("Added CC menu");

/* Raise event */
[QGVAR(addedMenu), []] call CBA_fnc_localEvent;