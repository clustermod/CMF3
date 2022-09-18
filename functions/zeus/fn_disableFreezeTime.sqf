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
 * [] call emf_zeus_fnc_disableFreezeTime
 *
 * Public: No
 */
SCRIPT(disableFreezeTime);

["EMF: Common", "Disable setDate (Frozen time)", {
    missionNamespace setVariable [QEGVAR(utility,freezetime_disable), true, true];
}, "rsc\data\icon_module_disableSetDate_ca.paa"] call zen_custom_modules_fnc_register;
