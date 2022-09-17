#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes mission for EMF (executed postInit).
 *
 * Arguments:
 * None
 *
 * Public: No
 */
SCRIPT(missionInit);

/* On safestart disable event */
[] spawn {
    waitUntil{ (missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false]) };
    [[], "events\onGameStart.sqf"] remoteExec ["execVM", 0, true];
};
