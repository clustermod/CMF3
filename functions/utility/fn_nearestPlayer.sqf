#include "script_component.hpp"
/*
 * Author: Eric
 * Returns the nearest player to unit
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * nearestPlayer <OBJECT>
 *
 * Example:
 * [this] call cmf_utility_fnc_nearestPlayer
 *
 * Public: Yes
 */
SCRIPT(nearestPlayer);
params["_unit"];

/* Get all players and their distances from the unit */
private _PlayerDistances = allPlayers apply {[_x distance _unit,_x]};
_PlayerDistances sort true;

/* Select the closes of the players */
private _nearestPlayer = (_PlayerDistances apply {_x select 1}) select 0;

/* If no players return objNull */
if (isNil "_nearestPlayer") then {
    _nearestPlayer = objNull;
};

_nearestPlayer;
