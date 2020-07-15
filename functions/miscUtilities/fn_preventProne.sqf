/*
 * Author: Eric
 * Disable going prone for supplied unit.
 *
 *Arguments:
 * (Will be rewritten)
 *
 * Return Value:
 * None
 *
 * Example:
 * (Will be rewritten)
 *
 * Public: Yes
*/


params["_all", "_mixed"];

private _EMFPPFunc =
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

if (_all) then
{
	{
		if (!isPlayer _x) then
		{
			if (isNil "_mixed") then
			{
				[_x] call _EMFPPFunc;
			} else {
				if (side _x == _mixed) then
				{
					[_x] call _EMFPPFunc;
				};
			};
		};
	}forEach allUnits;
} else {
	if (!isNil "_mixed") then
	{
		[_mixed] call _EMFPPFunc;
	};
};
