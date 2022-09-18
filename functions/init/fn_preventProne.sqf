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
 * [] call cmf_init_fnc_blockProne
 *
 * Public: No
 */
SCRIPT(preventProne);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,preventProne) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* preventProne on AI units */
[] spawn {
    while { !(missionNamespace getVariable [QEGVAR(utility,preventProne_disable), false]) } do {
        {
            if ((!isPlayer _x) && (_x getVariable [QEGVAR(utility,preventProne_initialized), false])) then {
                [_x] call EFUNC(utility,preventProne_initialized);
                _x setVariable [QEGVAR(utility,preventProne_initialized), true];
            };
        } forEach allUnits;
        sleep 15;
    };
};
