#include "script_component.hpp"
/*
 * Author: Eric
 * module to reset a players role and/or team for kosher arsenal
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_resetKosherRoleModule
 *
 * Public: No
 */
SCRIPT(resetKosherRoleModule);

private _dialogFunction = {
    if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
    if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
    if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

    private _defaultRole = ((_this select 1) getVariable [QEGVAR(common,role), "RFL"]);
    private _defaultTeam = ((_this select 1) getVariable [QEGVAR(common,team), 0]);
    private _defaultLoadout = ((_this select 1) getVariable [QEGVAR(kosherArsenal,loadout), ""]);
    _defaultLoadout = _defaultLoadout splitString "\" select (count (_defaultLoadout splitString "\") - 1);
    _defaultLoadout = (_defaultLoadout splitString ".") select 0;

    private _onConfirm = {
        params["_dialogValues", "_unit", "_defaultRole", "_defaultTeam", "_defaultLoadout"];

        _dialogValues params[["_role", _defaultRole], ["_team", _defaultTeam], ["_loadout", _defaultLoadout]];

        /* Set the unit's role and team */
        [_unit, _role, _team] call EFUNC(organization,setRole);

        /* Set the unit's loadoutfile */
        private _loadout = format["rsc\loadouts\%1.sqf", _loadout];
        if !(FILE_EXISTS(_loadout)) exitWith { [LSTRING(no_loadoutFile_message)] call zen_common_fnc_showMessage };
        _unit setVariable [QEGVAR(kosherArsenal,loadout), _loadout, true];

        /* Open kosher arsenal */
        [_unit] call EFUNC(common,stripUnit);
        [_unit] call EFUNC(kosherArsenal,forceArsenal);
        [LSTRING(reset_kosherArsenal_success_message)] call zen_common_fnc_showMessage;
    };

    [LSTRING(change_kosherArsenal_module_displayname), [
        ["EDIT", [LSTRING(role), LSTRING(role_tooltip)], [_defaultRole]],
        ["SLIDER", [LSTRING(team), LSTRING(team_tooltip)], [0, 100, _defaultTeam, 0]],
        ["EDIT", [LSTRING(loadout), LSTRING(loadout_tooltip)], [_defaultLoadout]]
    ], _onConfirm, {}, (_this select 1), _defaultRole, _defaultTeam, _defaultLoadout] call zen_dialog_fnc_create;
};

[LSTRING(common_module_category_displayname), LSTRING(change_kosherArsenal_module_displayname), _dialogFunction, ""] call zen_custom_modules_fnc_register;
