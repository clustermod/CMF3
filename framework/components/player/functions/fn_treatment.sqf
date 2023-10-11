#include "script_component.hpp"
/*
 * Author: Eric
 * Shows a hint when the player is being treated
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [] call cmf_player_fnc_treatment
 * 
 * Public: No
 */

["ace_treatmentStarted", {
    params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

    /* Show a hint when player is being treated */
    [_this, {
        params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

        if (_caller isEqualTo _target) exitWith {};
        if !(_target isEqualTo player) exitWith {};

        private _text = "<t size='0.5' align='center'>Somebody is treating you</t>";
        if !(player getVariable ["ACE_isUnconscious", false]) then {
            _text = format ["<t size='0.5' align='center'>%1 is giving you a %2</t>", name _caller, [(configFile >> "CfgVehicles" >> _usedItem + "Item")] call BIS_fnc_displayName];
        };

        private _handler = [_text, [safeZoneX - 0.35, safeZoneW - safeZoneX], safezoneH - 0.7, 9999, 1, 0, ([QGVAR(treatment_notification)] call BIS_fnc_rscLayer)] spawn BIS_fnc_dynamicText;
        _target setVariable [QGVAR(treatment_notifHandler), _handler, true];
    }] remoteExec ["call", _target];
}] call CBA_fnc_addEventHandler;

["ace_treatmentSucceded", {
    params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

    /* Hide hint if it is up */
    [_this, {
        params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

        if (_caller isEqualTo _target) exitWith {};
        if !(_target isEqualTo player) exitWith {};

        private _handler = _target getVariable [QGVAR(treatment_notifHandler), nil];
        if (!isNil "_handler") then {
            terminate _handler;
            ([QGVAR(treatment_notification)] call BIS_fnc_rscLayer) cutText ["", "plain"];
            _target setVariable [QGVAR(treatment_notifHandler), nil, true];
        };
    }] remoteExec ["call", _target];

}] call CBA_fnc_addEventHandler;

["ace_treatmentFailed", {
    params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

    /* Hide hint if it is up */
    [_this, {
        params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem"];

        if (_caller isEqualTo _target) exitWith {};
        if !(_target isEqualTo player) exitWith {};

        private _handler = _target getVariable [QGVAR(treatment_notifHandler), nil];
        if (!isNil "_handler") then {
            terminate _handler;
            ([QGVAR(treatment_notification)] call BIS_fnc_rscLayer) cutText ["", "plain"];
            _target setVariable [QGVAR(treatment_notifHandler), nil, true];
        };
    }] remoteExec ["call", _target];
}] call CBA_fnc_addEventHandler;