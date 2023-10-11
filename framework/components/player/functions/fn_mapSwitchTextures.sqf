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
 * [] call cmf_player_fnc_mapSwitchTextures
 *
 * Public: No
 */
SCRIPT(mapSwitchTextures);

/* Check if it's enabled */
if !(GVAR(setting_switchMapTextures)) exitWith {};

if ( isDedicated ) exitWith {};

[{ !isNull findDisplay 12 }, {
    /* Press the switch textures button */
    ctrlActivate ( ( findDisplay 12 ) displayCtrl 107 );
}] call CBA_fnc_waitUntilAndExecute;