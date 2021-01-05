/*
 * Author: Eric
 * Handles explosion effects for EHDM
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Damage <NUMBER>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [this, 2500] call EMF_fnc_armorFire
 *
 * Public: Yes
 */
params ["_veh", "_Damage"];

if (_veh isKindOf "tank") then
{
	[_veh, true] remoteExecCall ["EMF_fnc_armorFire", 0];
};

private _pos = position _veh;
private _crew = crew _veh;
private _metalArray = ["metal", "wavymetal", "int_metal", "metalplate_exp", "metalplatepressed_exp", "int_metalplate_exp", "gridmetal_exp", "wavymetal_exp", "steel_exp"];
private _woodArray = ["wood", "int_wood", "int_solidwood_exp", "softwood_exp", "int_softwood_exp"];
private _dustArray = ["dirt", "dirt_exp", "mud_exp", "forest_exp", "sand", "sand_exp", "gravel", "gravel_exp", "seabed_exp", "drygrass", "grass", "grass_exp", "grasstall_exp"];
private _nopArray = ["rock", "stony", "stones_exp", "water"];
private _urbanArray = ["concrete", "int_concrete", "concrete_exp", "int_concrete_exp", "pavement_exp", "int_pavement_exp", "tarmac", "asphalt_exp", "tiling", "roof_tiles", "rooftiles_exp", "int_tiles"];

if (isserver) then
{
	private _playerDamage = 1;
	private _surfaceType = 0;
	private _surface = [(surfaceType getPos _veh), 1] call BIS_fnc_trimString;
	private _surfaceSound = getText (configfile >> "CfgSurfaces" >> _surface >> "soundEnviron");

	//No Operation Surface
	if ((_nopArray find _surfaceSound) <=0) then { _surfaceType = 0 };

	//Metal Surface
	if ((_metalArray find _surfaceSound) <=0) then { _surfaceType = 1 };

	//Wood Surface
	if ((_woodArray find _surfaceSound) <=0) then { _surfaceType = 2 };

	//Urban Surface
	if ((_urbanArray find _surfaceSound) <=0) then { _surfaceType = 3 };

	//Dust Surface
	if ((_dustArray find _surfaceSound) <=0) then { _surfaceType = 4 };

	if (_Damage <= 1000) then {[_pos, true, _surfaceType] remoteExecCall ["EMF_fnc_smallExplosion" , 0, false]; _playerDamage = 0};
	if (_Damage > 1000 && _Damage < 2000) then {[_pos, true, _surfaceType] remoteExecCall ["EMF_fnc_largeExplosion" , 0, false]; _playerDamage = 1};
	if (_Damage >= 2000) then {[_pos, true, _surfaceType] remoteExecCall ["EMF_fnc_mediumExplosion", 0, false]; _playerDamage = 2};

	if (_veh isKindOf "tank") then {_playerDamage = 3};
	[_veh, _crew, _playerDamage] remoteExecCall ["EMF_fnc_handleCameraEffects", 0, false];
};
