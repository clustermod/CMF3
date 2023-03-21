#include "script_component.hpp"
/*
 * Author: Eric
 * Handles fuel leaks from vehicle for enhancedVehicles
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * this spawn cmf_enhancedVehicles_fnc_fuelLeakEH;
 *
 * Public: Yes
 */

params ["_veh"];

if (!isServer) exitWith { };

while { alive _veh } do {
	waitUntil { (_veh getHitPointDamage "HitFuel") >= 0.9 };

	private _fuelPos = getPosATL _veh;
	_fuelPos set [2, 0];

	/* Create fuel tank and simulate the spill getting larger and larger */
	private _fuel = createSimpleObject ["WaterSpill_01_Large_Foam_F", [0, 0, 0]];
	[_fuel, 0.01] remoteExec ["setObjectScale", 0];
	sleep 0.1;
	_fuel setPosATL _fuelPos;
	_fuel setVectorUp surfaceNormal getPos _fuel;
	_fuel setDir random 360;

	/* Handle fuel expansion */
	private _expHandler = [_fuel, _veh] spawn {
		params ["_fuel", "_veh"];

		private _fuelAmount = fuel _veh;
		private _finalScale = 0.01;
		for "_scale" from 0.01 to _fuelAmount step 0.001 do {
			if (_fuel distance2D _veh >= 5) exitWith { };
			[_fuel, _scale] remoteExec ["setObjectScale", 0];
			sleep 0.08;
			_finalScale = _scale;
		};

		/* Sync it for JIP players */
		[_fuel, _finalScale] remoteExec ["setObjectScale", 0, true];
	};

	/* Handle fuel fire probability */
	[_fuel, _veh, _expHandler] spawn {
		params ["_fuel", "_veh", "_expHandler"];

		while { _veh distance2D _fuel <= 2 } do {
			sleep 5;

			if (random 100 < 10) exitWith {
				terminate _expHandler;
				private _boundingRect = boundingBoxReal _fuel;
				private _radius = ((((_boundingRect select 1) select 1) - ((_boundingRect select 0) select 0)) / 2) * getObjectScale _fuel;

				private _burnEnd = time + 300;
				[getPosASL _fuel, _radius, 10, { (_this select 0) > time }, [_burnEnd]] call FUNC(fire);

				/* Light crew on fire */
				{
					["ace_fire_addFireSource", [_x, 1, 4, _x]] call CBA_fnc_serverEvent;
				} forEach crew _veh;
			};
		};
	};

	waitUntil { _fuel distance2D _veh >= 2 };
	sleep 1;
}