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

        _damage = 0.8;

        /* Raise event */
        [QGVAR(onDisabled), [_veh, _projectile, _hitPoint], _veh] call CBA_fnc_targetEvent;
    };

    /* Set the damage amount on the vehicle */
    _damage;
};

/* Add the eventhandler */
if (_veh isKindOf "car" || _veh isKindOf "tank") then {
    _veh setVariable ["ace_cookoff_enable", false, true];
    _veh addEventHandler ["HandleDamage", _damageHandle];

    LOG_1("Added EnhancedVehicles to %1", typeOf _veh);

    /* Raise event */
    [QGVAR(enableEnhancedVehicles), [_veh], _veh] call CBA_fnc_targetEvent;
};

/* Initialize Offroading script on vehicle */
if (_veh isKindOf "car") then {
    [_veh] call FUNC(offroading);
    LOG_1("Added Offroading to %1", typeOf _veh);
};
