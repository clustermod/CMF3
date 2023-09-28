/*
 * Gets executed when mission starts. Any code put in here will be executed when the mission starts and for every JIP player.
 */

/* Wait until CMF is initialized */
waitUntil{ missionNamespace getVariable ["cmf_main_server_initialized", false] };