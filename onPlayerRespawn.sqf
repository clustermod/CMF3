/*
 * Author: Bohemia Interactive, Eric
 * Executed locally when player respawns in a singleplayer or in a multiplayer mission with "NONE" respawn type.
 *
 * Arguments:
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

// Load inventory upon player respawn
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;

// Join previous group
[player] joinSilent (player getVariable ["EMF_OPK_Group", (group player)]);

// Assign previous team
player assignTeam (player getVariable ["EMF_OPK_Team", (assignedTeam player)]);
