/*
 * Author: Eric
 * example local initialization, executed locally when player joins mission (includes both mission start and JIP).
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

// For some reason arma thinks this is initPlayerServer and runs this for every client each time a new player initializes
if ((_this select 0) != player) exitWith {};

// Keep markers the same size when zooming in or out of map
call EMF_fnc_resizeMapMarkers;

// Enable player FPS counter for zeus
call EMF_fnc_zeusFPS;

// Limit respawns to 4 for team 0
[4, 0] call EMF_fnc_limitedRespawns;
// Limit respawns to 2 for team 1
[2, 1] call EMF_fnc_limitedRespawns;

// Kick player back to lobby if they are zeus and not Eric, change "76561198065818848" to your steamID
[["76561198065818848"]] call EMF_fnc_notZeus;

// Load loadouts for 2 teams
[["USA_EARLY90_RANGER_DESERT"]] call EMF_fnc_kosherArsenalLoad;
[false, true] call EMF_fnc_kosherArsenal;

// If player has role "SL" allow spawning rallypoints
["SL", 5] call EMF_fnc_rallypoint;
