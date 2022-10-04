#include "script_component.hpp"
/*
 * Author: KillzoneKid, Eric
 * Keeps a consistent size on map markers regrardless of player map zoom.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_player_fnc_resizeMapMarkers
 *
 * Public: Yes
*/
SCRIPT(resizeMapMarkers);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,player,consistentMarkers) ) isEqualTo 1;
if !(_enabled) exitWith {};

if (!hasInterface) exitWith {};

[] spawn {
    waitUntil {!isNull findDisplay 12};

    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if (visibleMap) then {
            private _scale = 0.05 / ctrlMapScale (_this select 0);
            {
                private _m = "cmf_init_resizeMapMarkers_markerSize_" + _x;
                if (markerShape _x == "ICON" && markerType _x != "respawn_inf") then {
                    if (isNil {missionNamespace getVariable _m}) then {
                        missionNamespace setVariable [_m, markerSize _x];
                    };

                    private _worldModifier = worldSize / 12800;
                    private _sX = ((((missionNamespace getVariable _m) select 0) * _scale) / _worldModifier) max 0.35;
                    private _sY = ((((missionNamespace getVariable _m) select 1) * _scale) / _worldModifier) max 0.35;
                    _x setMarkerSizeLocal [_sX, _sY];
                } else {
                    if (markerShape _x == "ICON" && markerType _x != "respawn_inf") then {
                        if (isNil {missionNamespace getVariable _m}) then {
                            missionNamespace setVariable [_m, markerSize _x];
                        };

                        private _size = missionNamespace getVariable [_m, [1,1]];
                        _x setMarkerSizeLocal _size;
                    };
                };
            } forEach allMapMarkers;
        };
    }];
};
