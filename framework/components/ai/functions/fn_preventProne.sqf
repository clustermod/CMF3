#include "script_component.hpp"
/*
 * Author: Eric
 * Prevents AI 'from going prone
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_ai_fnc_preventProne
 *
 * Public: No
 */
SCRIPT(preventProne);

/* preventProne on AI units */
["CAManBase", "init", {
    params ["_unit"];

    if (!SETTING(preventProne)) exitWith {};

    if (missionNamespace getVariable [QEGVAR(utility,preventProne_disable), false]) exitWith {};
    if (_unit getVariable [QEGVAR(utility,preventProne_disable), false]) exitWith {};
    if (isPlayer _unit) exitWith {};

    _unit addEventHandler ["AnimChanged", {
        private _proneAnimArray = ["AmovPercMstpSlowWrflDnon_AmovPpneMstpSrasWrflDnon", "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon", "amovppnemstpsraswrfldnon", "AmovPknlMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon"];
        params ["_unit", "_anim"];

        /* Check if animation is a state change animation to prone */
        if ((_anim in _proneAnimArray) || (unitPos _unit isEqualTo "down")) then {
            _unit setunitPos "middle"
        };
    }];
    LOG_1("Enabled preventProne for %1", _unit);
}, true, [], true] call CBA_fnc_addClassEventHandler;