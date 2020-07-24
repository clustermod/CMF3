/*
 * Author: Eric
 * disables shooting and throwing grenades upon mission start until zeus starts mission.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * call EMF_fnc_safeStart
 *
 * public: Yes
*/

if (!isServer) exitWith {
	private _safestart = ["_safestart", "Start Game", "", {[] spawn {[60, "Weapons are hot in: ", true] call EMF_fnc_countDown; missionNamespace setVariable ["EMF_missionSafeStart", true, true];}}, {!(missionNamespace getVariable ["EMF_missionSafeStart", false])}] call ace_interact_menu_fnc_createAction;
	[["ACE_ZeusActions"], _safestart] call ace_interact_menu_fnc_addActionToZeus;
};

[] spawn {
	missionNamespace setVariable ["EMF_missionSafeStart", false, true];

	// Create a zeus action to start the game

	// create a MissionEventHandler to detect respawns and apply restriction to that entity
	private _eventHandlerId = addMissionEventHandler ["EntityRespawned", {

	 if (!isPlayer (_this select 0)) exitWith {};
	 [(_this select 1)] remoteExec ["deleteVehicle", 0, true];
	 [(_this select 0), false] remoteExec ["allowDamage", 0, true];
	 [(_this select 0), ["", { player sideChat "Weapons are cold, game hasn't started"; }, "", 0, false, true, "DefaultAction", "(!(missionNamespace getVariable ['EMF_missionSafeStart', false]) && !((animationState player) in ['acinpknlmstpsraswrfldnon', 'acinpknlmwlksraswrfldb']))"]] remoteExec ["addAction", 0, true];

	 // Create a event handler for vanilla thrown grenades
	 (_this select 0) addEventHandler ["Fired", {
		 private _projectile = nearestObject [(_this select 0), (_this select 4)];
 		 if ((configname (inheritsFrom (configFile >> "cfgWeapons" >> "throw" >>(_this select 2) )) isEqualTo "ThrowMuzzle") && !(missionNamespace getVariable ["EMF_missionSafeStart", false])) then {
			[_projectile, [0,0,0]] remoteExec ["setPos", 0, true];
			[_projectile] remoteExec ["deleteVehicle", 0, true];
 			[(_this select 0), "Weapons are cold, game hasn't started"] remoteExec ["sideChat", (_this select 0)];
		};
 		}];

	}];

	// Create a event handler for ace thrown grenades
	["ace_throwableThrown", {
		if (!(missionNamespace getVariable ["EMF_missionSafeStart", false])) then {
			[player, "Weapons are cold, game hasn't started"] remoteExec ["sideChat", (_this select 0)];

			// teleport the grenade to 0,0,0 and delete it
			(_this select 1) setPos [0,0,0];
			deleteVehicle (_this select 1);
		};
	}] remoteExecCall ["CBA_fnc_addEventHandler", 0, true];


	// Wait until zeus starts mission
	waitUntil{(missionNamespace getVariable ["EMF_missionSafeStart", false])};
	["Weapons are hot, game has started"] remoteExec ["hintSilent", 0];

	removeMissionEventHandler ["EntityRespawned", _eventHandlerId];
	{[_x, true] remoteExec ["allowDamage", 0, true];} forEach allPlayers;
};
true;
