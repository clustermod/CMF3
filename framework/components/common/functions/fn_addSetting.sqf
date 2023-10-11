#include "script_component.hpp"
/*
 * Author: Eric
 * Adds a CMF setting for configuring cmf
 * 
 * Arguments:
 * 0: Variable Name <STRING>
 * 1: Setting Type <STRING>
 * 2: Title <ARRAY/STRING>
 * 3: Category <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myVariable", "CHECKBOX", ["My Setting", "My Tooltip"], "Setting Category"] call cmf_common_fnc_addSetting;
 * 
 * Public: Yes
 */
params["_uniqueName", "_type", "_title", "_category", "_valueInfo", ["_isGlobal", 0], ["_script", {}]];

if (isNil QGVAR(missionSettings)) then {
	GVAR(missionSettings) = [] call CBA_fnc_hashCreate;
};

if (isNil QGVAR(clientSettings)) then {
	GVAR(clientSettings) = [] call CBA_fnc_hashCreate;
};

if (_isGlobal isEqualTo 0) then {
	[_uniqueName, _type, _title, [QUOTE(FRAMEWORK - Client), _category], _valueInfo, _isGlobal] call CBA_fnc_addSetting;

	/* Update settings hash */
	private _settingCategory = [GVAR(clientSettings), _category, []] call CBA_fnc_hashGet;
	_settingCategory pushBack [_uniqueName, _title, _isGlobal];
	GVAR(clientSettings) = [GVAR(clientSettings), _category, _settingCategory] call CBA_fnc_hashSet;
} else {
	[_uniqueName, _type, _title, [QUOTE(FRAMEWORK - Mission), _category], _valueInfo, _isGlobal] call CBA_fnc_addSetting;

	/* Update settings hash */
	private _settingCategory = [GVAR(missionSettings), _category, []] call CBA_fnc_hashGet;
	_settingCategory pushBack [_uniqueName, _title, _isGlobal];
	GVAR(missionSettings) = [GVAR(missionSettings), _category, _settingCategory] call CBA_fnc_hashSet;
};

