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
    /* Get configured delay */
    private _delay = (CONFIG_PARAM_4(SETTINGS,gameplay,safestart,delay));
    if (isnil "_delay") exitWith {};

    missionNameSpace setVariable [QEGVAR(gameplay,safestart_Countdown), true, true];

    [[], {
        [_delay, "Weapons are live in: ", true] call EFUNC(utility,countDown);
        missionNamespace setVariable [QEGVAR(gameplay,safestart_disable), true, true];
    }] remoteExec ["spawn", 0];
};
