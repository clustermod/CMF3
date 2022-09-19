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

["CMF: Common", "Disable setDate (Frozen time)", {
    missionNamespace setVariable [QEGVAR(utility,freezetime_disable), true, true];
    ["Unfroze time"] call zen_common_fnc_showMessage
}, "rsc\data\icon_module_disableSetDate_ca.paa"] call zen_custom_modules_fnc_register;
