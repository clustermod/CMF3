call EMF_fnc_zeusFPS;																															// Enable player FPS counter for zeus

if (player getVariable ["unitTeamRole", 0] == 1) then {
	[2] call EMF_fnc_limitedRespawns;																								// Limit respawns to 2 for team 1
} else {
	[4] call EMF_fnc_limitedRespawns;																								// Limit respawns to 4 for team 1
};

if ((player getVariable ["EMF_PlayerZeus", false]) && ((getPlayerUID player) != "76561198065818848")) then {
	["wrongZeus", false, 0.01, false] call BIS_fnc_endMission;											// Kick player back to lobby if they are zeus and not Eric
};

// Color corrections, will be applied for all players
"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [0.9, 0.6, 0, [0.1, 0.1, 0.1, -0.1], [0.6, 0.4, 0.2, 0.5],  [1, 0.6, 0, 0]];
"colorCorrections" ppEffectCommit 0;


[["RUSSIA_LATE90_VDV_WDL", "RUSSIA_LATE90_PILOT_MIXED"]] call EMF_fnc_kosherArsenalLoad;	// Load loadouts for 2 teams
[false] call EMF_fnc_kosherArsenal;																												// Call for kosherArsenal (could probably embedd into EMF_fnc_kosherArsenal);


if (player getVariable ["unitSquadRole", "RFL"] == "SL" && (player getVariable ["unitTeamRole", 0] != 1)) then
{
	[player, 5] call EMF_fnc_rallypoint;																						// If player has role "SL" allow spawning rallypoints
};
