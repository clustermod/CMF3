#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to set object as an ammo box
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_ammoboxModule
 *
 * Public: No
 */
SCRIPT(ammoboxModule);

/* Add kosher ammobox to object */
private _dialogFunction = {
    if (isNull (_this select 1)) exitWith {[LSTRING(object_requirement_message)] call zen_common_fnc_showMessage};

    private _result = [(_this select 1)] call EFUNC(kosherArsenal,ammobox);
    if (_result) then {
        [LSTRING(ammobox_success_message)] call zen_common_fnc_showMessage;

        /* Raise event */
        [QGVAR(ammobox_added), [_this select 1]] call CBA_fnc_globalEvent;
    } else {
        [LSTRING(ammobox_fail_message)] call zen_common_fnc_showMessage;
    };
};

[LSTRING(kosherArsenal_module_category_displayname), LSTRING(ammobox_module_displayname), _dialogFunction, "components\curator\data\icon_module_ammobox_ca.paa"] call zen_custom_modules_fnc_register;
