/*
 * Gets executed locally for joined players. Any code put in here will only be run for the joined player.
 */

/* Wait until CMF is initialized */
waitUntil{ missionNamespace getVariable ["cmf_main_player_initialized", false] };

//["testLoadout", "test_garage"] call cmf_kosherGarage_fnc_registerWhitelist; // remove before release

/* Set available respawns */
[4] call cmf_respawn_fnc_limit;

/* Initialize kosherArsenal */
[["test_arsenal"], true, true] call cmf_kosherArsenal_fnc_init; // clear before release

/* Initialize rallypoints */
[["FTL", "SL", "PL", "CO"]] call cmf_respawn_fnc_rallypoint;
