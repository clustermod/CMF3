/*
 * Gets executed locally for joined players. Any code put in here will only be run for the joined player.
 */

/* Wait until CMF is initialized */
waitUntil{ missionNamespace getVariable ["cmf_main_player_initialized", false] };

/* Set available respawns */
[3] call cmf_respawn_fnc_limit;

/* Initialize kosherArsenal */
[["!arsenal_template"], true] call cmf_kosherArsenal_fnc_init;
[ "!logistics_template"] call cmf_logistics_fnc_cratepreset;

/* Initialize rallypoints */
[["FTL", "SL", "PL", "CO"]] call cmf_respawn_fnc_rallypoint;