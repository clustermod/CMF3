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

// Disable chatting in normal chats
{[_x, [false, false]] remoteExec ["enableChannel", 0, true]} forEach [0,1,2,4,5];
[3, [true, false]] remoteExec ["enableChannel", 0, true];

if (isServer) then
{
  // Create a new channel for zeus issues
	private _channelName = "Zeus Channel";
	EMF_BTC_zeusChn = radioChannelCreate [[1,0,0,0.8], _channelName, "%UNIT_NAME", allPlayers];


  // Create a new channel for tentative plan markers
	private _channelName = "Planning Channel";
	EMF_BTC_planChn = radioChannelCreate [[0,0,1,0.8], _channelName, "%UNIT_NAME", allPlayers];

  // Re-add channels upon respawn
  addMissionEventHandler ["EntityRespawned", {
    [EMF_BTC_planChn, [player]] remoteExec ["radioChannelAdd", (_this select 0)];
    [EMF_BTC_zeusChn, [player]] remoteExec ["radioChannelAdd", (_this select 0)];
    [EMF_BTC_zeusChn, [true, false]] remoteExec ["enableChannel", (_this select 0), true];
    [EMF_BTC_planChn, [true, false]] remoteExec ["enableChannel", (_this select 0), true];
    }];
};
