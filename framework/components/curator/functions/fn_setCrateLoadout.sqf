#include "script_component.hpp"
/*
 * Author: Eric
 * Sets crate loadout for a selected crate based on a crate type and logistics file
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [] call cmf_curator_fnc_setCrateLoadout
 * 
 * Public: No
 */

private _crate = _this param [1, objNull];

if (isNull _crate) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };

private _setLoadout = {
	params ["_values", "_crate"];

	private _path = format["rsc\loadouts\%1.sqf", (_values select 0)];
	if !(FILE_EXISTS(_path)) exitWith { ERROR_MSG_1("Unable to find preset: %1", (_values select 0)); };

	private _presets = [call compile preprocessFileLineNumbers _path] call CBA_fnc_hashCreate;
	private _preset = [_presets, (_values select 1)] call CBA_fnc_hashGet;
	private _presetData = [_preset] call FUNC(presetCompile);

	[_crate, _presetData] call FUNC(fillCrate); // @BUG: Does not work in 3DEN Preview from zeus
	["Set Crate Loadout"] call zen_common_fnc_showMessage;
};

_defaultFile = missionNamespace getVariable [QEGVAR(logistics,crateConfigFile), ""];

["Set Crate Loadout", [
	["EDIT", ["Logistics File", "Logistics file to use"], [_defaultFile]],
	["EDIT", ["Crate type", "Type of create to make e.g. Fireteam, Medical etc. (case sensitive)"], [""]]
], _setLoadout, {}, _crate] call zen_dialog_fnc_create;