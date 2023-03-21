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
	if ([side player, side _this] call BIS_fnc_sideIsFriendly) then {
		_this setVariable ["BIS_noCoreConversations", true, false];
		while {!conversationDisabled _this} do {_this disableConversation true};
	}
}] call CBA_fnc_addClassEventHandler;
