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
 * [] call cmf_zeus_fnc_ammoboxModule
 *
 * Public: No
 */
SCRIPT(ammoboxModule);

/* Add kosher ammobox to object */
private _dialogFunction = {
    if (isNull (_this select 1)) exitWith {["Must select an object"] call zen_common_fnc_showMessage};

    private _result = [(_this select 1)] call EFUNC(kosherArsenal,ammobox);
    if (_result) then {
        ["Added kosher ammobox"] call zen_common_fnc_showMessage;

        /* Raise event */
    	[QGVAR(ammobox_added), [_this select 1]] call CBA_fnc_globalEvent;
    } else {
        ["Failed to add kosher ammobox"] call zen_common_fnc_showMessage;
    };
};

["CMF: Kosher Arsenal", "Set as ammobox", _dialogFunction, "rsc\data\icon_module_ammobox_ca.paa"] call zen_custom_modules_fnc_register;
