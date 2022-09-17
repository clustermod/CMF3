#include "script_component.hpp"
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
if (isNil "_obj") exitWith { ERROR("Object cannot be nil"); false;};
if !(IS_OBJECT(_obj)) exitWith {ERROR_1('Object must be type "OBJECT", type %1 supplied', (typeName _obj)); false};

if (isNil "_respawns") exitWith {ERROR("Respawns is not set"); false};
if !(IS_SCALAR(_obj)) exitWith {ERROR_1('Respawns must be type "NUMBER", type %1 supplied', (typeName _obj)); false};

// Set the new amount of respawns and resett death count
_obj setVariable[QGVAR(playerRespawns), _respawns, true];
_obj setVariable[QGVAR(playerDeaths), 0, true];

if (!local _obj) exitWith {};

if (_obj in ([] call ace_spectator_fnc_players)) then {
    [false] call ace_spectator_fnc_setSpectator;
};

if (!_silent) then {
  [FORMAT_1("Your respawns have been set to: %1", _respawns)] remoteExec ["hint", _obj];
};

true;
