#include "script_component.hpp"

/* Projectile cache */
GVAR(projectileCache) = [] call CBA_fnc_hashCreate;

/* Vehicle cache */
GVAR(vehicleCache) = [] call CBA_fnc_hashCreate;

/* Add the eventhandler */
private _fnc_initEH = {
    params ["_vehicle"];

    /* Exit if enhancedVehicles is disabled on vehicle or globally */
    if (!GVAR(setting_enable)) exitWith {};
    if (_vehicle getVariable [QGVAR(disable), false]) exitWith {};

    _vehicle setVariable ["ace_cookoff_enable", false, true];
    _vehicle addEventHandler ["HandleDamage", FUNC(damageEH)];

    // Disable engine when damage is 0.8
    _vehicle addEventHandler ["Engine", {
        params ["_vehicle", "_engineState"];
        if (!_engineState || (_vehicle gethit "engine") < 0.8) exitWith {};
        _vehicle engineOn false;
    }];

    /* Fual leak */
    _vehicle spawn FUNC(fuelLeakEH);

    /* Offroading */
    [_vehicle] call FUNC(offroading);

    LOG_1("Enabled EnhancedVehicles on %1", typeOf _vehicle);
};

["Car", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;
["Tank", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;

[] call FUNC(gunEffectEH);