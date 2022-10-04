#include "script_component.hpp"
/*
 * Author: Eric
 * Fixes the issue where players get stuck loading into the mission. (can only be run for other players)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_menu_fnc_fixLoadingBug
 *
 * Public: No
 */
SCRIPT(fixLoadingBug);

/* End the loading screen for the selected player */
private _onConfirm = {
    params["_value"];
    [] remoteExecCall [EFUNC(utility,endLoadingScreen), _value, true];
};

/* Open a menu where you can select the player to apply the fix to */
private _players = allPlayers;
private _playerIds = _players apply {owner _x};
private _playernames = _players apply {name _x};
[LSTRING(select_player_displayname), [["LIST", [LSTRING(players), LSTRING(select_player_tooltip)], [_playerIds, _playernames, 0, 3]]], _onConfirm] call zen_dialog_fnc_create;
