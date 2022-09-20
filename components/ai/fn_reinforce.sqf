#include "script_component.hpp"
/*
 * Author: Eric
 * Make ai reinforce groups in contact
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [300, 15] call cmf_ai_fnc_reinforce
 *
 * public: Yes
*/
SCRIPT(reinforce);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,ai,reinforce) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* Enable LAMBS reinforcements on unit */
while { !(missionNamespace getVariable [QGVAR(reinforce_disable), false]) } do {
    {
        if !(_x getVariable [QGVAR(reinforce_initialized), false]) then {
            _x setVariable ["lambs_danger_enableGroupReinforce", true, true];
            _x setVariable [QGVAR(reinforce_initialized), true, true];
        };
        sleep 0.03;
    } forEach allGroups;
    sleep 1;
};
