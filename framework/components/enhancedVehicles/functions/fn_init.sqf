#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes enhanced vehicles on passed vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [myVehicle] call cmf_enhancedVehicles_fnc_init
 *
 * Public: Yes
 */
SCRIPT(init);

params["_veh"];

/* Projectile cache */
GVAR(projectileCache) = [] call CBA_fnc_hashCreate;

/* Vehicle cache */
GVAR(vehicleCache) = [] call CBA_fnc_hashCreate;

/* Code to handle damage */
private _damageHandle = {
    params ["_veh", "_selection", "_damage", "", "_projectile", "", "", "_hitPoint"];

    /* Check if vehicle is local */
    if !(local _veh) exitWith {};

    /* Check if enhancedVehicles has been disabled */
    if (missionNamespace getVariable [QGVAR(disable), false]) exitWith {};

    /* Get the projectile type the vehicle was hit with */
    private _projectileType = [GVAR(projectileCache), _selection, nil] call CBA_fnc_hashGet;
    if (isNil "_projectileType") then {
        _projectileType = getNumber (configfile >> "CfgAmmo" >> _projectile >> "explosive");

        if (isNil "_projectileType") then {
            _projectileType = 0;
        };

        GVAR(projectileCache) = [GVAR(projectileCache), typeOf _veh, _projectileType] call CBA_fnc_hashSet;
    };

    /* Get the vehicle selectionNames */
    private _vehicleSelections = [GVAR(vehicleCache), typeOf _veh, []] call CBA_fnc_hashGet;
    if (_vehicleSelections isEqualTo []) then {
        private _engineName = getText (configFile >> "cfgVehicles" >> (typeOf _veh) >> "HitPoints" >> "HitEngine" >> "name");
        private _fuelName = getText (configFile >> "cfgVehicles" >> (typeOf _veh) >> "HitPoints" >> "HitFuel" >> "name");

        _vehicleSelections = [_engineName, _fuelName];

        GVAR(vehicleCache) = [GVAR(vehicleCache), typeOf _veh, _vehicleSelections] call CBA_fnc_hashSet;
    };


    /* Check if the damage is enough to kill the vehicle, and if it is take over the damage handling */
    //LOG_2("%1 in %2 || %1 == """"", _selection, str _vehicleSelections);
    if (_damage > 0.8 && ((_selection in _vehicleSelections) || _selection isEqualTo "")) then {
        LOG_2("Registered damage on selection: %1 = %2", _selection, str _damage);

        /* If the projectile type was explosive play cool visual and audiable effects */
        if ((_projectileType isEqualTo 1)) then {
            [_veh, _projectile, _hitPoint] spawn {
                params["_veh", "_projectile", "_hitPoint"];
                {
                    /* Handle medical for units in hit vehicle */
                    [[_veh, _projectile, _hitPoint], FUNC(medicalHandler)] remoteExec ["call", _x];

                    /* Handle local sound and visual effects for players in vehicle */
                    if (isPlayer _x) then {
                        [[], FUNC(localEffect)] remoteExec ["call", _x];
                    };
                } forEach crew _veh;
            };
        };

        /* Disable engine */
        if (_veh getHit "motor" != 1) then {
            LOG_2("Vehicled disabled: %1 = %2", _selection, str _damage);
            _veh setHit ["motor", 1];
        };

        /* Allow fueltank to start leaking */
        if (_selection != "fuel") then {
            _damage = 0.8;
        };

        /* Raise event */
        [QGVAR(onDisabled), [_veh, _projectile, _hitPoint], _veh] call CBA_fnc_targetEvent;
    };

    /* Set the damage amount on the vehicle */
    _damage;
};

/* Create chance of fuel leak fire */
private _fuelLeakHandler =  {
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
                        ["ace_fire_addFireSource", [_x, 1, 7, _x, { (_this select 0) > time }, [_burnEnd]]] call CBA_fnc_serverEvent;
                    } forEach crew _veh;
                };
            }
        };

        waitUntil { _fuel distance2D _veh >= 2 };
        sleep 1;
    }
};

/* Add the eventhandler */
if (_veh isKindOf "car" || _veh isKindOf "tank") then {
    _veh setVariable ["ace_cookoff_enable", false, true];
    _veh addEventHandler ["HandleDamage", _damageHandle];

    _veh spawn _fuelLeakHandler;

    LOG_1("Added EnhancedVehicles to %1", typeOf _veh);

    /* Raise event */
    [QGVAR(enableEnhancedVehicles), [_veh], _veh] call CBA_fnc_targetEvent;
};

/* Initialize Offroading script on vehicle */
if (_veh isKindOf "car") then {
    [_veh] call FUNC(offroading);
    LOG_1("Added Offroading to %1", typeOf _veh);
};
