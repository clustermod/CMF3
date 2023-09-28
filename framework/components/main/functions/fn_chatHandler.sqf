#include "script_component.hpp"
/*
 * Author: Eric
 * Handles chat messages
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_main_fnc_chatHandler
 *
 * Public: No
 */

/* Own join message */
if (hasInterface) then {
    // @TODO replace spawn
    _this spawn {
        private _sideLUT = ["OPFOR", "BLUFOR", "INDEPENDENT", "CIVILIAN", "UNKNOWN", "ENEMY", "FRIENDLY", "LOGIC", "EMPTY", "AMBIENT"];

        waitUntil { !isNull player };

        private _roleDescription = "Unknown";
        if (roleDescription player != "") then {
            _roleDescription = ((roleDescription player) splitString "@") select 0;
        };

        private _disconUnits = missionNameSpace getVariable [QGVAR(disconUnits), createHashMap];
        private _disconUnit = _disconUnits get (getPlayerUID player);
        private _safestartEnabled = ( CONFIG_PARAM_4(SETTINGS,gameplay,safestart,enable) ) isEqualTo 1;

        if (!isNil "_disconUnit") then {
            if ( !_safestartEnabled || missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false] ) then {
                [format ["%1 Re-jipped", name player]] remoteExec ["systemChat", 0, false];
            } else {
                [format ["%1 Joined %2 in ""%3"" as a ""%4""", name player, _sideLUT select ((side player) call BIS_fnc_sideID), groupID group player, _roleDescription]] remoteExec ["systemChat", 0, false];
            };
        } else {
            [format ["%1 Joined %2 in ""%3"" as a ""%4""", name player, _sideLUT select ((side player) call BIS_fnc_sideID), groupID group player, _roleDescription]] remoteExec ["systemChat", 0, false];
        };

    };
};

/* Stop vanilla connected messages */
addMissionEventHandler ["HandleChatMessage", {
    params ["_channel", "_owner", "_from", "_text"];

    private _return = false;

    if (" CONNECTED" in toUpper _text) then {
        private _name = (_text splitString " ");
        _name deleteAt 0;
        _name deleteAt (count _name - 1);
        _name = _name joinString " ";
        private _message = format ["%1 in lobby selection", _name];
        _return = ["", _message];
    };

    _return
}];
