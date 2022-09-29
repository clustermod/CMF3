/*
 * Author: Bohemia Interactive, Eric
 * Gets executed when mission starts. Any code put in here will be executed when the mission starts and for every JIP player.
 *
 */
scriptName "init.sqf";

/* Wait until CMF is initialized */
waitUntil{ missionNamespace getVariable ["cmf_main_server_initialized", false] };

/* Set the radio theme */
klpq_musicRadio_radioThemes = ["t_american"];
