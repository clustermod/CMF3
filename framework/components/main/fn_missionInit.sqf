#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes mission for CMF (executed postInit).
 *
 * Public: No
 */
SCRIPT(missionInit);

/* Wait until mission is initialized */
waitUntil{ time > 0 };

/* On safestart disable event */
[] spawn {
    waitUntil{ (missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false]) };
    [[], "events\onGameStart.sqf"] remoteExec ["execVM", 0, true];
};

/* Raise event */
[QGVAR(mission_initialized), []] call CBA_fnc_globalEvent;
