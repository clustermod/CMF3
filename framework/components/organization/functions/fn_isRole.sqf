#include "script_component.hpp"
/*
 * Author: Eric
 * Checks if a unit is the specified role
 *
 * Arguments:
 * 0: Unit <Object>
 * 1: Role  <STRING>
 *
 * Return Value:
 * Is role <BOOLEAN>
 *
 * Example:
 * [player, "RFL"] call cmf_organization_fnc_isRole
 *
 * Public: Yes
 */
SCRIPT(isRole);
params ["_unit", "_role"];

private _unitRole = _unit getVariable [QGVAR(role), "RFL"];

_unitRole isEqualTo _role;
