call EMF_fnc_setDate; // Freeze time entirely
tawvd_disablenone = true; // Don't allow removing grass entirely in tawd view distance script
STHud_NoSquadBarMode = true; // Remove squad bar from ShackTack User Interface
cTab_vehicleClass_has_FBCB2 = []; // Disable CTAB on vehicles
klpq_musicRadio_radioThemes = ["t_russian"]; // Set theme of music radio

{
	if (!isPlayer _x) then {
		[false, _x] call EMF_fnc_preventProne; // Prevent AI units from going prone (Only applied to pre-init units, any units spawned after init will not be affected)
	};

	if ((Side _x) == east) then { // Set Opfor AI Units skill to engage enemy units with area suppression rather than accurate suppression (Only applied to pre-init units, any units spawned after init will not be affected)
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
