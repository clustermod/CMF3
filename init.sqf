/*
 * Author: Bohemia Interactive, Eric
 * example mission initialization, executed when mission is started (before briefing screen).
 *
 */
scriptName "init.sqf";

// Freeze time entirely
call emf_utilities_fnc_setDate;

// Set theme of music radio
klpq_musicRadio_radioThemes = ["t_american"];

// Enable tracers for opfor
[east, true, false, false] call emf_gameplay_fnc_tracers;

// kosherAILoadout
//[east, "testLoadout"] execVM "rsc\kosherAI.sqf";

call emf_gameplay_fnc_safeStart;

{
	if (!isPlayer _x) then {
		// Prevent AI units from going prone
		[_x] call emf_utilities_fnc_preventProne;
	};
}forEach allUnits;
