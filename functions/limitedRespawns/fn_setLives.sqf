/*
 * Author: Eric
 * Sets the remaining respawns of to supplied unit.
 *
 * Arguments:
 * 0: obj <OBJECT>
 * 1: Respawns <NUMBER>
 * 2: silent <BOOL>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [this, 5, true] call emf_limitedRespawns_fnc_setLives
 *
 * public: Yes
*/
scriptName "functions\limitedRespawns\fn_setLives.sqf";
params["_obj", "_respawns", ["_silent", false]];

// Check if params are set and is of correct type
if (isNil "_obj") exitWith {["ERR", "Object not set", "setLives", "limitedRespawns"] call EMF_DEBUG; false;};
if (typeName _obj != "OBJECT") exitWith {["ERR", format['Object must be type "OBJECT", type %1 supplied', (typeName _obj)], "setLives", "limitedRespawns"] call EMF_DEBUG; false};

if (isNil "_respawns") exitWith {["ERR", "Respawns is not set", "setLives", "limitedRespawns"] call EMF_DEBUG; false};
if (typeName _respawns != "SCALAR") exitWith {["ERR", format['Respawns must be type "NUMBER", type %1 supplied', (typeName _obj)], "setLives", "limitedRespawns"] call EMF_DEBUG; false};

// Set the new amount of respawns and resett death count
_obj setVariable["EMF_playerRespawns", _respawns, true];
_obj setVariable["EMF_playerDeaths", 0, true];

if (_obj in ([] call ace_spectator_fnc_players)) then {
    [false] call ace_spectator_fnc_setSpectator;
};

if !(_silent) then {
  [format["Your respawns have been set to: %1", _respawns]] remoteExec ["hint", _obj];
};
true;
