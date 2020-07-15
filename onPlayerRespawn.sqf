/*
 * Author: Eric
 * Executed locally when player respawns in a singleplayer or in a multiplayer mission with "NONE" respawn type.
 *
 *Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
*/

// Load inventory upon player respawn
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;
