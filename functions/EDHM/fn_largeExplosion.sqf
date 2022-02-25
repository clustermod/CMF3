/*
 * Author: Eric
 * Large explosion effect
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
 * [(getPos this), true, 4] call emf_edhm_fnc_largeExplosion
 *
 * Public: Yes
 */
scriptName "functions\edhm\fn_largeExplosion.sqf";

IED_SMOKE_LARGE = {
	private _pos = _this select 0;
	private _aslPos = [_pos select 0, _pos select 1, getTerrainHeightASL [_pos select 0, _pos select 1]];

	0 = _aslPos spawn {

		_aslPos = _this;

		_smoke1 = "#particlesource" createVehicleLocal _aslPos;
		_smoke1 setposasl _aslPos;
		_smoke1 setParticleCircle [0, [0, 0, 0]];
		_smoke1 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .005;

		_smoke2 = "#particlesource" createVehicleLocal _aslPos;
		_smoke2 setposasl _aslPos;
		_smoke2 setParticleCircle [0, [0, 0, 0]];
		_smoke2 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .005;

		_smoke3 = "#particlesource" createVehicleLocal _aslPos;
		_smoke3 setposasl _aslPos;
		_smoke3 setParticleCircle [0, [0, 0, 0]];
		_smoke3 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .005;

		_smoke4 = "#particlesource" createVehicleLocal _aslPos;
		_smoke4 setposasl _aslPos;
		_smoke4 setParticleCircle [0, [0, 0, 0]];
		_smoke4 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8+random 5, 8+random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .005;

		_smokes = [_smoke1,_smoke2, _smoke3,_smoke4];

		sleep .5;

		_smoke1 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .005;

		_smoke2 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .005;

		_smoke3 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .005;

		_smoke4 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .005;

		sleep 1;

		_smoke1 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .005;

		_smoke2 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .005;

		_smoke3 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .005;

		_smoke4 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .005;

		sleep 1;

		_smoke1 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .01;

		_smoke2 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .01;

		_smoke3 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .01;

		_smoke4 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .01;

		sleep 1;

		_smoke1 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke1 setDropInterval .01;

		_smoke2 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke2 setDropInterval .01;

		_smoke3 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke3 setDropInterval .01;

		_smoke4 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslPos];
		_smoke4 setDropInterval .01;

		sleep 2;
		{
			deletevehicle _x;
		} foreach _smokes;

	};
};

SHOCK_WAVE = {
	private _pos = _this select 0;
	private _aslPos = [_pos select 0, _pos select 1, getTerrainHeightASL [_pos select 0, _pos select 1]];

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
		[_pos] call IED_SMOKE_LARGE;

	};

	case 2:
	{
		/* WOOD */
		[_pos] call IED_SMOKE_LARGE;

	};

	case 3:
	{
		/* URBAN */
		[_pos] call IED_SMOKE_LARGE;
		[_pos] call IED_SAND_DEBRIS;

	};

	case 4:
	{
		/* DUST */
		[_pos] call IED_SMOKE_LARGE;
		[_pos] call IED_SAND_DEBRIS;

	};
};

if (_shockWave) then
{
	[_pos] call SHOCK_WAVE;
};
