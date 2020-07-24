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
 * None
 *
 * public: No
*/

if ( isDedicated ) exitWith {};

[] spawn {
	// Wait for game map to become available
	waitUntil { !isNull findDisplay 12 };

	// Programatically activate the texture button
	ctrlActivate ( ( findDisplay 12 ) displayCtrl 107 );
};
