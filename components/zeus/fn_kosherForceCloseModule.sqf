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
 * [] call cmf_zeus_fnc_kosherForceCloseModule
 *
 * Public: No
 */
SCRIPT(kosherForceCloseModule);

private _dialogFunction = {
    if (isNull (_this select 1)) exitWith {["Must select a unit"] call zen_common_fnc_showMessage};
    if !((_this select 1) isKindOf "Man") exitWith {["Selected object must be a unit"] call zen_common_fnc_showMessage};
    if !(isPlayer (_this select 1)) exitWith {["Selected unit must be player"] call zen_common_fnc_showMessage};

    [(_this select 1)] call EFUNC(kosherArsenal,forceClose);
    ["Closed units arsenal"] call zen_common_fnc_showMessage;
};

["CMF: Kosher Arsenal", "Close Kosher Arsenal", _dialogFunction, "rsc\data\icon_module_closeKosherArsenal_ca.paa"] call zen_custom_modules_fnc_register;
