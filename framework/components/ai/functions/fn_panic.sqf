#include "script_component.hpp"
/*
 * Author: Eric
 * When AI enteres panic mode they will either attempt to retreat or surrender
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_ai_fnc_panic
 * 
 * Public: No
 */

["lambs_danger_OnPanic", {
    params ["_unit", "_group"];

     LOG_1("%1 Entered Panic Mode", _unit);
     [_unit] call lambs_wp_fnc_taskReset;

    if (isPlayer _unit) exitWith {};
    if (_unit getVariable [QGVAR(disablePanic), false]) exitWith {};

    private _groupUnits = units _group;

        /* 5% chance of surrendering */ 
    if (SETTING(panicSurrenderChance) > random 1) exitWith {
        LOG_1("%1 is surrendering", _unit);
        _unit playAction "Surrender";
    };

    /* 50% Chance of group retreating when paniced */
    if (SETTING(panicRetreatChance) > random 1) then {
        LOG_1("%1 is Retreating", _unit);
        private _attackDir = _unit getDir (getAttackTarget _unit);
        private _retreatDir = (_attackDir + 180) % 360;
        private _retreatPos = _unit getPos [_retreatDir, random 500];

        /* Reset AI after retreat is successful */
        [_unit, _retreatPos, true] spawn lambs_wp_fnc_taskAssault;
        [{ (_this select 0) distance2D (_this select 1) < 30 }, {
            [(_this select 0)] call lambs_wp_fnc_taskReset;
        }, [_unit, _retreatPos]] call CBA_fnc_waitUntilAndExecute;
    };
}] call CBA_fnc_addEventHandler;