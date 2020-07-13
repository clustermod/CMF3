if (!isServer) exitWith {};
[] spawn {
	missionNamespace setVariable ["EMF_missionSafeStart", false, true];


	private "_safestart";
	_safestart = ["_safestart", "Start Game", "", {missionNamespace setVariable ["EMF_missionSafeStart", true, true];}, {!(missionNamespace getVariable ["EMF_missionSafeStart", false])}] call ace_interact_menu_fnc_createAction;
	[["ACE_ZeusActions"], _safestart] call ace_interact_menu_fnc_addActionToZeus;

	private _eventHandlerId = addMissionEventHandler ["EntityRespawned", {
	 params ["_entity", "_corpse"];

	 if (!isPlayer _entity) exitWith {};
	 [_corpse] remoteExec ["deleteVehicle", 0, true];
	 [_entity, false] remoteExec ["allowDamage", 0, true];
	 [_entity, ["", { player sideChat "Weapons are cold, game hasn't started"; }, "", 0, false, true, "DefaultAction"]] remoteExec ["addAction", 0, true];
	 [_entity, ["", { player sideChat "Weapons are cold, game hasn't started"; }, "", 0, false, true, "throw"]] remoteExec ["addAction", 0, true];
	}];

	/*private _throwEventHandler = ["ace_throwableThrown", {
		if (missionNamespace getVariable ["EMF_missionSafeStart", false]) then {
		    ["ace_throwableThrown", _thisScript] remoteExecCall ["CBA_fnc_removeEventHandler", 0];
		};
		[player, "Weapons are cold, game hasn't started"] remoteExec ["sideChat", (_this select 0)];
		(_this select 1) setPos [0,0,0];
		deleteVehicle (_this select 1);
	}] remoteExecCall ["CBA_fnc_addEventHandler", 0, true];*/

	waitUntil{(missionNamespace getVariable ["EMF_missionSafeStart", false])};

	[60, "Weapons are hot in: ", true] call EMF_fnc_countDown;
	["Weapons are hot, game has started"] remoteExec ["hintSilent", 0];
	removeMissionEventHandler ["EntityRespawned", _eventHandlerId];
	{[_x] remoteExec ["removeAllActions", 0, true];} forEach allPlayers;
	{[_x, true] remoteExec ["allowDamage", 0, true];} forEach allPlayers;
};
