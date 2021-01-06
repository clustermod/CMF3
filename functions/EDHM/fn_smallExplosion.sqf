/*
 * Author: Eric
 * Small explosion effect
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Shockwave <BOOLEAN>
 * 2: SurfaceType <NUMBER>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [(getPos this), true, 4] call EMF_fnc_smallExplosion
 *
 * Public: Yes
 */
IED_SMOKE_SMALL = {
	_pos = _this select 0;
	_aslPos = [_pos select 0, _pos select 1, getTerrainHeightASL [_pos select 0, _pos select 1]];

	0 = _aslPos spawn {
		_aslPos = _this;

		_smoke1 = "#particlesource" createVehicleLocal _aslPos;
		_smoke1 setposasl _aslPos;
		_smoke1 setParticleCircle [0, [0, 0, 0]];
		_smoke1 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 8], [1+random 5, 1+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .01;

		_smoke2 = "#particlesource" createVehicleLocal _aslPos;
		_smoke2 setposasl _aslPos;
		_smoke2 setParticleCircle [0, [0, 0, 0]];
		_smoke2 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 8], [1+random 5, 1+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .01;

		_smoke3 = "#particlesource" createVehicleLocal _aslPos;
		_smoke3 setposasl _aslPos;
		_smoke3 setParticleCircle [0, [0, 0, 0]];
		_smoke3 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 8], [1+random 5, 1+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .01;

		_smoke4 = "#particlesource" createVehicleLocal _aslPos;
		_smoke4 setposasl _aslPos;
		_smoke4 setParticleCircle [0, [0, 0, 0]];
		_smoke4 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 8], [1+random 5, 1+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .01;

		_smokes = [_smoke1,_smoke2, _smoke3,_smoke4];

		uisleep 1;

		_smoke1 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 9, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .03;

		_smoke2 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 9, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .03;

		_smoke3 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 9, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .03;

		_smoke4 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 9, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .03;

		uisleep 1;
		_smoke1 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 6], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 12, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .05;

		_smoke2 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 6], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 12, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .05;

		_smoke3 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 6], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 12, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .05;

		_smoke4 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1+random 5, 1+random 5, 6], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 12, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .05;

		uisleep 1;
		_smoke1 setParticleRandom [0, [1 + random 3, 1 + random 3, 5], [1, 1, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 16, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .05;

		_smoke2 setParticleRandom [0, [1 + random 3, 1 + random 3, 5], [1, 1, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 16, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .05;

		_smoke3 setParticleRandom [0, [1 + random 3, 1 + random 3, 5], [1, 1, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 16, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .05;

		_smoke4 setParticleRandom [0, [1 + random 3, 1 + random 3, 5], [1, 1, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 16, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .05;


		uisleep 2;
		{
			deletevehicle _x;
		} foreach _smokes;
	};
};

IED_SAND_DEBRIS =
{
	_pos = _this select 0;
	[_pos] spawn
	{
		_pos = _this select 0;
		_Debris = "#particlesource" createVehicleLocal _pos;
		_Debris setParticleClass "debris_med";

		uisleep 1;
		deleteVehicle _Debris
	};
};

SHOCK_WAVE = {
	_pos = _this select 0;
	_aslPos = [_pos select 0, _pos select 1, getTerrainHeightASL [_pos select 0, _pos select 1]];

	0 = _aslPos spawn {
		_aslPos = _this;
		_smoke1 = "#particlesource" createVehicleLocal _aslPos;
		_smoke1 setposasl _aslPos;
		_smoke1 setParticleCircle [0, [0, 0, 0]];
		_smoke1 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .0004;

		_smoke2 = "#particlesource" createVehicleLocal _aslPos;
		_smoke2 setposasl _aslPos;
		_smoke2 setParticleCircle [0, [0, 0, 0]];
		_smoke2 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .0004;

		_smoke3 = "#particlesource" createVehicleLocal _aslPos;
		_smoke3 setposasl _aslPos;
		_smoke3 setParticleCircle [0, [0, 0, 0]];
		_smoke3 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .0004;

		_smoke4 = "#particlesource" createVehicleLocal _aslPos;
		_smoke4 setposasl _aslPos;
		_smoke4 setParticleCircle [0, [0, 0, 0]];
		_smoke4 setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, .375, [6, 8, 10], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .0004;

		_smokes = [_smoke1, _smoke2, _smoke3, _smoke4];

		uisleep 0.07;
		{
			deletevehicle _x;
		} foreach _smokes;
	};
};

params["_pos", ["_shockWave", true], ["_surfaceType", 4]];

switch (_surfaceType) do
{
	case 1:
	{
		/* METAL */
		[_pos] call IED_SMOKE_SMALL;

	};

	case 2:
	{
		/* WOOD */
		[_pos] call IED_SMOKE_SMALL;

	};

	case 3:
	{
		/* URBAN */
		[_pos] call IED_SMOKE_SMALL;
		[_pos] call IED_SAND_DEBRIS;

	};

	case 4:
	{
		/* DUST */
		[_pos] call IED_SMOKE_SMALL;
		[_pos] call IED_SAND_DEBRIS;

	};
};

if (_shockWave) then
{
	[_pos] call SHOCK_WAVE;
};
