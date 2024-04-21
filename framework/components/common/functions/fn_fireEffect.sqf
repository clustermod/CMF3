#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a fire of given radius
 *
 * Arguments:
 * 0: Position of Fire or Object <ARRAY/OBJECT>
 * 1: Radius of Fire <NUMBER>
 * 2: Intensity of Fire [0,10] <NUMBER>
 * 3: Condition of fire (Default: { true }) <CODE>
 * 4: Condition Parameters (Default: []) <ARRAY>
 *
 * Return Value:
 * FireObject <OBJECT>
 *
 * Example:
 * [getPosASL _fuel, 5, 10] call cmf_common_fnc_fireEffect
 *
 * Public: Yes
 */

params ["_key", "_data"];
_data params ["_source", "_radius", "_intensity", ["_condition", { true }], ["_params", []]];

if (!isNull attachedTo _source) then {
    _source = attachedTo _source;
};

private _fireSource = "#particlesource" createVehicleLocal getPos _source;
private _smokeSource = "#particlesource" createVehicleLocal getPos _source;
_fireSource setPosASL getPosASLVisual _source;
_smokeSource setPosASL getPosASLVisual _source;
_fireSource attachTo [_source];
_smokeSource attachTo [_source];

GVAR(fireSources) = [GVAR(fireSources), _key, [_fireSource, _smokeSource]] call CBA_fnc_hashSet;

private _life = (_radius * 0.7) * 0.4;
private _speed = 0.4;
private _size = 0.9;
private _effectSize = (_radius * 0.8) * 0.8;
private _orientation = 0;
private _density = (_radius * 0.7) * 30;

/* Fire Particle effect creation */
_fireSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 10, 32, 1], "", "Billboard", 1, 1.5, [0, 0, 0], [0, 1, 0], 0, 0.045, 0.04, 0.05, [1.8, 0.12], [[1,1,1,-1]], [0.5, 1], 0, 0, "", "", _fireSource];
_fireSource setDropInterval 0.15 - 0.01 * _radius;
_fireSource setParticleRandom [0.4, [_radius - 0.1, _radius - 0.1, 0.3], [0.1, 0.5, 0.1], 0, 0.1, [0.1,0.1,0.1,0], 0, 0, 0.1];

/* Smoke Particle effect creation */
_smokeSource setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 0, 40, 1], "", "Billboard", 1, 22, [0,0,0], [0,2.5,0], 1, 0.05, 0.04, 0.05, [2, 20], [[0.35,0.35,0.35,0.6],[0.35,0.35,0.35,0.75],[0.35,0.35,0.35,0.45],[0.42,0.42,0.42,0.28],[0.42,0.42,0.42,0.16],[0.42,0.42,0.42,0.09],
    [0.42,0.42,0.42,0.06],[0.5,0.5,0.5,0.02],[0.5,0.5,0.5,0]], [1,0.55,0.35], 0.3, 0.2, "", "", _smokeSource];
_smokeSource setDropInterval 0.65 - 0.05 * _radius;
_smokeSource setParticleRandom [8, [5,5,0.15], [0.25,0.5,1.25], 0.5, 0, [0,0,0,0.06], 0, 0, 0.5];

/* Light creation */
_lightSize = (1 + _radius * 0.7) / 2;
_light = "#lightpoint" createVehicleLocal getPos _fireSource;
if (_source isEqualType objNull) then {
    _light setPosASL [getPosASL _source select 0, getPosASL _source select 1, (getPosASL _source select 2) + 0.5];
    _light attachTo [_source];
} else {
    _light setPosASL [_source select 0, _source select 1, (_source select 2) + 0.5];
};
_light setLightBrightness 1.0;
_light setLightColor [1, 0.65, 0.4];
_light setLightAmbient [0.15, 0.05, 0];
_light setLightIntensity 50 + 400 * _lightSize;
_light setLightAttenuation [0, 0, 0, 1];
_light setLightDayLight false;

[
    { !(((_this select 0) select 4) call ((_this select 0) select 3)) },
    {
        params ["", "_fireSource", "_light", "_smokeSource"];

        deleteVehicle _fireSource;
        deleteVehicle _light;
        [{
            deleteVehicle _this;
        }, _smokeSource, 10] call CBA_fnc_waitAndExecute;
    },
    [_data, _fireSource, _light, _smokeSource]
] call CBA_fnc_waitUntilAndExecute;