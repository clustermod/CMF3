#include "script_component.hpp"
/*
 * Author: Eric
 * According to the Bohemia Wiki serverTime is only synced for the first 300 seconds. This function views to rectify that to sync server time for everyone.
 * The unified time can be accessed with: cmf_main_unifiedTime.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_main_fnc_unifiedTime
 *
 * Public: No
 */
SCRIPT(unifiedTime);

if (!isServer) exitWith { };

while { true } do {
    missionNamespace setVariable ["cmf_main_unifiedTime", time, true];
    sleep 0.5;
};
