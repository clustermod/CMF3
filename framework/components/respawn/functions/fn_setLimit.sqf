#include "script_component.hpp"
/*
 * Author: Eric
 * Set the respawn limit for a unit mid-mission.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Respawns <NUMBER>
 * 2: Hide hint <BOOL>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [this, 5, true] call cmf_respawn_fnc_setLimit
 *
 * public: Yes
*/
SCRIPT(setLimit);
params["_obj", "_respawns", ["_silent", false]];

/* Set the new amount of respawns and reset death counter */
_obj setVariable[QGVAR(respawns), _respawns, true];
_obj setVariable[QGVAR(deaths), 0, true];

if (!local _obj) exitWith {};

/* Close spectator if players is spectating */
if (_obj in (call ace_spectator_fnc_players)) then {
    [false] call ace_spectator_fnc_setSpectator;
};

/* Show a hint for the affected unit */
if (!_silent) then {
  [FORMAT_1(LSTRING(respawns_set), _respawns)] remoteExec ["hint", _obj];
};

/* Raise event */
[QGVAR(onSetLimit), [_respawns, _silent], _obj] call CBA_fnc_targetEvent;
