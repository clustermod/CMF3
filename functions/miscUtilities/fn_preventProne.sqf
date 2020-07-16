/*
 * Author: Eric
 * Disable going prone for supplied unit.
 *
 * Arguments:
 * 0: Unit <OBJECT/ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[Unit1, Unit2, Unit3]] call EMF_fnc_preventProne
 *
 * Public: Yes
*/


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

if (isNil "_unit") then {
    'EMFpreventProne!Error [Unit not set]' remoteExec ["hint", 0];
};

switch (typeName _unit) do {
    case ("ARRAY"): {
			{
				[_x] call _EMF_FUNC_PreventProne;
			} forEach _unit;
    };
		case ("OBJECT"): {
			[_unit] call _EMF_FUNC_PreventProne;
		};
		default {
		    (format['EMFpreventProne!Error [Unit must be a object or an array : %1', (typeName _unit)]) remoteExec ["hint", 0];
		};
};
