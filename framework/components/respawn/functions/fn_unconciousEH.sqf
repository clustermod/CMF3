#include "script_component.hpp"
/*
 * Author: Eric
 * On unconcious state change
 * 
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: State <BOOLEAN>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_respawn_fnc_unconciousEH
 * 
 * Public: No
 */

params ["_unit", "_state"];

if !(_unit isEqualTo player) exitWith {};

if (_state) then {
    if (!isNil GVAR(countdownHandler)) exitWith {};
    GVAR(respawnTimer) = GVAR(setting_unconciousTimer);
    call FUNC(countdown);
} else {
    [GVAR(countdownHandler)] call CBA_fnc_removePerFrameHandler;
    GVAR(respawnState) = false;
    GVAR(countdownHandler) = scriptNull;
};