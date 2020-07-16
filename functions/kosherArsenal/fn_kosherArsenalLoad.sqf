/*
 * Author: Eric
 * Sets the whitelists to be used in the mission.
 *
 * Arguments:
 * 0: loadout <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [["Whitelist1", "Whitelist2"]] call EMF_fnc_kosherArsenalLoad
 *
 * public: No
*/

params["_loadout"];

// Set the whitelist arrays in missionNamespace
missionNamespace setVariable ["EMF_KA_ArsenalKit", _loadout];
