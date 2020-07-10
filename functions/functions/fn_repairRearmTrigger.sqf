params["_thisTriggerList", ["_allowDamage", true]];

if (!isServer) exitWith {};

_vehicleArray = [];
{
	_vic = _x;
	if (!(_x isKindOf "Man") && (({getNumber (configFile >> "CfgMagazines" >> _x select 0 >> "count") != _x select 1} count (magazinesAmmo _vic)) > 0 || (damage _vic > 0.05))) then
	{
		_vehicleArray pushBackUnique _vic;
	};
	_vic = nil;
} forEach _thisTriggerList;

if (count _vehicleArray > 0) then
{
	{
		[_x, _allowDamage] spawn
		{
			params["_vic", "_allowDamage"];
			_vehicleCrew = nil;
			_vehicleCrew = [];
			{
				if (isPlayer _x) then {_vehicleCrew pushBackUnique _x ;};
			} forEach (crew _vic);

			hint str(_vehicleCrew);

			[_vic, 0] remoteExec ["setFuel", 0, true];
			if (!_allowDamage) then {
				[_vic, false] remoteExec ["allowDamage", 0, true];
			};
			[_vic, true] remoteExec ["lock", 0, true];
			//{["Repair Center", ["Service is initializing","Vehicle will be locked for your safety"]] remoteExec ["hintC", _x, true];} forEach _vehicleCrew;
			sleep 3;
			{[_vic, "Initializing PM sequence..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
			sleep random 10;
			{[_vic, "Diagnosing Problems..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
			sleep random 30;
			if (damage _vic > 0.05) then {
				{[_vic, "Repairing..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
				sleep random 30;
				[_vic, 0] remoteExec ["setDammage", 0, true];
			};
			if (({getNumber (configFile >> "CfgMagazines" >> _x select 0 >> "count") != _x select 1} count (magazinesAmmo _vic)) > 0) then {
				{[_vic, "Rearming..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
				sleep random 30;
				[_vic, 1] remoteExec ["setVehicleAmmo", 0, true];
			};
			{[_vic, "Refueling..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
			sleep 5;
			{[_vic, "Finished..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;

			[_vic, 1] remoteExec ["setFuel", 0, true];
			[_vic, false] remoteExec ["lock", 0, true];
			if (!_allowDamage) then {
				[_vic, true] remoteExec ["allowDamage", 0, true];
			};

		};
	} forEach _vehicleArray;
};
