#include "script_component.hpp"
/*
 * Author: Eric
 * Displays countdown
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * PerFrameHandler Handle <NUMBER>
 * 
 * Example:
 * call cmf_respawn_fnc_countdown
 * 
 * Public: No
 */

GVAR(countdownHandler) = [{
    disableSerialization;

    private _ctrl = uiNamespace getVariable [QGVAR(ctrlCounter), controlNull];
    if (GVAR(respawnTimer) <= 0) exitWith {
        GVAR(respawnState) = true;

        _ctrl ctrlShow false;
        _ctrl ctrlCommit 0;

        [(_this select 1)] call CBA_fnc_removePerFrameHandler;
        GVAR(countdownHandler) = -1;
    };

    private _minutes = floor(GVAR(respawnTimer) / 60);
    private _seconds = GVAR(respawnTimer) % 60;

    private _minutesString = format ["%1 %2", _minutes, ["minute and ", "minutes and "] select (_minutes > 1)];
    private _secondsString = format ["%1 %2", _seconds, ["second", "seconds"] select (_seconds > 1)];

    _ctrl ctrlShow true;
    _ctrl ctrlSetText format ["Wait %1%2 seconds to respawn", _minutesString, _secondsString];
    _ctrl ctrlCommit 0;

    GVAR(respawnTimer) = 0 max (GVAR(respawnTimer) - 1);
}, 1] call CBA_fnc_addPerFrameHandler;

GVAR(countdownHandler);