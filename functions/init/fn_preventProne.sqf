#include "script_component.hpp"
/*
 * Author: Eric
 * Prevents AI going prone
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_blockProne
 *
 * Public: No
 */

// Get config setting
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,preventProne) ) isEqualTo 1;
if !(_enabled) exitWith {};

{
    if (!isPlayer _x) then {
        // Prevent AI units from going prone
        [_x] call emf_utilities_fnc_preventProne;
        _x setVariable [QGVAR(preventProne), true];
    };
} forEach allUnits;

[] spawn {
    while { !(missionNamespace getVariable [QGVAR(preventProne_disable), false]) } do {
        {
            if ((!isPlayer _x) && (_x getVariable [QGVAR(preventProne), false])) then {
                [_x] call emf_utilities_fnc_preventProne;
                _x setVariable [QGVAR(preventProne), true];
            };
        } forEach allUnits;
        sleep 15;
    };
};
