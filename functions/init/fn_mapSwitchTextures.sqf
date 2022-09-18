#include "script_component.hpp"
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
 * [] call cmf_init_fnc_mapSwitchTextures
 *
 * Public: No
 */
SCRIPT(mapSwitchTextures);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,switchMapTextures) ) isEqualTo 1;
if !(_enabled) exitWith {};

if ( isDedicated ) exitWith {};

[] spawn {
	/* waitUntil the map exists */
	waitUntil { !isNull findDisplay 12 };

	/* Press the switch textures button */
	ctrlActivate ( ( findDisplay 12 ) displayCtrl 107 );
};
