#include "script_component.hpp"
/*
 * Author: Eric
 * Creates module that force closes kosher arsenal for supplied unit
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_kosherForceCloseModule
 *
 * Public: No
 */
SCRIPT(kosherForceCloseModule);

private _dialogFunction = {
    if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

    [(_this select 1)] call EFUNC(kosherArsenal,forceClose);
    [LSTRING(forceclose_kosherArsenal_message)] call zen_common_fnc_showMessage;
};

[LSTRING(kosherArsenal_module_category_displayname), LSTRING(forceclose_kosherArsenal_module_displayname), _dialogFunction, "components\curator\data\icon_module_closeKosherArsenal_ca.paa"] call zen_custom_modules_fnc_register;
