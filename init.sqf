/*
 * Author: Eric
 * example mission initialization, executed when mission is started (before briefing screen).
 *
 *Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: Yes
*/

// Freeze time entirely
call EMF_fnc_setDate;
// Don't allow removing grass in tawd view distance script
tawvd_disablenone = true;
// Remove squad bar from ShackTack User Interface
STHud_NoSquadBarMode = true;
// Disable CTAB on vehicles
cTab_vehicleClass_has_FBCB2 = [];
// Set theme of music radio
klpq_musicRadio_radioThemes = ["t_russian"];

{
	if (!isPlayer _x) then {
		// Prevent AI units from going prone
		[false, _x] call EMF_fnc_preventProne;
	};
	// Set skill of Opfor Units for area suppression
	if ((Side _x) == east) then {
		_x setSkill ["aimingAccuracy", 	0.3 ];
		_x setSkill ["aimingShake", 	0.5 ];
		_x setSkill ["aimingSpeed", 	0.3 ];
		_x setSkill ["spotDistance", 	0.2 ];
		_x setSkill ["spotTime", 	0.5 ];
		_x setSkill ["courage", 	0.5 ];
		_x setSkill ["commanding", 	0.5 ];
		_x setSkill ["general", 	0.4 ];
		_x setSkill ["reloadSpeed", 	0.5 ];
		_x setSkill ["endurance", 	0.5 ];
	};
}forEach allUnits;
