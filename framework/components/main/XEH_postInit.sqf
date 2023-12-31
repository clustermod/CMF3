#include "script_component.hpp"

call FUNC(addonBlacklist);

[{ time > 0 }, {
    /* On safestart disable event */
    [{ (missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false]) }, {
        [[], "events\onGameStart.sqf"] remoteExec ["execVM", 0, true];
    }] call CBA_fnc_waitUntilAndExecute;

    /* Raise event */
    [QGVAR(mission_initialized), []] call CBA_fnc_globalEvent;
}] call CBA_fnc_waitUntilAndExecute;

/* Show changelog */
call FUNC(changelog);

/* Player killed event */
player addEventHandler ["Killed", {
    params ["_unit"];

    /* Set player to fully loaded (first death is automatic so player's can choose their spawn location) */
    player setVariable [QGVAR(player_loaded), true];

    /* Call event script */
    _this execVM "events\onPlayerKilled.sqf"
}];

/* Player respawn event */
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];

    /* Call event script */
    _this execVM "events\onPlayerRespawn.sqf"
}];

/* Store CMF Version Number in variable */
GVAR(version) = VERSION_STR;