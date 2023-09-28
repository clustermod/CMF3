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
 * [getPosASL _fuel, 5, 10] call cmf_enhancedVehicles_fnc_fire
 *
 * Public: Yes
 */

// @TODO replace spawn
[_this, {
    params ["_source", "_radius", "_intensity", ["_condition", { true }], ["_params", []]];

    private _fireEmitter = "#particlesource" createVehicle [0, 0, 0];
    private _smokeEmitter = "#particlesource" createVehicle [0, 0, 0];
    if (_source isEqualType objNull) then {
        _fireEmitter setPosASL getPosASL _source;
        _fireEmitter attachTo [_source];
        _smokeEmitter setPosASL getPosASL _source;
        _smokeEmitter attachTo [_source];
    } else {
        _fireEmitter setPosASL _source;
        _smokeEmitter setPosASL _source;
    };

    private _life = (_radius * 0.7) * 0.4;
    private _speed = 0.4;
    private _size = 0.9;
    private _effectSize = (_radius * 0.8) * 0.8;
    private _orientation = 0;
    private _density = (_radius * 0.7) * 30;

    /* Fire Particle effect creation */
    _fireEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 10, 32, 1], "", "Billboard", 1, 1.5, [0, 0, 0], [0, 1, 0], 0, 0.045, 0.04, 0.05, [1.8, 0.12], [[1,1,1,-1]], [0.5, 1], 0, 0, "", "", _fireEmitter];
    _fireEmitter setDropInterval (0.15 - 0.01 * _radius);
    _fireEmitter setParticleRandom [0.4, [_radius - 0.1, _radius - 0.1, 0.3], [0.1, 0.5, 0.1], 0, 0.1, [0.1,0.1,0.1,0], 0, 0, 0.1];

    /* Smoke Particle effect creation */
    _smokeEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 0, 40, 1], "", "Billboard", 1, 22, [0,0,0], [0,2.5,0], 1, 0.05, 0.04, 0.05, [2, 20], [[0.35,0.35,0.35,0.6],[0.35,0.35,0.35,0.75],[0.35,0.35,0.35,0.45],[0.42,0.42,0.42,0.28],[0.42,0.42,0.42,0.16],[0.42,0.42,0.42,0.09],
        [0.42,0.42,0.42,0.06],[0.5,0.5,0.5,0.02],[0.5,0.5,0.5,0]], [1,0.55,0.35], 0.3, 0.2, "", "", _smokeEmitter];
    _smokeEmitter setDropInterval (0.65 - 0.05 * _radius);
    _smokeEmitter setParticleRandom [8, [5,5,0.15], [0.25,0.5,1.25], 0.5, 0, [0,0,0,0.06], 0, 0, 0.5];

    /* Light creation */
    _lightSize = (1 + (_radius * 0.7)) / 2;
    _light = "#lightpoint" createVehicleLocal (getPos _fireEmitter);
    if (_source isEqualType objNull) then {
        _light setPosASL [(getPosASL _source) select 0, (getPosASL _source) select 1, ((getPosASL _source) select 2) + 0.5];
        _light attachTo [_source];
    } else {
        _light setPosASL [_source select 0, _source select 1, (_source select 2) + 0.5];
    };
    _light setLightBrightness 1.0;
    _light setLightColor [1, 0.65, 0.4];
    _light setLightAmbient [0.15, 0.05, 0];
    _light setLightIntensity (50 + 400 * _lightSize);
    _light setLightAttenuation [0, 0, 0, 1];
    _light setLightDayLight false;

    ["ace_fire_addFireSource", [_source, _radius, _intensity, _source, _condition, _params]] call CBA_fnc_serverEvent;

    waitUntil { !(_params call _condition) };
    deleteVehicle _fireEmitter;
    deleteVehicle _light;
    sleep 10;
    deleteVehicle _smokeEmitter;
}] remoteExec ["spawn", 0, false]
