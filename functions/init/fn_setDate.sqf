#include "script_component.hpp"
/*
 * Author: Eric
 * Freezes date and time. calls emf_utilities_fnc_setDate
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_setDate
 *
 * Public: No
 */

// Get config setting
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,freezeTime) ) isEqualTo 1;
if !(_enabled) exitWith {};

call emf_utilities_fnc_setDate;
