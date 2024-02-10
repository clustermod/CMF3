#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to remove rallypoints for unit
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_removeRallypointModule
 *
 * Public: No
 */
SCRIPT(setLivesModule);

private _moduleFunction = {
    if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

    (_this select 1) setVariable [QEGVAR(respawn,showRallypoint), false, true];
    [format[LSTRING(rallypoint_remove_success_message), name (_this select 1)]] call zen_common_fnc_showMessage;
};

[LSTRING(respawn_module_category_displayname), LSTRING(rallypoint_remove_module_displayname), _moduleFunction, "components\respawn\data\icon_ace_rallypoint_disabled_ca.paa"] call zen_custom_modules_fnc_register;
