#include "script_component.hpp"
/*
 * Author: Eric
 * Sets a random loadout for a selected unit based on a role and loadoutfile
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [] call cmf_curator_fnc_randomLoadout
 * 
 * Public: No
 */

private _unit = _this param [1, objNull];

if (isNull _unit) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
if !(_unit isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };

private _randomizeLoadout = {
	params ["_values", "_unit"];

	private _loadout = format["rsc\loadouts\%1.sqf", _values select 1];
	if !(FILE_EXISTS(_loadout)) exitWith { ERROR_MSG_1("Unable to find loadoutfile: %1", _loadout) };
	private _whitelist = [_values select 0, player, true] call compile(preprocessFileLineNumbers _loadout);

	[_unit, _values select 0, _whitelist select 1] call EFUNC(kosherAI,setLoadout);

	["Randomized Loadout"] call zen_common_fnc_showMessage;
};

private _defaultRole = [_unit] call EFUNC(kosherAI,getRole);
private _defaultLoadout = (missionNamespace getVariable [QEGVAR(kosherAI,loadouts), [""]]) select 0;

["Set Random Loadout", [
	["EDIT", ["Role", "Role to set unit as"], [_defaultRole]],
	["EDIT", ["Loadout File", "Loadout file to use"], [_defaultLoadout]]
], _randomizeLoadout, {}, _unit] call zen_dialog_fnc_create;