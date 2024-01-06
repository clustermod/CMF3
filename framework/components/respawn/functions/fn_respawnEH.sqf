#include "script_component.hpp"
/*
 * Author: Eric
 * Resets respawnState if player respawns
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_respawn_fnc_respawnEH
 * 
 * Public: No
 */
params ["_unit", "_corpse"];

if !(_unit isEqualTo player) exitWith {};

GVAR(respawnState) = false;