#include "script_component.hpp"
/*
 * Author: Eric
 * Freezes time completly as opposed to setting skipTime 0.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Framehandler ID <NUMBER>
 *
 * Example:
 * call cmf_environment_fnc_freezeTime
 *
 * Public: Yes
*/
SCRIPT(freezeTime);

GVAR(freezeTime_initDate) = date;

private _handle = [{
    if (!SETTING(freezeTime) && { !GVAR(freezeTime_override) }) exitWith { GVAR(freezeTime_initDate) = date };

    setdate GVAR(freezeTime_initDate);
}] call CBA_fnc_addPerFrameHandler;

/* Save the script handle to a global variable */
GVAR(freezeTime_handle) = _handle;

_handle;
