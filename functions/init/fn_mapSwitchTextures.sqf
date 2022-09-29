/*
 * Author: Eric
 * Disables map textures by default.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_mapSwitchTextures
 *
 * public: No
*/
scriptName "functions\init\fn_mapSwitchTextures.sqf";

if ( isDedicated ) exitWith {};

[] spawn {
	// Wait for game map to become available
	waitUntil { !isNull findDisplay 12 };

	// Programatically activate the texture button
	ctrlActivate ( ( findDisplay 12 ) displayCtrl 107 );
};
