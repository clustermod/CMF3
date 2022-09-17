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
scriptName "functions\aceMenu\fn_menuInit.sqf";

if (!hasInterface) exitWith {};

[] spawn {
    private["_CCSettingMenu"];
    while {true} do {
        waitUntil{
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS"]] call ace_interact_menu_fnc_findActionNode)}) ||
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_endLoadingScreen"]] call ace_interact_menu_fnc_findActionNode)}) ||
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_fix_map"]] call ace_interact_menu_fnc_findActionNode)}) ||
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_display_roles"]] call ace_interact_menu_fnc_findActionNode)}) ||
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_start_game_category"]] call ace_interact_menu_fnc_findActionNode)}) ||
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_report_performance"]] call ace_interact_menu_fnc_findActionNode)}) ||
            (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "tawvd_menu"]] call ace_interact_menu_fnc_findActionNode)})
        };

        /* Add parent settings menu if not exists */
        if (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS"]] call ace_interact_menu_fnc_findActionNode)}) then {
            _CCSettingMenu = ["EMF_BUGACTIONS", "CC Menu", "rsc\data\icon_settings_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
            [(typeOf player), 1, ["ACE_SelfActions"], _CCSettingMenu] call ace_interact_menu_fnc_addActionToClass;
        };

        /* Add parent Zeus settings menu if not exists */
        if (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_ZeusActions","EMF_BUGACTIONS"]] call ace_interact_menu_fnc_findActionNode)}) then {
            _CCSettingMenu = ["EMF_BUGACTIONS", "CC Menu", "rsc\data\icon_settings_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
            [["ACE_ZeusActions"], _CCSettingMenu] call ace_interact_menu_fnc_addActionToZeus;
        };

        [] call emf_aceMenu_fnc_createEndLoadingAction;
        [] call emf_aceMenu_fnc_createMapsFixAction;
        [] call emf_aceMenu_fnc_createStartGameAction;
        [] call emf_aceMenu_fnc_createDisplayRolesAction;
        [] call emf_aceMenu_fnc_createPerformanceReport;
        [] call emf_aceMenu_fnc_toggleHUDAction;

        /* Add taw_vd menu if not exists */
        if (isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS","tawvd_menu"]] call ace_interact_menu_fnc_findActionNode)}) then {
            private _actionID = ["tawvd_menu","View Distance Settings","rsc\data\icon_viewDistance_ca.paa",{[] call TAWVD_fnc_openMenu},{true}] call ace_interact_menu_fnc_createAction;
            [typeOf player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _actionID] call ace_interact_menu_fnc_addActionToClass;
        };

        sleep 10;
    };
}
