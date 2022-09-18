#include "script_component.hpp"
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
 * [] call emf_menu_fnc_fixLoadingBug
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
["Select player", [["LIST", ["players", "player to apply fix to"], [_playerIds, _playernames, 0, 3]]], _onConfirm] call zen_dialog_fnc_create;
