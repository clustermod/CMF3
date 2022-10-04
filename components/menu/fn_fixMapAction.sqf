#include "script_component.hpp"
/*
 * Author: Eric
 * Fixes the RR immersive maps bug where the map gets stuck to the playerunit.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_menu_fnc_fixMapAction
 *
 * Public: No
 */
SCRIPT(fixMapAction);

/* Fix RR_maps bug where the map is stuck */
false call RR_mapStuff_fnc_mapEH;
{detach _x; deleteVehicle _x} forEach attachedObjects player;
