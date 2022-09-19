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
 * [] call cmf_init_fnc_preventProne
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
            if ((!isPlayer _x) && !(_x getVariable [QEGVAR(utility,preventProne_initialized), false])) then {
                [_x] call EFUNC(utility,preventProne);
                _x setVariable [QEGVAR(utility,preventProne_initialized), true];

                LOG_1("Enabled preventProne for %1", name _x);
            };
        } forEach allUnits;
        sleep 5;
    };
};
