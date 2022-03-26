/*
 * Author: Eric
 * Handles units on fire for EHDM
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Lifetime <NUMBER>
 * 2: Rolls <NUMBER>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [this, 60, 3] call emf_edhm_fnc_handleUnitOnFire
 *
 * Public: Yes
 */
scriptName "functions\edhm\handleUnitOnFire.sqf";
params["_unit", "_lifetime", "_rolls"];

fnc_unit_fire = {
	private ["_spot","_fire_p","_lifetime","_unit","_rolls"];
	_spot = _this select 0;
	_lifetime = _this select 1;
	_unit = _this select 2;
	_rolls = _this select 3;
	_fire_p = "#particlesource" createVehicleLocal (getPosATL _spot);
	_fire_p setParticleCircle [0,[0,0,0]];
	_fire_p setParticleRandom [0.1,[0,0,0],[0,0,0],0.1,0.1,[0,0,0,0.1],1,0];
	_fire_p setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",16,15,10,1],"","Billboard",1,0.3,[0,0,0],[0,0,0],15,7,7.9,1,[0.5,0.5,0.1],[[1,1,1,1],[1,1,1,1],[1,1,1,0]],[2],1,0,"","",_spot];
	_fire_p setDropInterval 0.05;

	private _fum = "#particlesource" createVehicleLocal (getpos _unit);
	_fum setParticleCircle [0,[0,0,0]];
	_fum setParticleRandom [1,[0.2,0.2,0],[0,0,0],10,0.3,[0,0,0,0.1],1,0];
	_fum setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,0.5,[0,0,1],[0,0,0],15,8,7.9,0.1,[0.5,2,3],[[0.5,0.2,0.2,0],[0,0,0,0.5],[1,1,1,0]],[1],1,0,"","",_unit];
	_fum setDropInterval 0.1;

	[_unit, _fum, _fire_p, _rolls, _lifetime] spawn
	{
		params["_unit", "_fum", "_fire_p", "_rolls", "_lifetime"];
		waitUntil{(vehicle _unit) == _unit};

		for "_i" from 1 to random[1, 2, 5] do
		{
			private _trueLifetime = time + _lifetime;
			waitUntil {inputAction "leanLeft" == 1 and (stance _unit == "PRONE") || inputAction "leanRight" == 1 and (stance _unit == "PRONE") || _trueLifetime < time};
			if (_trueLifetime < time) exitWith{_unit setDamage 1; uisleep 6;};
			uisleep 1;
		};
		uisleep 30;
		deleteVehicle _fum;
		deleteVehicle _fire_p;
	};
};

if (!hasInterface) exitwith {};

_unit	= _this select 0;
_lifetime	= _this select 1;

private _pct_unit = ["leftfoot","rightfoot","leftforearmroll","rightshoulder"];
private _part_fire = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
_part_fire attachTo [_unit, [0,0,0],"pelvis"];
private _fire_obj_unit = [_part_fire];
{
	private _onf = random 10;
	if (_onf>5) then
	{
		_part_fire = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
		_part_fire attachTo [_unit, [0,0,0],_x];
		_fire_obj_unit pushBack _part_fire;
	};
} forEach _pct_unit;

{[_x,_lifetime,_unit,_rolls] spawn fnc_unit_fire} foreach _fire_obj_unit;

private _li_fire = "#lightpoint" createVehicleLocal getPosATL _unit;
_li_fire lightAttachObject [_unit, [0,0,1]];
_li_fire setLightAttenuation [/*start*/ 0,/*constant*/0,/*linear*/0,/*quadratic*/0,/*hardlimitstart*/0.1,10];
_li_fire setLightBrightness 1;
_li_fire setLightDayLight true;
_li_fire setLightAmbient[1,0.2,0.1];
_li_fire setLightColor[1,0.2,0.1];

[_li_fire] spawn {
	private _lit = _this select 0;
	sleep 0.5;
	_lit setLightBrightness 10;
	while {alive _lit} do
	{
		_lit setLightBrightness 0.1+(random 0.9);
		_lit setLightAttenuation [0,0,100,0,0.1,5+(random 5)];
		sleep (0.05 + (random 0.1));
	};
};

[_unit, _lifetime, _rolls, _fire_obj_unit, _li_fire] spawn
{
	params["_unit", "_lifetime", "_rolls", "_fire_obj_unit", "_li_fire"];

	waitUntil{(vehicle _unit) == _unit};

	for "_i" from 1 to _rolls do
	{
		private _trueLifetime = time + _lifetime;
		waitUntil {inputAction "leanLeft" == 1 and (stance _unit == "PRONE") || inputAction "leanRight" == 1 and (stance _unit == "PRONE") || _trueLifetime < time};
		if (_trueLifetime < time) exitWith{_unit setDamage 1;};
		uisleep 1;
	};

	if (_unit == player and alive _unit) then {
		hint "Fire extinguished!";
	};

	if (alive _unit) then
	{
		{deleteVehicle _x} foreach _fire_obj_unit;
		deleteVehicle _li_fire;
	} else {
		uisleep 30;
		{deleteVehicle _x} foreach _fire_obj_unit;
		deleteVehicle _li_fire;
	}

};
