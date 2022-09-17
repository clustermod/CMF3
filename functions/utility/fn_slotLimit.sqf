#include "script_component.hpp"
/*
 * Author: Eric
 * Kicks players back to lobby if there aren't enough players to allow this slot.
 *
 * Arguments:
 * 0: amount <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [5] call emf_utilities_fnc_slotLimit
 *
 * public: Yes
*/
scriptName "functions\utilites\fn_slotLimit.sqf";
params["_amount"];

// Check if params are set and is of correct type
if (isNil "_amount") exitWith {  ['Amount is not set'] call BIS_fnc_error; 'Amount is not set' call BIS_fnc_log;};
if (typeName _amount != "SCALAR") exitWith {  ['Amount must be type "SCALAR", type %1 supplied', (typeName _amount)] call BIS_fnc_error; ['Amount must be type "SCALAR", type %1 supplied', (typeName _amount)] call BIS_fnc_log;};

// If not enough players are connected kick player from slot
if (count allPlayers < _amount) then {
  	["notEnoughPlayers", false, 0.01, false] call BIS_fnc_endMission;
}
