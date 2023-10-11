#include "script_component.hpp"
/*
 * Author: Eric
 * Sets variables that can be accessed in the mission
 * 
 * Arguments:
 * 0: Variable Name <STRING>
 * 1: Variable Value <ANY>
 * 2: Namespace (optional, default: { missionNameSpace }) <Code>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myVariable", _myValue, missionNameSpace] call cmf_3den_fnc_missionSettings
 * 
 * Public: Yes
 */
params ["_varName", "_varValue", ["_namespace", { missionNameSpace }]];

/* Find logic */
private _logics = (all3DENEntities select 0) select { (_x get3DENAttribute 'Name') isEqualTo [QGVAR(data)] };
private _logic = objNull;
if (count _logics isEqualTo 0) then {
	_logic = create3DENEntity ['Object', 'Logic', [0,0,0], true];
	_logic set3DENAttribute ['Name', QGVAR(data)];

	_logic addEventHandler ['UnregisteredFromWorld3DEN', {
		params ['_entity'];
		['Deleted CMF Data! It is recommended to undo deletion!', 1, 5] call BIS_fnc_3DENNotification;
	}];
} else {
	_logic = _logics select 0;
};

private _logicInit = (_logic get3DENAttribute "Init") select 0;

private _commands = _logicInit regexReplace [format ["([^;]*?%1.*?);", _varname], format ["%1 setVariable [""%2"", %3]"]]; // @TODO: Fix variable settting


/* Set data */
GVAR(missionDataLogic) set3DENAttribute [
	"Init", 
	format [
		"if (!isServer) exitWith { }; %1 setVariable [""%2"", %3, true];",
		_namespace,
		QEGVAR(common,missionData),
		str _hash
	]
];

// @TODO: Finish this function