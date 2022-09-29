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
 * [this] call emf_utilities_fnc_nearestPlayer
 *
 * Public: Yes
 */
scriptName "functions\utilities\EMF_fnc_nearestPlayer.sqf";
private["_PlayerDistances", "_nearestPlayer", "_unit"];
params["_unit"];

_PlayerDistances = allPlayers apply {[_x distance _unit,_x]};
_PlayerDistances sort true;
_nearestPlayer = (_PlayerDistances apply {_x select 1}) select 0;

if (isNil "_nearestPlayer") then {
    _nearestPlayer = objNull;
};

_nearestPlayer;
