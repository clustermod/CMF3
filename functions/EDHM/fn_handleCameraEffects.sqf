/*
 * Author: Eric
 * Handles visual effects in EHDM
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Crew <ARRAY>
 * 2: playerDamage <NUMBER>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [this, [p1, p2], 0.3] call emf_edhm_fnc_handleCameraEffects
 *
 * Public: No
 */
scriptName "functions\edhm\fn_handleCameraEffects.sqf";
params["_veh", "_crew", "_playerDamage"];
if ((_crew find player) >= 0) then {
	enableCamShake true;
	addCamShake [20,2,20];

	[] spawn {
		if (vehicle player == player || player getVariable ["emf_edhm_SmokeAssigned", false]) exitWith {};
		private _v = vehicle player;
		private _pp = ppEffectCreate ["colorCorrections", 1501];
		private _c = 0;

		player setVariable ["emf_edhm_SmokeAssigned", true];

		while { _v != player && alive player } do {
			_c = (floor random(50))/100;
			_pp ppEffectEnable true;
			_pp ppEffectAdjust [1.0, 1.0, 0.0, [_c, _c, _c, 0.6], [0.0, 1.0, 1.0, 1.0], [0.4, 0.587, 0.114, 0.0]];
			_pp ppEffectCommit 2;

			if (vehicle player == player) exitWith {};
			sleep 3;
		};

		player setVariable ["emf_edhm_SmokeAssigned", false];
		_pp ppEffectAdjust [1.0, 1.0, 0.0, [0, 0, 0, 0], [0.0, 1.0, 1.0, 1.0], [0.4, 0.587, 0.114, 0.0]];
		_pp ppEffectCommit 2;
		sleep 3;

		ppEffectDestroy _pp;
	};

	player allowDamage false;

	player setVariable ["defaultVolume", soundVolume];
	0 fadeSound 0.2;
	playsound "ACE_Combat_Deafness_Medium_NoRing";
	playsound "ACE_Ring_Backblast";

	if (_playerDamage != 3) then {
		[_playerDamage] call emf_edhm_fnc_postProcess;
		[_playerDamage] call emf_edhm_fnc_handleMedical;
	} else {
		[0] call emf_edhm_fnc_postProcess;
	};

	[] spawn {
		uisleep 5;

		player allowDamage true;

		private _defaultVolume = player getVariable ["defaultVolume", soundVolume];
		0 fadeSound _defaultVolume;
	};
};

if ((player distance _veh) < 35) then {
	player setVariable ["defaultVolume", soundVolume];
	addCamShake [10,2,20];
	0 fadesound 0.3;
	playsound "ACE_Combat_Deafness_Medium_NoRing";
	playsound "ACE_Ring_Backblast";

	[] spawn
	{
		uisleep 5;

		private _defaultVolume = player getVariable ["defaultVolume", soundVolume];
		0 fadesound _defaultVolume;
	};

};
