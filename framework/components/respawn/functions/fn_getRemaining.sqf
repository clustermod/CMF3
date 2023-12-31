#include "script_component.hpp"
/*
 * Author: Eric
 * Gets the remaining respawns for a unit.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Respawns <NUMBER>
 *
 * Example:
 * [player] call cmf_respawn_fnc_getRemaining
 *
 * public: Yes
*/
SCRIPT(getRemaining);
params["_obj"];

/* Set the new amount of respawns and reset death counter */
_obj getVariable[QGVAR(respawns), -1] - _obj getVariable[QGVAR(deaths), 0];
