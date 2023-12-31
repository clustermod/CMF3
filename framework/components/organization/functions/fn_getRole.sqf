#include "script_component.hpp"
/*
 * Author: Eric
 * Get's a unit's role
 *
 * Arguments:
 * 0: Unit <Object>
 *
 * Return Value:
 * Role <STRING>
 *
 * Example:
 * [player] call cmf_organization_fnc_getRole
 *
 * Public: Yes
 */
SCRIPT(isRole);
params ["_unit"];

_unit getVariable [QGVAR(role), "NONE"];
