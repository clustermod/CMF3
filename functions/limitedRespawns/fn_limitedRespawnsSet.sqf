/*
 * Author: Eric
 * Sets the remaining respawns of to supplied unit.
 *
 *Arguments:
 * 0: obj <OBJECT>
 * 1: Respawns <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, 5] call EMF_fnc_limitedRespawnsSet
 *
 * public: Yes
*/

params["_obj", "_respawns"];

// Set the new amount of respawns and resett death count
_obj setVariable["EMF_playerRespawns", _respawns, true];
_obj setVariable["EMF_playerDeaths", 0, true];

[format["Your respawns have been set to: %1", _respawns]] remoteExec ["hint", _obj];
