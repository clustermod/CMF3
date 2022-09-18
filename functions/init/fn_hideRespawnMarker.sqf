#include "script_component.hpp"
/*
 * Author: Eric
 * Hides the respawn markers
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_init_fnc_hideRespawnMarker
 *
 * Public: No
 */
SCRIPT(hideRespawnMarker);

/* Check if it is enabled */
private _enabled = ([["SETTINGS", "init", "hideRespawnMarkers"]] call EFUNC(common,getConfigParam)) isEqualTo 1;
if !(_enabled) exitWith {};

[] spawn {
    waitUntil {!isNull findDisplay 12};

    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if (visibleMap) then {
            {
                if (markerShape _x == "ICON" && markerType _x == "respawn_inf") then {
                    _x setMarkerAlphaLocal 0;
                };
            } forEach allMapMarkers;
        };
    }];
};
