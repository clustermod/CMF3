/*
 * Author: [Name of Author(s)]
 * Creates an action to start the game (safestart).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_aceMenu_fnc_createStartGameAction
 *
 * Public: No
 */
scriptName "functions\aceMenu\fn_createStartGameAction.sqf";
private["_startCategoyAction", "_startInstantAction", "_startDelayedAction"];

if (isDedicated) exitWith {};

_startCategoyAction = ["emf_start_game_category", "Start Game", "rsc\data\start_icon.paa", {}, {(!(missionNamespace getVariable ["EMF_missionSafeStart", false]) && !isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0 && !(missionNamespace getVariable ["EMF_missionSafeStart", false]))}] call ace_interact_menu_fnc_createAction;

_startInstantAction = ["emf_start_game_instant", "Instant", "rsc\data\instant_icon.paa", {
  missionNamespace setVariable ["EMF_missionSafeStart", true, true];
}, {!(missionNamespace getVariable ["EMF_missionSafeStart", false])}] call ace_interact_menu_fnc_createAction;

_startDelayedAction = ["emf_start_game_delayed", "Delayed", "rsc\data\delayed_icon.paa", {
  [] spawn {
    [60, "Weapons are hot in: ", true] call EMF_fnc_countDown;
    missionNamespace setVariable ["EMF_missionSafeStart", true, true];
  };
}, {!(missionNamespace getVariable ["EMF_missionSafeStart", false])}] call ace_interact_menu_fnc_createAction;

[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _startCategoyAction] call ace_interact_menu_fnc_addActionToClass;
[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS", "emf_start_game_category"], _startInstantAction] call ace_interact_menu_fnc_addActionToClass;
[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS", "emf_start_game_category"], _startDelayedAction] call ace_interact_menu_fnc_addActionToClass;

[["ACE_ZeusActions", "EMF_BUGACTIONS"], _startCategoyAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions", "EMF_BUGACTIONS", "emf_start_game_category"], _startInstantAction] call ace_interact_menu_fnc_addActionToZeus;
[["ACE_ZeusActions", "EMF_BUGACTIONS", "emf_start_game_category"], _startDelayedAction] call ace_interact_menu_fnc_addActionToZeus;
