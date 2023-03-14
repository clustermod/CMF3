#include "script_component.hpp"
/*
 * Author: Eric
 * Modify ACEX Fortify
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_main_fnc_fortify
 *
 * Public: No
 */

/* On deployment start */
["acex_fortify_onDeployStart", {
    params ["_unit", "_object", "_cost"];
    missionNamespace setVariable [QEGVAR(gameplay,safestart_override), true, false];
}] call CBA_fnc_addEventHandler;

/* On deployment object placed */
["ace_fortify_deployFinished", {
    params ["_unit", "_side", "_objectClass", "_pos", "_vectorDir", "_vectorUp"];
    missionNamespace setVariable [QEGVAR(gameplay,safestart_override), false, false];
}] call CBA_fnc_addEventHandler;

/* On deployment cancelled */
["ace_fortify_deployCanceled", {
    params ["_unit", "_side", "_objectClass", "_pos", "_vectorDir", "_vectorUp"];
    missionNamespace setVariable [QEGVAR(gameplay,safestart_override), false, false];
}] call CBA_fnc_addEventHandler;
