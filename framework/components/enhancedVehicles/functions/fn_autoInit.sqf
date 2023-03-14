#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes enhanced vehicles if autoinit is enabled
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_enhancedVehicles_fnc_autoInit
 *
 * Public: No
 */
SCRIPT(autoInit);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,enhancedVehicles,enable) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* Initialize EnhancedVehicles on all mission vehicles */
_this spawn {
    while { !(missionNamespace getVariable [QGVAR(disable), false]) } do {
        {
            /* Check if vehicle is already initialized */
            if !(_x getVariable [QGVAR(initialized), false]) then {
                [[_x], FUNC(init)] remoteExec ["call", 0, true];
                _x setVariable [QGVAR(initialized), true, true];
            };
        } forEach vehicles;
        sleep 1;
    };
};
