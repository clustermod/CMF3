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
 * call cmf_zeus_fnc_setLives
 *
 * Public: No
 */
SCRIPT(setLives);

if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

private _onConfirm = {
    params["_dialogValues", "_unit"];
    [[_unit, round(_dialogValues select 0), (_dialogValues select 1)], EFUNC(respawn,setLimit)] remoteExec ["call", _unit, true];
    [format[LSTRING(setRespawns_success_message), round(_dialogValues select 0)]] call zen_common_fnc_showMessage
};

[LSTRING(setRespawns_module_displayname), [
    ["SLIDER", [LSTRING(respawns_title), LSTRING(respawns_tooltip)], [0, 100, ((_this select 1) getVariable [QEGVAR(respawn,respawns)]), 0]],
    ["CHECKBOX", [LSTRING(silent_title), LSTRING(silent_tooltip)], false]
], _onConfirm, {}, (_this select 1)] call zen_dialog_fnc_create;