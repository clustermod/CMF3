/*
 * Author: Eric
 * Initializees EHDM on vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [this] call EMF_fnc_ehdm_vehicleInit
 *
 * Public: Yes
 */
params["_veh"];

_veh addAction ["Flip vehicle",{
	params ["_vehicle"];

	[30, [], {}, {}, "Flipping vehicle..."] call ace_common_fnc_progressBar;
	sleep 30;
	private _normalVec = surfaceNormal getPos _vehicle;
	if (!local _vehicle) then {
		[_vehicle,_normalVec] remoteExec ["setVectorUp",_vehicle];
	} else {
		_vehicle setVectorUp _normalVec;
	};
	_vehicle setPosATL [getPosATL _vehicle select 0, getPosATL _vehicle select 1, 0];
},[],1.5,true,true,"","(vectorUp _target) vectorCos (surfaceNormal getPos _target) <0.5",5];

private _simType = toLower getText (configFile >> "CfgVehicles" >> typeOf _veh >> "simulation");
if (_simType in ["parachute", "paraglide"]) exitWith {};

_veh addEventHandler ["HandleDamage", {
	private _veh = _this select 0;
	private _projectile = _this select 4;

	if ((damage _veh) > 0.85 && isDamageAllowed _veh || _veh getHitPointDamage "hitEngine" > 0.85 && isDamageAllowed _veh) then {

		_veh setDamage 0.9;
		_veh allowDamage false;

		private _conf = getNumber (configfile >> "CfgAmmo" >> _projectile >> "explosive");
		private _conf2 = getText (configfile >> "CfgAmmo" >> _projectile >> "warheadName");
		private _Damage = getNumber (configfile >> "CfgAmmo" >> _projectile >> "hit");

		if (_conf == 1 or _conf2 != "") then {
			_veh setVelocity [0, 1, 1.4];

			[_veh, _Damage] call EMF_fnc_handleEffects;

		};
		[_veh] spawn {
			params["_veh"];
			waitUntil {(count crew _veh) == 0};
			//_veh lock true;
		};
		[_veh] spawn {
			params["_veh"];
			waitUntil {(damage _veh < 0.6)};
			_veh allowDamage true;
			//_veh lock false;
		};
	};
}];
