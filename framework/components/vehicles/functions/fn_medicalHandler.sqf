#include "script_component.hpp"
/*
 * Author: Eric
 * Handles medical damage for crew in ehv enabled vehicles
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_vehicles_fnc_medicalHandler
 *
 * Public: No
 */
params ["_veh", "_projectile", "_hitPoint"];
SCRIPT(medicalHandler);

/* apply damage to crew */
{
    [_x, 0.7, "rightleg", "explosive"] call ace_medical_fnc_addDamageToUnit;
    [_x, 0.7, "leftleg", "explosive"] call ace_medical_fnc_addDamageToUnit;
    [_x, 0.5, "rightarm", "explosive"] call ace_medical_fnc_addDamageToUnit;
    [_x, 0.5, "leftarm", "explosive"] call ace_medical_fnc_addDamageToUnit;
    [_x, 0.3] call ace_medical_fnc_adjustPainLevel;
} forEach crew _veh;
