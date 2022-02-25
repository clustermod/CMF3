/*
 * Author: Bohemia Interactive, Eric
 * example local initialization, executed locally when player joins mission (includes both mission start and JIP).
 *
 */
scriptName "initPlayerLocal.sqf";

// Enable player FPS counter for zeus
call emf_utilities_fnc_zeusFPS;

[4, 0] call emf_limitedRespawns_fnc_init;

// Kick player back to lobby if they are zeus and not Eric, change "76561198065818848" to your steamID
[["76561198065818848"]] call emf_utilities_fnc_notZeus;

// Load loadouts for 1 team
[["!Template"], false, true] call emf_kosherArsenal_fnc_init;

// If player has role "SL" allow spawning rallypoints
["SL", 5] call emf_gameplay_fnc_rallypoint;

// Make enemy units within 300m to investigate shots
[] call emf_gameplay_fnc_unitInvestigate;
