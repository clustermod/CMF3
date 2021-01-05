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
 * [this] call EMF_fnc_nearestPlayer
 *
 * Public: Yes
 */

private["_PlayerDistances", "_nearestPlayer", "_unit"];
_unit = _this select 0;

_PlayerDistances = allPlayers apply {[_x distance _unit,_x]};
_PlayerDistances sort true;
_nearestPlayer = (_PlayerDistances apply {_x#1})#0;

if (isNil "_nearestPlayer") then {
    _nearestPlayer = objNull;
};

_nearestPlayer;
