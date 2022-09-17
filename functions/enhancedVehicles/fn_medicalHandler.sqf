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
 * [] call emf_enhancedVehicles_fnc_medicalHandler
 *
 * Public: No
 */
SCRIPT(medicalHandler);

/* apply damage to player */
[player, 0.7, "rightleg", "explosive"] call ace_medical_fnc_addDamageToUnit;
[player, 0.7, "leftleg", "explosive"] call ace_medical_fnc_addDamageToUnit;
[player, 0.5, "rightarm", "explosive"] call ace_medical_fnc_addDamageToUnit;
[player, 0.5, "leftarm", "explosive"] call ace_medical_fnc_addDamageToUnit;
[player, 0.3] call ace_medical_fnc_adjustPainLevel;
