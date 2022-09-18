#include "script_component.hpp"
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
 * [] call cmf_init_fnc_flashbangOverride
 *
 * Public: No
 */
SCRIPT(flashbangOverride);

/* Check if it is enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,overrideFlashbangs) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* Define a variable to configure grenades */
GVAR(flashbang_grenades) = [["rhs_mag_mk84", [1.2]], ["ACE_M84", [1.2]], ["rhs_mag_fakel", [1.2]],  ["rhs_mag_plamyam", [1.2]], ["rhs_mag_fakels", [1.2]], ["rhs_mag_zarya2", [1.2]], ["rhssaf_mag_rshb_p98", [1.2]], ["ACE_CTS9", [1.2, 9, {0.5}]]];

/* Extra particle effects if the player is inside */
GVAR(flashbang_extraEffects) = {
	if (_this select 1) then {
		private _SmokeEmitter = "#particlesource" createVehicleLocal [((_this select 0) select 0), ((_this select 0) select 1), ((_this select 0) select 2) + 0.1];
		private _sparkEmitter = "#particlesource" createVehicleLocal [((_this select 0) select 0), ((_this select 0) select 1), ((_this select 0) select 2) + 0.1];

		[_SmokeEmitter, _sparkEmitter] spawn {
			params["_SmokeEmitter", "_sparkEmitter"];
			_sparkEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,12,0],"","Billboard",1,20,[0,0,1.2],[0,0,0],0,10.071,7.9,0,[0.005,0.005,0.005,0.005,0.005,0.005,0.005,0.005,0.005,0],[[1,1,1,-6.5],[1,1,1,-6],[1,1,1,-5.5],[1,1,1,-4.5]],[1000],1,0,"","","",0,false,0,[[20000,13000,8000,0.5]]];
			_sparkEmitter setParticleRandom [1,[2,2,1],[0,0,0],0,0,[0,0.15,0.15,0],0,0,1,0];
			_sparkEmitter setDropInterval 0.5;
			_SmokeEmitter setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,30,[0,0,0],[0,0,0],0,0.051,0.04,0,[3.5],[[0.305037,0.301192,0.3,0.05]],[1000],0.001,0.008,"","","",0,false,0,[[0,0,0,0]]];
			_SmokeEmitter setParticleRandom [1,[4,1.5,1],[0,0,0],0,0,[0,0,0,0],0,0,1,0];
			_SmokeEmitter setDropInterval 0.0005;

			_smokeEmitter spawn {
				sleep 0.1;
				_this setDropInterval 50;
			};

			[_smokeEmitter, _sparkEmitter] spawn {
				sleep 3;
				deleteVehicle (_this select 1);
				sleep 37;
				deleteVehicle (_this select 0);
			};
		};
	};
};

/* Explosion effect */
GVAR(flashbang_explosion) = {
	private _soundSource = "HeliHEmpty" createVehicleLocal (_this select 0);
	private _expSparkEmitter = "#particlesource" createVehicleLocal (_this select 0);
	private _expSmokeEmitter = "#particlesource" createVehicleLocal (_this select 0);
	private _explight = "#lightpoint" createVehicleLocal (_this select 0);

	_explight setLightColor [1, 0.8, 0.7];
	_explight setLightAmbient [1, 0.8, 0.7];
	_explight setLightUseFlare true;
	_explight setLightFlareSize 2;
	_explight setLightFlareMaxDistance 20;
	_explight setLightBrightness 8;
	_explight setLightIntensity 9000;
	_explight setLightDayLight true;
	_explight setLightAttenuation [1, 0.1, 10, 0.3, 0.1, 30];

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

	[_expSparkEmitter, _expSmokeEmitter] spawn {
		sleep 4;
		deleteVehicle (_this select 0);
		deleteVehicle (_this select 1);
	};

	if (_this select 1) then {
		_soundSource spawn {
			_this say3D "cmf_flashbang_inside";
			_this say3D "cmf_flashbang_inside";
			_this say3D "cmf_flashbang_inside";
			_this say3D "cmf_flashbang_inside";
			_this say3D "cmf_flashbang_inside";
			_this say3D "cmf_flashbang_inside";

			sleep 4;
			deleteVehicle _this;
		};
	} else {
		_soundSource spawn {
			_this say3D "cmf_flashbang_outside";
			_this say3D "cmf_flashbang_outside";
			_this say3D "cmf_flashbang_outside";
			_this say3D "cmf_flashbang_outside";
			_this say3D "cmf_flashbang_outside";
			_this say3D "cmf_flashbang_outside";

			sleep 4;
			deleteVehicle _this;
		};
	};
};

/* Check if player fired */
private _fired_event = {
  private _grenadeConfig = (createHashMapFromArray GVAR(flashbang_grenades)) getOrDefault [(_this select 5), [-1]];
  if ((_grenadeConfig select 0) > -1) then {
    [(_this select 6), _grenadeConfig] spawn {
			params["_grenade", "_grenadeConfig", ""];
			_grenadeConfig params["_grenadeFuze", ["_bangs", 1], ["_bangDelay", {random [0.1, 0.3, 0.8]}]];

			sleep _grenadeFuze;

			private _posASL = (getPosASL _grenade);
			private _pos = (getPos _grenade);
			private _classname = (typeOf _grenade);
			private _height = ((lineIntersectsSurfaces [_posASL, [(_posASL select 0), (_posASL select 1), 0], _grenade] select 0) select 0) select 2;
			if (isNil "_height") then {_height = 0};

			private _grenadeObject = createVehicle [_classname, [_pos select 0, _pos select 1], [], 0, "NONE"];
			_grenadeObject setPosASL [(_pos select 0), (_pos select 1), _height + 0.03];
			_grenadeObject setVectorUp [(random(selectRandom[1,-1])),(random(selectRandom[1,-1])),0];
			_grenadeObject enableSimulation false;

			/* Disable ACE Pickup on grenades */
			private _acePickup = "Land_Can_V2_F" createVehicle getPos _grenadeObject;
			_acePickup setPosASL getPosASL _grenadeObject;
			_acePickup hideObjectGlobal true;
			_acePickup setVectorUp [(random(selectRandom[1,-1])),(random(selectRandom[1,-1])),0];
			[_grenadeObject, _acePickup] call BIS_fnc_attachToRelative;
			_acePickup setVariable ["ace_advanced_throwing_disablePickUp", true, true];
			_acePickup enableSimulation false;

			_grenade setPos [0,0,0];
			deleteVehicle _grenade;

			/* Check if the player is inside */
			lineIntersectsSurfaces [
				getPosWorld _grenadeObject,
				getPosWorld _grenadeObject vectorAdd [0, 0, 50],
				_grenadeObject, objNull, true, 1, "GEOM", "NONE"
			] select 0 params ["","","","_inHouse"];
			private _inHOuse = !isNil "_inHouse";

			if (_bangDelay isEqualType {}) then {
				_bangDelay = call _bangDelay;
			};

			if (_bangs > 1) then {
				[[_pos, _inHouse], GVAR(flashbang_extraEffects)] remoteExec ["call"];
			  for "_i" from 0 to _bangs do {
					_pos = [((_pos select 0)+random[-0.5,0,0.5]), ((_pos select 1)+random[-0.5,0,0.5]), (_pos select 2)];
		      [[_pos, _inHouse], GVAR(flashbang_fnc_explosion)] remoteExec ["call"];

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
					sleep _bangDelay;
					private _newPos = (getPos _grenadeObject) getPos [(random 1), (random 360)];
					if ([_grenadeObject, "VIEW"] checkVisibility [[(_newPos select 0), (_newPos select 1), _height + 0.5], [(_posASL select 0), (_posASL select 1), _height + 0.5]] > 0.6) then {
						_grenadeObject setPosASL [(_newPos select 0), (_newPos select 1), _height + 0.03];
						_grenadeObject setVectorUp [(random(selectRandom[1,-1])),(random(selectRandom[1,-1])),0];
						_pos = getPos _grenadeObject;
						_posASL = getPosASL _grenadeObject;
					};
			  };
			} else {
				[[_pos, _inHouse], GVAR(flashbang_extraEffects)] remoteExec ["call"];
				[[_pos, _inHouse], GVAR(flashbang_explosion)] remoteExec ["call"];

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
};

player addEventHandler ["Fired", _fired_event];

["ace_firedPlayer", _fired_event] call CBA_fnc_addEventHandler;
