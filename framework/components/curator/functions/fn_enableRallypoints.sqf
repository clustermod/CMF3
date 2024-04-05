#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to add rallypoints for unit
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_zeus_fnc_enableRallypoints
 *
 * Public: No
 */
SCRIPT(enableRallypoints);

if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

if !((_this select 1) getVariable [QEGVAR(respawn,rallypoint), false]) then {
    [[(_this select 1)]] call EFUNC(respawn,rallypoint);
} else {
    (_this select 1) setVariable [QEGVAR(respawn,showRallypoint), true, true];
};
[format[LSTRING(rallypoint_success_message), name (_this select 1)]] call zen_common_fnc_showMessage;