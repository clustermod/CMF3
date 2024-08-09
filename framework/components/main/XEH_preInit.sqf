#include "script_component.hpp"

/* Player killed event */
player addEventHandler ["Killed", {
    params ["_unit"];

    /* Set player to fully loaded (first death is automatic so player's can choose their spawn location) */
    player setVariable [QGVAR(player_loaded), true];

    /* Call event script */
    _this execVM "events\onPlayerKilled.sqf"
}];

/* Store CMF Version Number in variable */
GVAR(version) = VERSION_STR;