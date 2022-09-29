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
 * [] call cmf_zeus_fnc_addRallypointModule
 *
 * Public: No
 */
SCRIPT(setLivesModule);

private _moduleFunction = {
    if (isNull (_this select 1)) exitWith { ["Must select a unit"] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { ["Selected object must be a unit"] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { ["Selected unit must be player"] call zen_common_fnc_showMessage };

    if !((_this select 1) getVariable [QEGVAR(respawn,rallypoint), false]) then {
        [[(_this select 1)]] call EFUNC(respawn,rallypoint);
    } else {
        (_this select 1) setVariable [QEGVAR(respawn,showRallypoint), true, true];
    };
    [format["Added rallypoints for %1", name (_this select 1)]] call zen_common_fnc_showMessage;
};

["CMF: Respawn", "Add rallypoint", _moduleFunction, "rsc\data\icon_ace_rallypoint_place_ca.paa"] call zen_custom_modules_fnc_register;
