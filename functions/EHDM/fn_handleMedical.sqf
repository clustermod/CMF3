/*
 * Author: Eric
 * Handles unit injuries for EHDM
 *
 * Arguments:
 * 0: playerDamage <NUMBER>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [1] call EMF_fnc_handleMedical
 *
 * Public: No
 */
params["_playerDamage"];

switch (_playerDamage) do
{
	case 0:
	{
		// Minor
		[player, 0.4, "rightleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.4, "leftleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.3] call ace_medical_fnc_adjustPainLevel;
	};
	case 1:
	{
		// Medium
		[player, 0.7, "rightleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.7, "leftleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.5, "rightarm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.5, "leftarm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.5] call ace_medical_fnc_adjustPainLevel;
	};
	case 2:
	{
		// Severe
		[player, 0.7, "rightleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.7, "leftleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.5, "rightarm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.6, "leftarm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.3, "Body", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.7] call ace_medical_fnc_adjustPainLevel;
	};
	case 3:
	{
		// Burn
		[player, 0.4, "rightleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.4, "leftleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.4, "rightarm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.4, "leftarm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.3, "Body", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[player, 0.5] call ace_medical_fnc_adjustPainLevel;
	};
};
