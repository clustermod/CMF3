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
 * [_myVehicle] call emf_enhancedVehicles_fnc_offroading
 *
 * Public: Yes
 */
SCRIPT(offroading);

/* Spawn code to handle offroad feature */
_this spawn {
    params["_veh"];

    /* Get which parts are enabled */
    private _offroadBumpEnabled = ( CONFIG_PARAM_3(SETTINGS,enhancedVehicles,offroadBumpy) ) isEqualTo 1;
    private _offroadDamageEnabled = ( CONFIG_PARAM_3(SETTINGS,enhancedVehicles,offroadDamage) ) isEqualTo 1;

    if (!_offroadBumpEnabled && !_offroadDamageEnabled) exitWith {};

    /* Get the configSettings */
    private _bumpSpeed = getNumber (missionConfigFile >> "CfgEnhancedVehicles" >> "bumpSpeed");
    private _damageModifier = getNumber (missionConfigFile >> "CfgEnhancedVehicles" >> "damageModifier");
    private _damagespeed = getNumber (missionConfigFile >> "CfgEnhancedVehicles" >> "damageSpeed");

    /* Pre-calculate vehicle size and mass */
    private _mass = getmass _veh;
    private _size = boundingBox _veh;
    private _hitPoints = (getAllHitPointsDamage _veh) select 1;
    private _wheelIndex = [];

    /* Get the wheel indexes of vehicle */
    for "_i" from 1 to (count _hitPoints) do {
        if !(((_hitPoints select (_i - 1)) find "wheel") isEqualTo -1) then {
            _wheelIndex pushBack (_i - 1);
        };
    };

    private _ix = ((_size select 1) select 0);
    private _iy = ((_size select 1) select 1);
    private _i2 = _mass * (1 / (count _wheelIndex)) * (sqrt(_ix*_ix + _iy*_iy)) * 10 * 0.25;
    private _i3 = 0 - _i2;


    /* Get the wheel mass of the vehicle */
    private _cfgbin = ([ ["bin\config.bin"], configFile >> "CfgVehicles">> (typeOf _veh) >> "wheels" >> "LF" >> "mass" ] call BIS_fnc_loadClass);
    if (isNull _cfgbin) then {
        _cfgbin = ([ ["bin\config.bin"], configFile >> "CfgVehicles">> (typeOf _veh) >> "wheels" >> "L1" >> "mass" ] call BIS_fnc_loadClass);
    };
    private _wheelmass = call compile (format['getNumber (%1)', ([_cfgbin,"",true] call BIS_fnc_configPath)]);

    /* Script that handles bumps */
    if (_offroadBumpEnabled) then {
        [_veh, _bumpSpeed, _i3, _i2] spawn {
            params["_veh", "_bumpSpeed", "_ix", "_iy"];

            /* Only run it serverside */
            if !(isServer) exitWith {};

            /* Loop the offroad checks */
            while { alive _veh && !(missionNamespace getVariable [QGVAR(disable), false]) } do {
                waitUntil{ uiSleep 0.02; ((speed _veh) > 1) && !(isOnRoad getPos _veh) && (isTouchingGround _veh) };

                /* Get the parameters for the current surface type */
                private _curSurface = surfaceType getPos _veh;
                private _surface = _curSurface select [1, (count _curSurface)];
                private _surfaceParams = [_surface] call FUNC(getSurfaceParams);

                /* Apply the bump settings */
                if !((_surfaceParams select 0) isEqualTo -1) then {
                    while {((speed _veh) > 1) && !(isOnRoad getPos _veh) && (isTouchingGround _veh) && (local _veh) && (_curSurface isEqualTo (surfaceType getPos _veh))} do {
                        private _bumpParam = 1.2 * (_surfaceParams select 0) / 100;
                        private _i1 = random [(_ix * _bumpParam), 0, (_iy * _bumpParam)];
                        private _i2 = random [(_ix * _bumpParam), 0, (_iy * _bumpParam)];
                        private _delay = _bumpSpeed / (abs (speed _veh));

                        sleep _delay;
                        _veh addTorque (_veh vectorModelToWorld [_i1, _i2, 0]);
                    };
                    sleep 0.1;
                } else {
                    sleep 1;
                };
            };
        };
    };

    /* Script that handles damage */
    if (_offroadDamageEnabled) then {
        [_veh, _damageModifier, _damagespeed, _wheelmass, _wheelIndex] spawn {
            params["_veh", "_damageModifier", "_damageSpeed", "_wheelmass", "_index"];

            /* Only run it serverside */
            if !(isServer) exitWith {};

            /* Loop the offroad checks */
            while { alive _veh && !(missionNamespace getVariable [QGVAR(disable), false])} do {
                waitUntil{ uiSleep 0.02; ((speed _veh) > 1) && !(isOnRoad getPos _veh) && (isTouchingGround _veh) };

                /* Get the parameters for the current surface type */
                private _curSurface = surfaceType getPos _veh;
                private _surface = _curSurface select [1, (count _curSurface)];
                private _surfaceParams = [_surface] call FUNC(getSurfaceParams);

                /* Apply the damage settings */
                if !((_surfaceParams select 1) isEqualTo -1) then {
                    while {((speed _veh) > 1) && !(isOnRoad getPos _veh) && (isTouchingGround _veh) && (local _veh) && (_curSurface isEqualTo (surfaceType getPos _veh))} do {
                        private _damageParam = ((_surfaceParams select 0) / 100 * _damageModifier / 100) * 0.5 * (15 / _wheelmass);
                        private _delay = _damageSpeed * 5 / (abs (speed _veh));

                        sleep _delay;

                        private _wheel = selectRandom _index;
                        private _damageSeverity = (random [0, _damageParam, 0.4]);
                        _veh sethitIndex [_wheel, (_veh getHitIndex _wheel) + _damageSeverity];
                        playSound3D ["A3\Sounds_F\vehicles2\soft\shared\collisions\Vehicle_Soft_Collision_Medium_08.wss", _veh, false, _veh, 8 * _damageSeverity];
                    };
                    sleep 0.1;
                } else {
                    sleep 1.5;
                };
            };
        };
    };
};
