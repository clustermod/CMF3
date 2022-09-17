#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to set a player's lives
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_zeus_fnc_setLivesModule
 *
 * Public: No
 */

scriptName "functions\zeus\fn_setLivesModule.sqf";

["EMF", "Disable setDate (Frozen time)", {
    missionNamespace setVariable ["emf_init_setDate_disable", true, true];
}, "rsc\data\icon_module_disableSetDate_ca.paa"] call zen_custom_modules_fnc_register;
