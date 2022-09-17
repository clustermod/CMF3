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
 * [] call emf_zeus_fnc_resetKosherRoleModule
 *
 * Public: No
 */
scriptName "functions\zeus\fn_resetKosherRoleModule.sqf";

private _dialogFunction = {
  if (isNull (_this select 1)) exitWith {["Must select a unit"] call zen_common_fnc_showMessage};
  if !((_this select 1) isKindOf "Man") exitWith {["Selected object must be a unit"] call zen_common_fnc_showMessage};
  if !(isPlayer (_this select 1)) exitWith {["Selected unit must be player"] call zen_common_fnc_showMessage};

  private _defaultRole = ((_this select 1) getVariable ["emf_utilities_setRole_role", "RFL"]);
  private _defaultTeam = ((_this select 1) getVariable ["emf_utilities_setRole_team", 0]);
  private _defaultLoadout = ((_this select 1) getVariable ["emf_kosherArsenal_loadout", ""]);
  _defaultLoadout = _defaultLoadout splitString "\" select (count (_defaultLoadout splitString "\") - 1);
  _defaultLoadout = (_defaultLoadout splitString ".") select 0;

  private _onConfirm = {
    params["_dialogValues", "_unit", "_defaultRole", "_defaultTeam", "_defaultLoadout"];

    _dialogValues params[["_role", _defaultRole], ["_team", _defaultTeam], ["_loadout", _defaultLoadout]];

    // Set team and role
    _unit setVariable ["emf_utilities_setRole_team", _team, true];
    _unit setVariable ["emf_utilities_setRole_role", _role, true];

    // Set loadout
    private _loadout = format["rsc\loadouts\%1.sqf", _loadout];
    if !(fileExists _loadout) exitWith {["Supplied loadoutfile doesn't exist"] call zen_common_fnc_showMessage};
    _unit setVariable ["emf_kosherArsenal_loadout", _loadout, true];

    // open kosher arsenal
    [_unit] call emf_utilities_fnc_stripUnit;
    [_unit] call emf_kosherArsenal_fnc_forceArsenal;
    ["Unit's kosher arsenal parameters have been changed"] call zen_common_fnc_showMessage
  };

  ["Set Role", [
    ["EDIT", ["Role", "Sets player's role"], [_defaultRole]],
    ["SLIDER", ["Team", "Sets player's team (If you are changing the units loadout leave this default)"], [0, 100, _defaultTeam, 0]],
    ["EDIT", ["Loadout", "Sets player's loadout. Only write filename without it's extension"], [_defaultLoadout]]
  ], _onConfirm, {}, (_this select 1), _defaultRole, _defaultTeam, _defaultLoadout] call zen_dialog_fnc_create;
};

["EMF", "Change kosher parameters", _dialogFunction, ""] call zen_custom_modules_fnc_register;
