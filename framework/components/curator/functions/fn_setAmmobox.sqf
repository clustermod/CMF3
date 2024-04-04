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
 * call cmf_zeus_fnc_setAmmobox
 *
 * Public: No
 */
SCRIPT(setAmmobox);

if (isNull (_this select 1)) exitWith {[LSTRING(object_requirement_message)] call zen_common_fnc_showMessage};

private _result = [(_this select 1)] call EFUNC(kosherArsenal,ammobox);
if (_result) then {
    [LSTRING(ammobox_success_message)] call zen_common_fnc_showMessage;

    /* Raise event */
    [QGVAR(ammobox_added), [_this select 1]] call CBA_fnc_globalEvent;
} else {
    [LSTRING(ammobox_fail_message)] call zen_common_fnc_showMessage;
};


