#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to set a player's lives
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_zeus_fnc_setLivesModule
 *
 * Public: No
 */
SCRIPT(setLivesModule);

private _dialogFunction = {
    if (isNull (_this select 1)) exitWith { ["Must select a unit"] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { ["Selected object must be a unit"] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { ["Selected unit must be player"] call zen_common_fnc_showMessage };

    private _onConfirm = {
        params["_dialogValues", "_unit"];
        [[_unit, round(_dialogValues select 0), (_dialogValues select 1)], EFUNC(respawn,setLimit)] remoteExec ["call", _unit, true];
        [format["Set respawns to %1", round(_dialogValues select 0)]] call zen_common_fnc_showMessage
    };

    ["Set lives", [
        ["SLIDER", ["Lives", "Amount of lives to provide to player"], [0, 100, ((_this select 1) getVariable [QEGVAR(respawn,respawns)]), 0]],
        ["CHECKBOX", ["Silent", "If false will not show a hint to the player"], false]
    ], _onConfirm, {}, (_this select 1)] call zen_dialog_fnc_create;
};

["CMF: Respawn", "Set limit", _dialogFunction, "rsc\data\icon_module_setLives_ca.paa"] call zen_custom_modules_fnc_register;
