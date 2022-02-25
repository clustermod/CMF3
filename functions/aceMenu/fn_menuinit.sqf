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
private["_CCSettingMenu"];

if (isDedicated) exitWith {};

_CCSettingMenu = ["EMF_BUGACTIONS", "CC Menu", "rsc\data\settings_icon.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions"], _CCSettingMenu] call ace_interact_menu_fnc_addActionToClass;

[["ACE_ZeusActions"], _CCSettingMenu] call ace_interact_menu_fnc_addActionToZeus;

[] call emf_aceMenu_fnc_createEndLoadingAction;
[] call emf_aceMenu_fnc_createMapsFixAction;
[] call emf_aceMenu_fnc_createDisplayRolesAction;
[] call emf_aceMenu_fnc_createStartGameAction;
