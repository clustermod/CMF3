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

/* Player respawn event */
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];

    /* Call event script */
    _this execVM "events\onPlayerRespawn.sqf"
}];