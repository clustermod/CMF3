#include "script_component.hpp"
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
 * call cmf_gameplay_fnc_safeStart
 *
 * public: Yes
*/
SCRIPT(fn_safestart);
if (!isServer) exitWith {};

LOG("Enabled safestart");

_this spawn {
	missionNamespace setVariable [QGVAR(safestart_disable), false, true];

	/* Raise event */
	[QGVAR(safestart_onEnable), []] call CBA_fnc_globalEvent;

	/* Add events for respawned  */
	addMissionEventHandler ["EntityRespawned", {
		params ["_unit"];

		/* If the unit is not a player exit */
		if (!isPlayer _unit) exitWith {};

		/* If safestart has been disabled delete this eventHandler */
		if (missionNamespace getVariable [QGVAR(safestart_disable), false]) exitWith {
			removeMissionEventHandler ["EntityRespawned", _thisEventHandler];
			_unit allowDamage true;
		};

		/* Execute code where unit is local */
		[_this, {
			params ["_newEntity", "_oldEntity"];

			/* Delete old body */
			deleteVehicle _oldEntity;

			/* Make unit invincible */
			_newEntity allowDamage false;

			/* Add action to block shooting */
			private _action = _newEntity addAction ["", {
				params ["_target", "_caller", "_actionId"];

				/* Remove action if game has started */
				if ( missionNamespace getVariable [QGVAR(safestart_disable), false] ) exitWith { _target removeAction _actionId };

				/* show message in sidechat */
				_caller sideChat "Weapons are cold, game hasn't started";
			}, "", 0, false, true, "DefaultAction", "!((animationState player) in ['acinpknlmstpsraswrfldnon', 'acinpknlmwlksraswrfldb']) && !(missionNameSpace getVariable ['"+QGVAR(safestart_disable)+"', false])"];

			/* Add event to block throwing grenades the vanilla way */
			["ace_firedPlayer", {
				params ["_unit", "", "_muzzle", "", "", "", "_projectile"];

				/* Remove action if game has started */
				if (missionNamespace getVariable [QGVAR(safestart_disable), false]) exitWith {
					["ace_firedPlayer", _thisId] call CBA_fnc_removeEventHandler;
					player removeAction _thisArgs;
				};

					/* If the projectile is a grenade delete it */
					if ((configname (inheritsFrom (configFile >> "cfgWeapons" >> "throw" >> _muzzle)) isEqualTo "ThrowMuzzle")) then {
						_projectile setPos [0,0,0];
						deleteVehicle _projectile;
						_unit sideChat "Weapons are cold, game hasn't started";
					};
			}, _action] call CBA_fnc_addEventHandlerArgs;

		}] remoteExec ["call", (_this select 0)];
	}];


	/* When the game is started show a hint and enable damage for all units */
	waitUntil{ missionNamespace getVariable [QGVAR(safestart_disable), false] };
	["Weapons are hot, game has started"] remoteExec ["hintSilent", 0];

	{ [_x, true] remoteExec ["allowDamage", 0, true] } forEach allPlayers;

	/* Raise event */
	[QGVAR(safestart_onDisable), []] call CBA_fnc_globalEvent;
};
