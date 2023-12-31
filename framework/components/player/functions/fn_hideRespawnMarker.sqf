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
 * [] call cmf_player_fnc_hideRespawnMarker
 *
 * Public: No
 */
SCRIPT(hideRespawnMarker);

[{ !isNull findDisplay 12 }, {
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if !(GVAR(setting_hideRespawnMarkers)) exitWith {};
        
        if (visibleMap) then {
            {
                if (markerShape _x == "ICON" && markerType _x == "respawn_inf") then {
                    _x setMarkerAlphaLocal 0;
                };
            } forEach allMapMarkers;
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;