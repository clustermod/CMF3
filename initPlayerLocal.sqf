/*
 * Author: Eric
 * example local initialization, executed locally when player joins mission (includes both mission start and JIP).
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

// Enable player FPS counter for zeus
call EMF_fnc_zeusFPS;

if (player getVariable ["unitTeamRole", 0] == 1) then {
	// Limit respawns to 2 for team 1
	[2] call EMF_fnc_limitedRespawns;
} else {
	// Limit respawns to 4 for team 0
	[4] call EMF_fnc_limitedRespawns;
};

// Kick player back to lobby if they are zeus and not Eric, change "76561198065818848" to your steamID
if ((player getVariable ["EMF_PlayerZeus", false]) && ((getPlayerUID player) != "76561198065818848")) then {
	["wrongZeus", false, 0.01, false] call BIS_fnc_endMission;
};

// Color corrections, will be applied for all players (currently commented out and won't affect players)
/*
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [0.9, 0.6, 0, [0.1, 0.1, 0.1, -0.1], [0.6, 0.4, 0.2, 0.5],  [1, 0.6, 0, 0]];
"colorCorrections" ppEffectCommit 0;
*/

// Load loadouts for 2 teams
[["RUSSIA_LATE90_VDV_WDL", "RUSSIA_LATE90_PILOT_MIXED"]] call EMF_fnc_kosherArsenalLoad;
// Start kosherArsenal
[false] call EMF_fnc_kosherArsenal;

// If player has role "SL" allow spawning rallypoints
if (player getVariable ["unitSquadRole", "RFL"] == "SL") then
{
	[player, 5] call EMF_fnc_rallypoint;
};
