#include "script_component.hpp"
/*
 * Author: Eric
 * Ends a players loading screen.
 *
 * Arguments:
 * 0: player/id <OBJECT>/<NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call emf_utility_fnc_endLoadingScreen
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
