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
 * call cmf_utility_fnc_freezeTime
 *
 * Public: Yes
*/
SCRIPT(freezeTime);

GVAR(freezeTime_initDate) = date;
// @TODO: Move to new module environment
private _handle = [{
    if !(GVAR(setting_freezeTime)) exitWith { GVAR(freezeTime_initDate) = date };

    setdate GVAR(freezeTime_initDate);
}] call CBA_fnc_addPerFrameHandler;

/* Save the script handle to a global variable */
missionNamespace setVariable [QGVAR(freezeTime_handle), _handle];

_handle;
