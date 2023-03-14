#include "script_component.hpp"
/*
 * Author: Eric
 * Get the respawn limit for a unit mid-mission.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Respawns <NUMBER>
 *
 * Example:
 * [player] call cmf_respawn_fnc_getLimit
 *
 * public: Yes
*/
SCRIPT(getLimit);
params["_obj", "_respawns", ["_silent", false]];

_obj getVariable[QGVAR(respawns), -1];
