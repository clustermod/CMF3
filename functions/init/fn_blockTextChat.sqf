#include "script_component.hpp"
/*
 * Author: Eric
 * Removes unnecessary channels and adds a planning channel and a zeus channel.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_blockTextChat
 *
 * public: Yes
*/
scriptName "functions\init\blockTextChat.sqf";

// Get config setting
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,blockTextChat) ) isEqualTo 1;
if !(_enabled) exitWith {};

// Disable chatting in normal chats
{[_x, [false, false]] remoteExec ["enableChannel", 0, true]} forEach [0,1,2,4,5];
[3, [true, false]] remoteExec ["enableChannel", 0, true];

if (isServer) then {
	// Create a new channel for zeus issues
	private _channelName = "Zeus Channel";
	GVAR(BTC_zeusChn) = radioChannelCreate [[1,0,0,0.8], _channelName, "%UNIT_NAME", allPlayers];


	// Create a new channel for tentative plan markers
	private _channelName = "Planning Channel";
	GVAR(BTC_planChn) = radioChannelCreate [[0,0,1,0.8], _channelName, "%UNIT_NAME", allPlayers];

	// Re-add channels upon respawn
	addMissionEventHandler ["EntityRespawned", {
		[GVAR(BTC_planChn), [player]] remoteExec ["radioChannelAdd", (_this select 0)];
		[GVAR(BTC_zeusChn), [player]] remoteExec ["radioChannelAdd", (_this select 0)];
		[GVAR(BTC_zeusChn), [true, false]] remoteExec ["enableChannel", (_this select 0), true];
		[GVAR(BTC_planChn), [true, false]] remoteExec ["enableChannel", (_this select 0), true];
	}];
};
