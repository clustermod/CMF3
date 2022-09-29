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
 * [] call cmf_zeus_fnc_removeRallypointModule
 *
 * Public: No
 */
SCRIPT(setLivesModule);

private _moduleFunction = {
    if (isNull (_this select 1)) exitWith { ["Must select a unit"] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { ["Selected object must be a unit"] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { ["Selected unit must be player"] call zen_common_fnc_showMessage };

    (_this select 1) setVariable [QEGVAR(respawn,showRallypoint), false, true];
    [format["Removed rallypoints from %1", name (_this select 1)]] call zen_common_fnc_showMessage;
};

["CMF: Respawn", "Remove rallypoint", _moduleFunction, "rsc\data\icon_ace_rallypoint_disabled_ca.paa"] call zen_custom_modules_fnc_register;
