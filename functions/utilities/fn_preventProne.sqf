/*
 * Author: Eric
 * Disable going prone for supplied unit.
 *
 * Arguments:
 * 0: Unit <OBJECT/ARRAY>
 *
 * Return Value:
 * <BOOL>
 *
 * Example:
 * [[Unit1, Unit2, Unit3]] call emf_utilities_fnc_preventProne
 *
 * Public: Yes
*/
scriptName "functions\utilities\fn_preventProne.sqf";
params["_unit"];

private _EMF_FUNC_PreventProne =
{
	EMF_Prevent_Prone = ["AmovPercMstpSlowWrflDnon_AmovPpneMstpSrasWrflDnon ","AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon ","amovppnemstpsraswrfldnon","AmovPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon "];
	(_this select 0) addEventHandler ["AnimChanged",
		{
			private _unit = _this select 0;
			private _anim = _this select 1;
			private _anim_Restricted = _anim in EMF_Prevent_Prone;
			if ((_anim_Restricted) OR (unitPos _unit == "down")) then {_unit setunitPos "middle"};
		}
	];
};

if (isNil "_unit") exitWith {  ['Unit is not set'] call BIS_fnc_error; 'Unit is not set' call BIS_fnc_log;};

switch (typeName _unit) do {
    case ("ARRAY"): {
			{
				[_x] call _EMF_FUNC_PreventProne;
			} forEach _unit;
			true;
    };
		case ("OBJECT"): {
			[_unit] call _EMF_FUNC_PreventProne;
			true;
		};
		default {
				['Unit must be type "ARRAY" or "OBJECT", type %1 supplied', (typeName _unit)] call BIS_fnc_error;
				['Unit must be type "ARRAY" or "OBJECT", type %1 supplied', (typeName _unit)] call BIS_fnc_log;
				false;
		};
};
