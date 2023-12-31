#include "script_component.hpp"
/*
 * Author: Eric
 * Restrict the zeus slot to only allow players defined in the steamID array.
 *
 * Arguments:
 * 0: allowedUIDs <ARRAY OF STRINGS>
 *
 * Return Value:
 * None
 *
 * Example:
 * [["76561198065818848", "76064198065872865"]] call cmf_utility_fnc_restrictZeus
 *
 * Public: Yes
*/
SCRIPT(restrictZeus);
// @TODO: Move to common
params ["_allowedUIDs"];

if (isNil "_allowedUIDs") exitWith {
    WARNING("No Zeus UID supplied")
};

/* If player has zeus assigned and does not have a UID mentioned in _allowedUIDs and is not admin, kick him back to lobby */
_allowedUIDs spawn {
    waitUntil {!alive Player};
    waitUntil {alive Player};
    waitUntil {!isNull (getAssignedCuratorLogic player) || 10 < time};
    if (!isNull (getAssignedCuratorLogic player) && !((getPlayerUID player) in _this)) then {
        [QGVAR(notZeus), false, 0.01, false] call BIS_fnc_endMission;

        /* Raise event */
        [QGVAR(restrictZeus_onKick), [player]] call CBA_fnc_globalEvent;
    };
};
