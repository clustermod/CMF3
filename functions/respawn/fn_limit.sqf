#include "script_component.hpp"
/*
 * Author: Eric
 * Gives players a limited amount of lives which if all are spent will set player as a spectator.
 *
 * Arguments:
 * 0: Respawns <NUMBER>
 * 1: team <NUMBER> [Default: 0]
 *
 * Return Value:
 * None
 *
 * Example:
 * [5] call emf_limitedRespawns_fnc_init
 *
 * public: yes
*/
scriptName "functions\limitedRespawns\fn_init.sqf";
params["_respawns", ["_teamLimit", 0]];

// Check if params are set and is of correct type
if (isNil "_respawns") exitWith { ERROR_MSG("respawns cannot be nil"); false;};
if (typeName _respawns != "SCALAR") exitWith { ERROR_MSG_1('Object must be type "NUMBER", type %1 supplied', (typeName _respawns)); false;};

// If player is not in supplied team don't run
if (player getVariable [QEGVAR(utilities, setRole_team), 0] == _teamLimit) then {

	// Set the amount of allowed respawns
	player setVariable[QGVAR(playerRespawns), (_respawns + 1), true];

	// Create a event handler for player respawns
	player addEventHandler ["Respawn", {
		_respawns = player getVariable[QGVAR(playerRespawns), 1];

		// Check if player has spent all respawns
		if ((player getVariable[QGVAR(playerDeaths), 0]) == _respawns) then
		{
			if ((vehicle player) != player) then {
					player action ["getOut", (vehicle player)];
			};
			[player] joinSilent (createGroup west);
			[true, true, true] call ace_spectator_fnc_setSpectator;
		} else {
			private _pCount = player getVariable[QGVAR(playerDeaths), 0];
			private _pCount = _pCount + 1;
			// Decrement player respawns by 1
			player setVariable[QGVAR(playerDeaths), _pCount, true];
			[format["you have %1 respawns left", (_respawns - _pCount)], -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
		};
	}];
};

// Wait until zeus module is initialized
[] spawn {
	if (!hasInterface) exitwith {};
	waitUntil{!isnull (getAssignedCuratorLogic player)};

	// Get the respawns left for all players in mission and create 3D widget displaying the remaining respawns
	if (player in (call bis_fnc_listcuratorplayers)) then {
		addMissionEventHandler ["Draw3D", {
			if (isNull curatorCamera) exitWith {};
			{
				private _distance = position curatorCamera distance _x;
				if (_distance < 1200) then {
					private _respawnsLeft = (_x getVariable ["EMF_playerRespawns",1]) - (_x getVariable["EMF_playerDeaths", 0]);
					if (_respawnsLeft  < 1) then {
						private _iconPos = [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) - 0.5];
						drawIcon3D
						["", [1,0,0,0.7], _iconPos, 1, 2, 0, format["%1 Lives: %2", name _x, str _respawnsLeft], 0, 0.05, "PuristaMedium", "center"];
					} else {
						private _iconPos = [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) - 0.5];
						drawIcon3D
						["", [1,1,1,0.7], _iconPos, 1, 2, 0, format["%1 Lives: %2", name _x, str _respawnsLeft], 0, 0.03, "PuristaMedium", "center"];
					};
				};
			} forEach allPlayers;
		}];
	};
};
