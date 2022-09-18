#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes safestart. calls emf_gameplay_fnc_safeStart.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_safeStart
 *
 * Public: No
 */
SCRIPT(safeStart);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,safestart) ) isEqualTo 1;
if !(_enabled) exitWith {};

call EFUNC(common,safestart);
