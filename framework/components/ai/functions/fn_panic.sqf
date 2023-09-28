#include "script_component.hpp"
/*
 * Author: Eric
 * When AI enteres panic mode they will either attempt to retreat or surrender
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [] call cmf_ai_fnc_panic
 * 
 * Public: No
 */

["lambs_danger_OnPanic", {
	params ["_unit", "_group"];

	 LOG_1("%1 Entered Panic Mode", _unit);

	if (isPlayer _unit) exitWith {};
	if (_unit getVariable [QGVAR(disablePanic), false]) exitWith {};

	private _groupUnits = units _group;

		/* 5% chance of surrendering */ 
	if (5 > random 100) exitWith { // @TODO Consider making it a configurable parameter
		LOG_1("%1 is surrendering", _unit);
		_unit playAction "Surrender";
	};

	/* 50% Chance of group retreating when paniced */
	if (50 > random 100) then { // @TODO Consider making it a configurable parameter
		LOG_1("%1 is Retreating", _unit);
		private _attackDir = _unit getDir (getAttackTarget _unit);
		private _retreatDir = (_attackDir + 180) % 360;
		private _retreatPos = _unit getPos [_retreatDir, random 500];

		/* Reset AI after retreat is successful */
		[_unit, _retreatPos, true] spawn lambs_wp_fnc_taskAssault;
		[_unit, _retreatPos] spawn {
			params ["_unit", "_pos"];

			waitUntil { _unit distance2D _pos < 30 };
			[_unit] call lambs_wp_fnc_taskReset;
		};
	};
}] call CBA_fnc_addEventHandler;