/*
 * Author: Bohemia Interactive, Eric
 * example mission initialization, executed when mission is started (before briefing screen).
 *
 * Arguments:
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

call EMF_fnc_safeStart;

{
	if (!isPlayer _x) then {
		// Prevent AI units from going prone
		[_x] call EMF_fnc_preventProne;
	};
}forEach allUnits;
