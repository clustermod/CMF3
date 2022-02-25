/*
 * Author: Eric
 * Handles armor on fire for EHDM
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [this] call emf_edhm_fnc_armorFire
 *
 * Public: Yes
 */
scriptName "functions\edhm\fn_armorFire.sqf";
params["_veh"];

[_veh] spawn
{
	// Add flame effect on vehicle
	params[
		"_obj"
		, ["_attachPoint", [0,0,-1]]
		, ["_timeout", 300]
		, ["_color", [0.5,0.5,0.5]]
		, ["_particleSettings", [2, 20, 1, 1, 1, 5.4]]
		, ["_allowDamage", true]
	];

	// Variables
	private _colorRed = _color select 0;
	private _colorGreen = _color select 1;
	private _colorBlue = _color select 2;

	private _particleLifeTime = _particleSettings select 0;
	private _particleDensity = _particleSettings select 1;
	private _particleSize = _particleSettings select 2;
	private _particleSpeed = _particleSettings select 3;
	private _effectSize = _particleSettings select 4;
	private _orientation = _particleSettings select 5;

	private _damage = if (_allowDamage) then { 1 } else { 0 };

	private _emitter = "#particlesource" createVehicle [10,10,10];
	_emitter attachTo [_obj, _attachPoint];

	_emitter setParticleParams [
		["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32]
		,"","billboard",1,_particleLifeTime
		,[0,0,0],[0,0,0.4*_particleSpeed]
		,0,0.0565,0.05,0.03,[0.9*_particleSize,0],
		[
			[1*_colorRed,1*_colorGreen,1*_colorBlue,-0]
			,[1*_colorRed,1*_colorGreen,1*_colorBlue,-1]
			,[1*_colorRed,1*_colorGreen,1*_colorBlue,-1]
			,[1*_colorRed,1*_colorGreen,1*_colorBlue,-1]
			,[1*_colorRed,1*_colorGreen,1*_colorBlue,-1]
			,[1*_colorRed,1*_colorGreen,1*_colorBlue,0]
		],
		[1], 0.01, 0.02, "", "", "",_orientation,false,-1,[[3,3,3,0]]
	];
	_emitter setParticleRandom [_particleLifeTime/4, [0.15*_effectSize,0.15*_effectSize,0], [0.2,0.2,0], 0.4, 0, [0,0,0,0], 0, 0, 0.2];

	if (_damage > 0) then {_emitter setParticleFire [0.6*_damage, 0.25*_damage, 0.1];};
	_emitter setDropInterval (1/_particleDensity);

	private _smokeEmitter = "#particlesource" createVehicleLocal [0,0,0];
	_smokeEmitter setParticleClass "ObjectDestructionSmoke1_2Smallx";
	_smokeEmitter attachTo [_obj, _attachPoint];

	//--- light
	private _lightSize = (_particleSize + _effectSize)/2;

	private _light = createVehicle ["#lightpoint", (getPos _emitter), [], 0, "CAN_COLLIDE"];
	_light attachTo [_obj, _attachPoint];
	// _light setPos [(getPos _emitter) select 0, (getPos _emitter) select 1,((getPos _emitter) select 2) + 0.5];
	_light setLightBrightness 1.0;
	_light setLightColor [1,0.65,0.4];
	_light setLightAmbient [0.15,0.05,0];
	_light setLightIntensity (50 + 400*_lightSize);
	_light setLightAttenuation [0,0,0,1];
	_light setLightDayLight false;

	[_emitter, _light, _smokeEmitter, _timeout] spawn {
		params["_emitter","_light","_smokeEmitter","_timeout"];

		sleep _timeout;
		deleteVehicle _emitter;
		deleteVehicle _smokeEmitter;
		deleteVehicle _light;
	};

	{
		if (!isPlayer _x) then {
			[_x, 5, (random[4, 6, 8])] remoteExecCall ["emf_edhm_fnc_handleUnitOnFire", 0];
			[_x] spawn
			{
				private _unit = _this select 0;
				_unit removeWeapon (primaryWeapon _unit);
				_unit removeWeapon (secondaryWeapon _unit);
				_unit removeWeapon (handgunWeapon _unit);
				moveOut _unit;
				_unit action ["Eject", (vehicle _unit)];
				unassignVehicle _unit;
				waitUntil{(vehicle _unit) == _unit};
				_unit playAction "Panic";
				[_unit] join (createGroup [(side _unit), true]);

				{
					deleteWaypoint[(group _unit), (_x select 1)];
				} forEach waypoints _unit;
				private _panicWP = (group _unit) addWaypoint [(getPos _unit), 100];
				_panicWP setWaypointType "SAD";
				_panicWP setWaypointSpeed "FULL";
			};
		};
	} forEach crew _obj;

	uisleep 6;


	if (count crew _obj > 0) then {
		{
			if (_x == player) then {
				hint "You are on fire, disembark and roll to extinguish it!";
			};
			[_x, 10, (random[6, 9, 13])] remoteExecCall ["emf_edhm_fnc_handleUnitOnFire", 0];
		} forEach crew _obj;
	};
};
