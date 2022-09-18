#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes the CC Settings ace menu
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_aceMenu_fnc_menuinit
 *
 * Public: No
 */
SCRIPT(init);
if (!hasInterface) exitWith {};

/* Waituntil player is alive */
waitUntil { alive player };

/* Add configurable hotkeys */
["EMF Common", QGVAR(toggleHUD), ["Toggle HUD", "Toggles HUD so you can take pretty screenshots :)"], {}, FUNC(toggleHUDAction), [15, [false, true, false]]] call CBA_fnc_addKeybind;

/* Menu items for the selfActions menu */
private _childrenSelf = {
    private _actions = [];

    /* Fix endless loading bug Action */
    _actions pushBack ([QGVAR(loadingbug), "Fix loading bug", "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixLoadingBug) }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);

    /* Fix Map Bug Action */
    _actions pushBack ([QGVAR(mapbug), "Fix map stuck bug", "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixMapAction) }, { true }] call ace_interact_menu_fnc_createAction);

    /* Disable safestart action */
    _actions pushBack ([QGVAR(safestart_menu), "Disable Safestart", "rsc\data\icon_ace_startgame_ca.paa", {
        private _actions = [];

        /* Disable instantly */
        _actions pushBack ([QGVAR(safestart_instant), "Instant", "rsc\data\icon_ace_instant_ca.paa", { missionNamespace setVariable [QEGVAR(gameplay,safestart_disable), true, true] }, { true }] call ace_interact_menu_fnc_createAction);

        /* Delayed disable */
        _actions pushBack ([QGVAR(safestart_delayed), "Delayed", "rsc\data\icon_ace_delayed_ca.paa", { _this call FUNC(delayedSafestartAction) }, { true }] call ace_interact_menu_fnc_createAction);

        _actions;
    }, { !(missionNamespace getVariable [QEGVAR(gameplay,safestart_disable)]) }] call ace_interact_menu_fnc_createAction);

    /* Player Role List Action */
    _actions pushBack ([QGVAR(submitAAR), "Show player roles", "rsc\data\icon_ace_team_ca.paa", { _this call FUNC(displayRolesAction) }, { true }] call ace_interact_menu_fnc_createAction);

    /* After Action Report Action */
    _actions pushBack ([QGVAR(submitAAR), "Submit After Action Report", "rsc\data\icon_ace_debrief_ca.paa", { _this call FUNC(submitReportAction) }, { true }] call ace_interact_menu_fnc_createAction);

    /* Hide HUD Action */
    _actions pushBack ([QGVAR(toggleHUD), "Toggle HUD", "rsc\data\icon_viewDistance_ca.paa", { _this call FUNC(toggleHUDAction) }, { true }] call ace_interact_menu_fnc_createAction);

    /* Open View Distance Action */
    _actions pushBack ([QGVAR(viewDistance), "View Distance Settings","rsc\data\icon_viewDistance_ca.paa", { _this call FUNC(viewDistanceAction) }, { true }] call ace_interact_menu_fnc_createAction);

    _actions;
};

/* Menu items for the zeusActions menu */
private _childrenZeus = {
    private _actions = [];

    /* Disable safestart action */
    _actions pushBack ([QGVAR(safestart_menu), "Disable Safestart", "rsc\data\icon_ace_startgame_ca.paa", {
        private _actions = [];

        /* Disable instantly */
        _actions pushBack ([QGVAR(safestart_instant), "Instant", "rsc\data\icon_ace_instant_ca.paa", { missionNamespace setVariable [QEGVAR(gameplay,disable), true, true] }, { true }] call ace_interact_menu_fnc_createAction);

        /* Delayed disable */
        _actions pushBack ([QGVAR(safestart_delayed), "Delayed", "rsc\data\icon_ace_delayed_ca.paa", { _this call FUNC(delayedSafestartAction) }, { true }] call ace_interact_menu_fnc_createAction);

        _actions;
    }, { !(missionNamespace getVariable [QEGVAR(gameplay,safestart_disable)]) }] call ace_interact_menu_fnc_createAction);

    /* Fix endless loading bug Action */
    _actions pushBack ([QGVAR(loadingbug), "Fix loading bug", "rsc\data\icon_ace_bug_ca.paa", { _this call FUNC(fixLoadingBug) }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);

    _actions;
};

private _selfAction = [QGVAR(main), "CC Menu", "rsc\data\icon_ace_settings_ca.paa", _childrenSelf, { true }] call ace_interact_menu_fnc_createAction;
private _zeusAction = [QGVAR(main), "CC Menu", "rsc\data\icon_ace_settings_ca.paa", _childrenZeus, { true }] call ace_interact_menu_fnc_createAction;

/* Add actions */
[typeOf player, 1, ["ACE_SelfActions"], _selfAction] call ace_interact_menu_fnc_addActionToClass;
[["ACE_ZeusActions"], _zeusAction] call ace_interact_menu_fnc_addActionToZeus;
