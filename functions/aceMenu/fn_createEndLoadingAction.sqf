/*
 * Author: Eric
 * Creates the fix map action in ace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_aceMenu_fnc_createEndLoadingAction
 *
 * Public: No
 */
scriptName "functions\aceMenu\fn_createEndLoadingAction.sqf";
private["_fixAction"];

if (isDedicated) exitWith {};

_fixAction = ["emf_fix_map", "Fix ""stuck loading"" bug", "rsc\data\bug_icon.paa", {
  private _onConfirm = {
    params["_value"];
    [] remoteExecCall ["emf_utilities_fnc_endLoadingScreen", _value, true];
  };

  private _players = allPlayers;
  private _playerIds = _players apply {owner _x};
  private _playernames = _players apply {name _x};
  ["Select player", [["LIST", ["players", "player to apply fix to"], [_playerIds, _playernames, 0, 3]]], _onConfirm] call zen_dialog_fnc_create;
}, {(!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0)}] call ace_interact_menu_fnc_createAction;

[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _fixAction] call ace_interact_menu_fnc_addActionToClass;
[["ACE_ZeusActions", "EMF_BUGACTIONS"], _fixAction] call ace_interact_menu_fnc_addActionToZeus;
