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
 * [] call cmf_zeus_fnc_disableFreezeTime
 *
 * Public: No
 */
SCRIPT(disableFreezeTime);

[LSTRING(common_module_category_displayname), LSTRING(dis_freezeTime_module_displayname), {
    missionNamespace setVariable [QEGVAR(utility,freezetime_disable), true, true];
    [LSTRING(dis_freezeTime_success_message)] call zen_common_fnc_showMessage
}, "rsc\data\icon_module_disableSetDate_ca.paa"] call zen_custom_modules_fnc_register;
