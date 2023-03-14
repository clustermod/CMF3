#include "script_component.hpp"
/*
 * Author: Eric
 * Ends a local player's loading screen.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_utility_fnc_endLoadingScreen
 *
 * Public: Yes
 */
SCRIPT(endLoadingScreen);

[] spawn {
    for "_x" from 1 to 4 do {
        endLoadingScreen;
        sleep 3;
    };
};
