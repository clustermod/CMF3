#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to disable freezeTime
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_toggleFreezeTime
 *
 * Public: No
 */
SCRIPT(toggleFreezeTime);

ESETTING(environment,freezeTime) = !ESETTING(environment,freezeTime);
publicVariable QESETTING(environment,freezeTime);

if (ESETTING(environment,freezeTime)) then {
    [LSTRING(en_freezeTime_success_message)] call zen_common_fnc_showMessage;
} else {
    [LSTRING(dis_freezeTime_success_message)] call zen_common_fnc_showMessage;
};