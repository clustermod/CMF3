/*
 * Author: Eric
 * Force closes units kosher arsenal
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call emf_kosherArsenal_fnc_forceClose
 *
 * Public: Yes
 */
scriptName "functions\kosherArsenal\fn_forceClose.sqf";
params["_unit"];

{
  player setVariable ["emf_kosherArsenal_init_cancel", true, true];
} remoteExec ["call", _unit, true];
