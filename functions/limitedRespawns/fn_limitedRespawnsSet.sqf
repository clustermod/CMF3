/*
 * Author: Eric
 * Sets the remaining respawns of to supplied unit.
 *
 * Arguments:
 * 0: obj <OBJECT>
 * 1: Respawns <NUMBER>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [this, 5] call EMF_fnc_limitedRespawnsSet
 *
 * public: Yes
*/

params["_obj", "_respawns"];

// Check if params are set and is of correct type
if (isNil "_obj") exitWith {  ['Object is not set'] call BIS_fnc_error; 'Object is not set' call BIS_fnc_log; false;};
if (typeName _obj != "OBJECT") exitWith {  ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_error; ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_log; false;};

if (isNil "_respawns") exitWith {  ['Respawns is not set'] call BIS_fnc_error; 'Respawns is not set' call BIS_fnc_log;};
if (typeName _respawns != "SCALAR") exitWith {  ['Respawns must be type "SCALAR", type %1 supplied', (typeName _respawns)] call BIS_fnc_error; ['Respawns must be type "SCALAR", type %1 supplied', (typeName _respawns)] call BIS_fnc_log;};

// Set the new amount of respawns and resett death count
_obj setVariable["EMF_playerRespawns", _respawns, true];
_obj setVariable["EMF_playerDeaths", 0, true];

if (_obj in ([] call ace_spectator_fnc_players)) then {
    [false] call ace_spectator_fnc_setSpectator;
};

[format["Your respawns have been set to: %1", _respawns]] remoteExec ["hint", _obj];
true;
