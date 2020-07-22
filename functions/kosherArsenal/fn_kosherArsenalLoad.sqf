/*
 * Author: Eric
 * Sets the whitelists to be used in the mission.
 *
 * Arguments:
 * 0: loadout <ARRAY>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [["Whitelist1", "Whitelist2"]] call EMF_fnc_kosherArsenalLoad
 *
 * public: No
*/

params["_loadout"];

// Check if params are set and is of correct type
if (isNil "_loadout") exitWith {  ['Loadouts is not set'] call BIS_fnc_error; 'Loadouts is not set' call BIS_fnc_log; false;};
if (typeName _loadout != "ARRAY") exitWith {  ['Loadouts must be type "ARRAY", type %1 supplied', (typeName _loadout)] call BIS_fnc_error; ['Loadouts must be type "ARRAY", type %1 supplied', (typeName _loadout)] call BIS_fnc_log; false;};

// Set the whitelist arrays in missionNamespace
player setVariable ["EMF_KA_ArsenalKit", _loadout, true];
true;
