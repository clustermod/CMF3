/*
 * Author: Eric
 * Executed locally when player is killed in a singleplayer or in a multiplayer mission.
 *
 *Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
*/

// Save inventory upon player death
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
