#include "script_component.hpp"
/*
 * Author: Eric
 * Returns the nearest player to object
 *
 * Arguments:
 * 0: Position <OBJECT or ARRAY>
 *
 * Return Value:
 * Nearest Player <OBJECT>
 *
 * Example:
 * [this] call cmf_common_fnc_nearestPlayer
 *
 * Public: Yes
 */
SCRIPT(nearestPlayer);
params["_position"];

if (_position isEqualType objNull) then {
    _position = getPos _position;
};

/* Get all players and their distances from the unit */
private _PlayerDistances = allPlayers apply { [_x distance _position, _x] };
_PlayerDistances sort true;

/* Select the closes of the players */
private _nearestPlayer = (_PlayerDistances apply { _x select 1 }) select 0;

/* If no players return objNull */
if (isNil "_nearestPlayer") then {
    _nearestPlayer = objNull;
};

_nearestPlayer;
