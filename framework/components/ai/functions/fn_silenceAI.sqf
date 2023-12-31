#include "script_component.hpp"
/*
 * Author: Eric
 * Silences friendly AI
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_ai_fnc_silenceAI
 *
 * Public: Yes
 */

/* Disable AI contact reports */
enableSentences false;

["CAManBase", "init", {
    params ["_unit"];

    if ([side player, side _unit] call BIS_fnc_sideIsFriendly) then {
        _unit setVariable ["BIS_noCoreConversations", true, false];
        while {!conversationDisabled _unit} do {_unit disableConversation true};
    }
}] call CBA_fnc_addClassEventHandler;
