#include "script_component.hpp"
/*
 * Author: Eric
 * Empties error array
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [] call cmf_diagnostic_fnc_errorFlush
 * 
 * Public: no
 */

GVAR(errorOut) = [];
