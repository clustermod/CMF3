#include "script_component.hpp"
/*
 * Author: Eric
 * Writes error to array before sending it to CBA
 * 
 * Arguments:
 * 0: Addon name (optional, defaut: "cba") <STRING>
 * 1: Component name (optional, default: "diagnostic") <STRING>
 * 2: Title of the error <STRING>
 * 3: Error message (use "\n" for newline) <STRING>
 * 4: Name of file <STRING>
 * 5: Line of file <NUMBER>
 * 
 * Return Value:
 * nil
 * 
 * Example:
 * ["Player got banana"] call cmf_diagnostic_fnc_error
 * 
 * Public: no
 */

if (!is3DEN) then { _nil = GVAR(errorOut) pushBack _this };

_this call CBA_fnc_error;
