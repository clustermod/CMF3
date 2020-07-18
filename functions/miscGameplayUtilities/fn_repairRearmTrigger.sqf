/*
 * Author: Eric
 * Repairs and rearms vehicles of supplied units.
 *
 * Arguments:
 * 0: thisTriggerList <ARRAY>
 * 1: allowDamage <BOOL> [true]
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisList, false] call EMF_fnc_repairRearmTrigger
 *
 * public: Yes
*/

params["_thisTriggerList", ["_allowDamage", true]];

// Check if params are set and is of correct type
if (isNil "_thisTriggerList") exitWith {  ['thisList is not set'] call BIS_fnc_error; 'thisList is not set' call BIS_fnc_log;};
if (typeName _thisTriggerList != "ARRAY") exitWith {  ['thisList must be type "ARRAY", type %1 supplied', (typeName _thisTriggerList)] call BIS_fnc_error; ['thisList must be type "ARRAY", type %1 supplied', (typeName _thisTriggerList)] call BIS_fnc_log;};

// only run on server.
if (!isServer) exitWith {};

// Run through the array and select the vehicles that has received damage or in need of rearming
private _vehicleArray = [];
{
	private _vic = _x;
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
			private _vehicleCrew = nil;

			// Get the player crew of the vehicle
			_vehicleCrew = [];
			{
				if (isPlayer _x) then {_vehicleCrew pushBackUnique _x ;};
			} forEach (crew _vic);

			// Set fuel to 0 to restrict the vehicle from moving
			[_vic, 0] remoteExec ["setFuel", 0, true];

			if (!_allowDamage) then {
				// Disable damage if _allowDamage is true
				[_vic, false] remoteExec ["allowDamage", 0, true];
			};

			// Lock the vehicle
			[_vic, true] remoteExec ["lock", 0, true];

			{["Repair Center", ["Service is initializing","Vehicle will be locked for your safety"]] remoteExec ["hintC", _x, true];} forEach _vehicleCrew;
			sleep 3;

			{[_vic, "Initializing PM sequence..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
			sleep random 10;

			{[_vic, "Diagnosing Problems..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
			sleep random 30;

			// Fix the vehicle if it's damaged
			if (damage _vic > 0.05) then {
				{[_vic, "Repairing..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
				sleep random 30;
				[_vic, 0] remoteExec ["setDammage", 0, true];
			};

			// Rearm the vehicle if it's ammo is less than 1
			if (({getNumber (configFile >> "CfgMagazines" >> _x select 0 >> "count") != _x select 1} count (magazinesAmmo _vic)) > 0) then {
				{[_vic, "Rearming..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
				sleep random 30;
				[_vic, 1] remoteExec ["setVehicleAmmo", 0, true];
			};

			{[_vic, "Refueling..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;
			sleep 5;
			{[_vic, "Finished..."] remoteExec ["vehicleChat", _x, true];} forEach _vehicleCrew;

			// Refuel vehicle to allow it to move again
			[_vic, 1] remoteExec ["setFuel", 0, true];

			// Unlock vehicle
			[_vic, false] remoteExec ["lock", 0, true];
			if (!_allowDamage) then {
				// Enable damage
				[_vic, true] remoteExec ["allowDamage", 0, true];
			};

		};
	} forEach _vehicleArray;
};
