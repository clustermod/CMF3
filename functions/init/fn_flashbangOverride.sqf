/*
 * Author: Eric
 * Overrides flashbang explosions
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_flashbangOverride
 *
 * Public: No
 */

// define a global variable of flashbangs to override and their time
emf_flashbang_grenades = [["rhs_mag_mk84", 1.2], ["ACE_M84", 1.2], ["rhs_mag_plamyam", 1.2]];

emf_flashbang_fnc_explosion = {
	private _expSparkEmitter = "#particlesource" createVehicleLocal (_this select 0);
	private _expSmokeEmitter = "#particlesource" createVehicleLocal (_this select 0);
	private _explight = "#lightpoint" createVehicleLocal (_this select 0);
	private _soundSource = "HeliHEmpty" createVehicleLocal (_this select 0);

	_soundSource spawn {
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
		_this say3D "flashbang_sound";
	};

	_explight setLightColor [1, 0.8, 0.7];
	_explight setLightAmbient [1, 0.8, 0.7];
	_explight setLightUseFlare true;
	_explight setLightFlareSize 2;
	_explight setLightFlareMaxDistance 20;
	_explight setLightBrightness 8;
	_explight setLightIntensity 9000;
	_explight setLightDayLight true;
	_explight setLightAttenuation [1, 0.1, 0, 0.3, 0];

	_expSparkEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,12,0],"","Billboard",0.1,0.1,[0,0,0],[0,0,1],1,2,0.3,0,[0.03],[[1,1,1,-6.5],[1,1,1,-6],[1,1,1,-5.5],[1,1,1,-4.5]],[-2],0,0,"","","",0,false,1,[[20000,13000,8000,0.5]]];
	_expSparkEmitter setParticleRandom [2,[0.5,0.5,0.1],[2.5,2.5,1],1,0.5,[0.05,0.05,0.05,0],0,0,360,1];
	_expSparkEmitter setDropInterval 0.0001;

	_expSmokeEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",0.1,0.1,[0,0,0],[0,0,1],1,0.8,0.3,0.4,[1],[[1,1,1,0.5],[1,1,1,0.2],[1,1,1,0.6],[1,1,1,0]],[-2],0,0,"","","",0,false,1,[[0,0,0,0.5]]];
	_expSmokeEmitter setParticleRandom [2,[0.5,0.5,0.5],[6,6,4],1,0.5,[0.05,0.05,0.05,0],0,0,360,1];
	_expSmokeEmitter setDropInterval 0.0003;

	[_expSparkEmitter, _expSmokeEmitter, _explight] spawn {
		sleep 0.1;
		(_this select 0) setDropInterval 50;
		(_this select 1) setDropInterval 50;
		(_this select 1) setParticleRandom [0.5,[0.5,0.5,0.5],[1,1,4],1,0.5,[0.05,0.05,0.05,0],0,0,360,1];
		deleteVehicle (_this select 2);
	};

	[_expSparkEmitter, _expSmokeEmitter, _soundSource] spawn {
		sleep 4;
		deleteVehicle (_this select 0);
		deleteVehicle (_this select 1);
		deleteVehicle (_this select 2);
	};
};

private _fired_event = {
  private _grenadeFuze = (createHashMapFromArray emf_flashbang_grenades) getOrDefault [(_this select 5), -1];
  if (_grenadeFuze > -1) then {
    [(_this select 6), _grenadeFuze] spawn {
		params["_grenade", "_grenadeFuze"];

		sleep _grenadeFuze;

		private _posASL = (getPosASL _grenade);
		private _pos = (getPos _grenade);

		_grenade setPos [0,0,0];
		deleteVehicle _grenade;
		[[_pos], emf_flashbang_fnc_explosion] remoteExec ["call"];

		private _units = _pos nearEntities 10;
		{
			private _inRoom = [_x, "VIEW"] checkVisibility [eyePos _x, _posASL];
			if (!isplayer _x && _inRoom > 0.6 && lifeState _x != "INCAPACITATED") then {
				_x spawn {
				  [_this, "Acts_CrouchingCoveringRifle01"] remoteExec ["switchMove"];
				  [_this, "all"] remoteExec ["disableAI"];
				  sleep 5;
				  [_this, "all"] remoteExec ["enableAI"];
				  if (animationState _this == "Acts_CrouchingCoveringRifle01") then {
					[_this, ""] remoteExec ["switchMove"];
				  };
				};
			}
		} forEach _units;
    };
  };
};

player addEventHandler ["Fired", _fired_event];

["ace_firedPlayer", _fired_event] call CBA_fnc_addEventHandler;
