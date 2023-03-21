#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes enhanced vehicles on passed vehicle.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_enhancedVehicles_fnc_init
 *
 * Public: Yes
 */
SCRIPT(init);

private _enabled = ( CONFIG_PARAM_3(SETTINGS,enhancedVehicles,enable) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* Projectile cache */
GVAR(projectileCache) = [] call CBA_fnc_hashCreate;

/* Vehicle cache */
GVAR(vehicleCache) = [] call CBA_fnc_hashCreate;

/* Add the eventhandler */
private _fnc_initEH = {
    params ["_unit"];

    /* Exit if enhancedVehicles is disabled on vehicle or globally */
    if (missionNamespace getVariable [QGVAR(disable), false]) exitWith {};
    if (_unit getVariable [QGVAR(disable), false]) exitWith {};

    _unit setVariable ["ace_cookoff_enable", false, true];
    _unit addEventHandler ["HandleDamage", FUNC(damageEH)];

    _unit spawn FUNC(fuelLeakEH);

    LOG_1("Enabled EnhancedVehicles on %1", typeOf _unit);

    /* Raise event */
    [QGVAR(enableEnhancedVehicles), [_unit], _unit] call CBA_fnc_targetEvent;
};

["Car", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;
["Tank", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;

/* Initialize Offroading script on vehicle */
/* if (_veh isKindOf "car") then {
    [_veh] call FUNC(offroading);
    LOG_1("Added Offroading to %1", typeOf _veh);
};
 */