#include "script_component.hpp"
/*
 * Author: Eric
 * Writes log to array before sending it to CBA
 * 
 * Arguments:
 * 0: Message <STRING>
 * 
 * Return Value:
 * nil
 * 
 * Example:
 * ["Player got banana"] call cmf_diagnostic_fnc_log
 * 
 * Public: no
 */

if (!is3DEN) then { _nil = GVAR(logOut) pushBack [serverTime, systemTime, _this] };

_this call CBA_fnc_log;