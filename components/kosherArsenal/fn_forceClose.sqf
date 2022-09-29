#include "script_component.hpp"
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
 * [player] call cmf_kosherArsenal_fnc_forceClose
 *
 * Public: Yes
 */
SCRIPT(forceClose);
params["_unit"];

/* Forcefully close the units kosherArsenal */
{
  player setVariable [QGVAR(close), true, true];
} remoteExec ["call", _unit, true];
