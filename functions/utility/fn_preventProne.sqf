#include "script_component.hpp"
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
 * [[Unit1, Unit2, Unit3]] call emf_utility_fnc_preventProne
 *
 * Public: Yes
*/
SCRIPT(preventProne);
params["_unit"];

(_this select 0) addEventHandler ["AnimChanged", {
	private _proneAnimArray = ["AmovPercMstpSlowWrflDnon_AmovPpneMstpSrasWrflDnon", "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon", "amovppnemstpsraswrfldnon", "AmovPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon"];
	params ["_unit", "_anim"];

	/* Check if animation is a state chagne animation to prone */
	if ((_anim in _proneAnimArray) OR (unitPos _unit == "down")) then {
		_unit setunitPos "middle"
	};
}];
