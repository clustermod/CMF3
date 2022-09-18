#include "script_component.hpp"
/*
 * Author: Eric
 * Freezes date and time. calls cmf_utilities_fnc_setDate
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_init_fnc_setDate
 *
 * Public: No
 */
SCRIPT(freezeTime);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,freezeTime) ) isEqualTo 1;
if !(_enabled) exitWith {};

call EFUNC(utility,freezeTime);
