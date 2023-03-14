#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to force kosher arsenal on a player
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_zeus_fnc_forceArsenalModule
 *
 * Public: No
 */
SCRIPT(forceArsenalModule);

private _dialogFunction = {
    if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

    [(_this select 1)] call EFUNC(kosherArsenal,forceArsenal);
    [LSTRING(forceopen_kosherArsenal_success_message)] call zen_common_fnc_showMessage;
};

[LSTRING(kosherArsenal_module_category_displayname), LSTRING(forceopen_kosherArsenal_module_displayname), _dialogFunction, "rsc\data\icon_module_kosherArsenal_ca.paa"] call zen_custom_modules_fnc_register;
