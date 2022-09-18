#include "script_component.hpp"
/*
 * Author: Eric
 * Starts a countdown which will .
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
    /* Get the configured delay time and start the countdown */
    private _delay = CONFIG_PARAM_3(SETTINGS,safestart,delay);
    [_delay, "Weapons are hot in: ", true] call EFUNC(utility,countDown);
    missionNamespace setVariable [QGVAR(gameplay,safestart_disable), true, true];
};
