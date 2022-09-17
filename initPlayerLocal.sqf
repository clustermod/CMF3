/*
 * Author: Bohemia Interactive, Eric
 * Gets executed locally for joined players. Any code put in here will only be run for the joined player.
 *
 */
scriptName "initPlayerLocal.sqf";

/* Wait until EMF is initialized */
waitUntil{ missionNamespace getVariable ["emf_main_player_initialized", false] };

/* Add Zeus FPS and lives counter */
call emf_zeus_fnc_playerInfo;

/* Set available respawns */
[4] call emf_limitedRespawns_fnc_init;

/* Kick players from zeus slot if their steam ID is not in the supplied array */
[["YOURSTEAMID"]] call emf_utilities_fnc_notZeus;

/* Initialize kosherArsenal */
[["LOADOUTFILEHERE"], true, true] call emf_kosherArsenal_fnc_init;

/* Initialize rallypoints */
[["FTL", "SL", "PL", "CO"]] call emf_common_fnc_rallypoint;

/* Make units investigate shots */
//[] call emf_gameplay_fnc_unitInvestigate;
