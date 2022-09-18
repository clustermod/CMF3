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
 * call emf_init_fnc_safeStart
 *
 * Public: Yes
*/
SCRIPT(resizeMapMarkers);
disableSerialization;

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,consistentMarkers) ) isEqualTo 1;
if !(_enabled) exitWith {};

if (!hasInterface) exitWith {};

[] spawn {
    waitUntil {!isNull findDisplay 12};
    (findDisplay 12) ctrlCreate [QGVAR(resizeMapMarkers_toggleResize), -1];
    (findDisplay 12) ctrlCreate [QGVAR(resizeMapMarkers_markerSize), -1];
    (findDisplay 12) ctrlCreate [QGVAR(resizeMapMarkers_markerSizeLabel), -1];

    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if (visibleMap && (profileNamespace getVariable [QGVAR(resizeMapMarkers_enabled), true])) then {
            private _scale = (profileNamespace getVariable [QGVAR(resizeMapMarkers_size), 0.2]) / ctrlMapScale (_this select 0);
            {
                private _m = "#markerSize_" + _x;
                if (markerShape _x == "ICON" && markerType _x != "respawn_inf") then {
                    if (isNil {missionNamespace getVariable _m}) then {
                        missionNamespace setVariable [_m, markerSize _x];
                    };
                    _x setMarkerSizeLocal [
                        ((missionNamespace getVariable _m) select 0) * _scale,
                        ((missionNamespace getVariable _m) select 1) * _scale
                    ];
                };
            } forEach allMapMarkers;
        } else {
            if !(profileNamespace getVariable [QGVAR(resizeMapMarkers_enabled), true]) then {
                {
                    if (markerShape _x == "ICON" && markerType _x != "respawn_inf") then {
                        _x setMarkerSizeLocal [1,1];
                    };
                } forEach allMapMarkers;
            };
        };
    }];
};
