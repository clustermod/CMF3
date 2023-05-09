/*
 * Gets executed when mission starts. Any code put in here will be executed when the mission starts and for every JIP player.
 */

/* Wait until CMF is initialized */
waitUntil{ missionNamespace getVariable ["cmf_main_server_initialized", false] };

/* Set the radio theme */
klpq_musicRadio_radioThemes = ["t_american"];

/*
[
	[east, "v3_ai_eastGerman_1980", ["UK3CB_CW_SOV_O_EARLY", "UK3CB_CW_SOV_O_LATE"]],
	[west, "v3_ai_westGerman_1980", ["UK3CB_CW_US_B_EARLY", "UK3CB_CW_US_B_LATE"]]
] call cmf_kosherAI_fnc_init;
*/