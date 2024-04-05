#include "script_component.hpp"
/*
 * Author: Eric
 * Adds effects to vehicle when offroad
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * script handle <SCRIPT>
 *
 * Example:
 * [_myVehicle] call cmf_vehicles_fnc_offroading
 *
 * Public: Yes
 */
SCRIPT(offroading);

if (isNull objectParent cmf_player) exitWith {};

private _veh = objectParent cmf_player;
if ((driver _veh) isNotEqualTo cmf_player) exitWith {};

private _mass = getmass _veh;
private _size = boundingBox _veh;
private _hitPoints = (getAllHitPointsDamage _veh) select 1;
private _wheelIndex = [];

/* Get the wheel indexes of the vehicle */
for "_i" from 1 to (count _hitPoints) do {
    if !(((_hitPoints select (_i - 1)) find "wheel") isEqualTo -1) then {
        _wheelIndex pushBack (_i - 1);
    };
};

if (count _wheelIndex isEqualTo 0) exitWith {};

private _ix = ((_size select 1) select 0);
private _iy = ((_size select 1) select 1);
private _i2 = _mass * (1 / (count _wheelIndex)) * (sqrt(_ix*_ix + _iy*_iy)) * 10 * 0.25;
private _i3 = 0 - _i2;

/* Get the wheel mass of the vehicle */
private _cfgbin = ([ ["bin\config.bin"], configFile >> "CfgVehicles">> (typeOf _veh) >> "wheels" >> "LF" >> "mass" ] call BIS_fnc_loadClass);
if (isNull _cfgbin) then {
    _cfgbin = ([ ["bin\config.bin"], configFile >> "CfgVehicles">> (typeOf _veh) >> "wheels" >> "L1" >> "mass" ] call BIS_fnc_loadClass);
};
private _wheelmass = call compile (format['getNumber (%1)', ([_cfgbin, "", true] call BIS_fnc_configPath)]);

/* Check if vehicle is off road */
if !(((speed _veh) > 1) && { !(isOnRoad getPos _veh) && { (isTouchingGround _veh) } }) exitWith { };

/* Get the parameters for the current surface type */
private _curSurface = surfaceType getPos _veh;
private _surface = _curSurface select [1, (count _curSurface)];
private _surfaceParams = [_surface] call FUNC(getSurfaceParams);

if ((_surfaceParams select 1) isEqualTo -1) exitWith {
    GVAR(offroad_bump_delay) = time + 1;
    GVAR(offroad_damage_delay) = time + 1;
};

/* Apply bumps */
if (SETTING(offroadBumps)) then {
    if (time < GVAR(offroad_bump_delay)) exitWith {};

    /* Apply the bump settings */
    private _bumpParam = 1.2 * (_surfaceParams select 0) * 10;
    private _i1 = random [(_ix * _bumpParam), 0, (_iy * _bumpParam)];
    private _i2 = random [(_ix * _bumpParam), 0, (_iy * _bumpParam)];
    _veh addTorque (_veh vectorModelToWorld [_i1, _i2, 0]);
    LOG_1("Bump applied to: %1", _veh);

    private _delay = OFFROAD_BUMPSPEED / (abs (speed _veh));
    GVAR(offroad_bump_delay) = time + _delay;
};

/* Apply damage */
if (SETTING(offroadDamage)) then {
    if (time < GVAR(offroad_damage_delay)) exitWith {};

    if (speed _veh < OFFROAD_DAMAGESPEED) exitWith {
        private _delay = OFFROAD_DAMAGESPEED * 5 / (abs (speed _veh));
        GVAR(offroad_damage_delay) = time + _delay;
    };

    /* Apply the damage settings */
    private _damageParam = ((_surfaceParams select 0) / 100 * OFFROAD_DAMAGEMODIFIER / 100) * 0.5 * (15 / _wheelmass);
    private _wheel = selectRandom _wheelIndex;
    private _damageSeverity = (random [0, _damageParam, 0.4]);
    _veh sethitIndex [_wheel, (_veh getHitIndex _wheel) + _damageSeverity];
    LOG_1("Damage applied to: %1", _veh);

    private _delay = OFFROAD_DAMAGESPEED * 5 / (abs (speed _veh));
    GVAR(offroad_damage_delay) = time + _delay;
    playSound3D ["A3\Sounds_F\vehicles2\soft\shared\collisions\Vehicle_Soft_Collision_Medium_08.wss", _veh, false, _veh, 8 * _damageSeverity];
};