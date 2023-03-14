#include "script_component.hpp"
/*
 * Author: Eric
 * Starts a countdown which will disable safestart once it reaches 0.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_menu_fnc_delayedSafestartAction
 *
 * Public: No
 */
SCRIPT(delayedSafestartAction);

/* Start the game after x seconds */
[] spawn {
    missionNameSpace setVariable [QEGVAR(gameplay,safestart_Countdown), true, true];

    [[], {
        [5, "Weapons are live in: ", true] call EFUNC(utility,countDown);
        missionNamespace setVariable [QEGVAR(gameplay,safestart_disable), true, true];
    }] remoteExec ["spawn", 0];
};
