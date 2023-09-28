#include "script_component.hpp"
/*
 * Author: Eric
 * Gives players a limited amount of lives which if all are spent will set player as a spectator.
 *
 * Arguments:
 * 0: Respawns <NUMBER>
 * 1: condition <CODE> [Default: {true}]
 *
 * Return Value:
 * None
 *
 * Example:
 * [5] call cmf_respawn_fnc_limit
 *
 * public: yes
*/
SCRIPT(limit);

params ["_respawns", ["_condition", { true }]];

/* Check if params are set and is of correct type */
if (isNil "_respawns") exitWith { ERROR_MSG("respawns cannot be nil"); false };

if (call _condition) then {
	/* Set the amount of allowed respawns */
	player setVariable[QGVAR(respawns), _respawns, true];

	/* Check if player is out of lives on respawn */
	player addEventHandler ["Respawn", {
		_respawns = player getVariable[QGVAR(respawns), 1];

		/* Don't decrement a player's life during safestart */
		private _safestartEnabled = ( CONFIG_PARAM_4(SETTINGS,gameplay,safestart,enable) ) isEqualTo 1;
		if ( _safestartEnabled && !(missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false]) ) exitWith {};

		if ((player getVariable[QGVAR(deaths), 0]) == _respawns) then {
			if ((vehicle player) != player) then {
				player action ["getOut", (vehicle player)];
			};

			/* Put player in a new group and initialize spectator for him */
			[player] joinSilent (createGroup west);
			[true, true, true] call ace_spectator_fnc_setSpectator;
		} else {
			/* Decrement the respawn counter */
			private _pCount = player getVariable[QGVAR(deaths), 0];
			private _pCount = _pCount + 1;
			player setVariable[QGVAR(deaths), _pCount, true];
		};
	}];
};

if (!hasInterface) exitwith {};

/* Get the respawns left for all players in mission and create 3D widget displaying the remaining respawns for zeuses */
[{!isnull (getAssignedCuratorLogic player)}, {
	if (player in (call bis_fnc_listcuratorplayers)) then {
		addMissionEventHandler ["Draw3D", {
			if (isNull curatorCamera) exitWith {};
			{
				private _distance = position curatorCamera distance _x;
				if (_distance < 1200) then {
					private _respawnsLeft = (_x getVariable [QGVAR(respawns),1]) - (_x getVariable[QGVAR(deaths), 0]);
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
}] call CBA_fnc_waitUntilAndExecute;
