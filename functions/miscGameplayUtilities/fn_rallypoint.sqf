/*
 * Author: Eric
 * Create a rallypoint system similar to Squad's rallypoint system.
 *
 * Arguments:
 * 0: Unit <OBJECT/ARRAY/STRING>
 * 1: Cooldown <NUMBER>
 * 2: PhysicalObject <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, 5] call EMF_fnc_rallypoint
 *
 * public: Yes
*/

params["_unit", ["_cooldown", 10], ["_PHObj", "Misc_backpackheap_EP1"]];
if (!hasInterface) exitwith {};

// Define function to place Rallypoint
private _EMF_FUNC_PLACE =
{
	// Define 2 variables to be used as states
	EMF_RP_Placed = false;
	EMF_RP_Canceled = false;

	// Create a physical representation
	private _RPObj = _PHObj createVehicle [0,0,0];

	// Create a eventHandler listening for DefaultAction key press
	private _RPPlaceEH = [_RPObj, _cooldown] spawn
	{
		params["_RPObj", "_cooldown"];

		// Block defaultAction from firing
		[player, ["", {}, "", 0, false, true, "DefaultAction", "!EMF_RP_Placed && !EMF_RP_Canceled"]] remoteExec ["addAction", 0, true];
		waitUntil {inputAction "DefaultAction" > 0};
		if ((player distance _RPObj) <= 5) then {
			EMF_RP_Placed = true;

			// Get and remove any old Rallypoint
			private _PREVRP = player getVariable ["EMF_RP_PREVRP", [objNull, objNull]];
			(_PREVRP select 0) remoteExec ["deleteVehicle", 0, true];
			(_PREVRP select 1) remoteExecCall ["BIS_fnc_removeRespawnPosition", 0, true];

			// Create new Rallypoint spawnpoint
			private _RPRespawn = [(side player), (getPos _RPObj)] remoteExecCall ["BIS_fnc_addRespawnPosition", 0, true];

			// Create a variable to facilitate data on the rallypoint
			player setVariable ["EMF_RP_PREVRP", [_RPObj, _RPRespawn], true];

			// Lock the rallypoint action for the duration of the cooldown
			player setVariable ["EMF_RP_Lock", true, true];

			_cooldown spawn
			{
				// Unlock the rallypoint action after _cooldown has lasted
				sleep (_this*60);
				player setVariable ["EMF_RP_Lock", true, true];
			};
		} else {
			hint "Too far away from RP";
		};
	};

	// Create a eventHandler listening for Optics key press
	[_RPObj, _RPPlaceEH] spawn
	{
		params["_RPObj", "_RPPlaceEH"];
		waitUntil {inputAction "Optics" > 0};
		EMF_RP_Canceled = true;

		deleteVehicle _RPObj;
		terminate _RPPlaceEH;
	};

	// Create a loop to move the physical object
	while {!EMF_RP_Placed || !EMF_RP_Canceled} do
	{
		private _dir = screenToWorld [0.5,0.5];

		if (player distance _dir < 5) then {
			_RPObj setPos [(_dir select 0), (_dir select 1), ((getPos player) select 2)];
		};
	};
};

if (isNil "_unit") then {
    'EMFpreventProne!Error [Unit not set]' remoteExec ["hint", 0];
};

switch (typeName _unit) do {
    case ("ARRAY"): {
			{
				private _RPlace = ["EMF_RPlace", "Place rallypoint", "rsc\rallypoint\place.paa", _EMF_FUNC_PLACE, {(vehicle _x) == _x && !(_x getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
				private _Rwait = ["EMF_RWait", "Place rallypoint", "rsc\rallypoint\restricted.paa", {hint format["can only be done once every %1 minutes", str(_cooldown)];}, {(vehicle _x) == _x && (_x getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
				[_x, 1, ["ACE_SelfActions"], _RPlace] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
				[_x, 1, ["ACE_SelfActions"], _Rwait] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
			} forEach _unit;
    };
		case ("OBJECT"): {
			private _RPlace = ["EMF_RPlace", "Place rallypoint", "rsc\rallypoint\place.paa", _EMF_FUNC_PLACE, {(vehicle _unit) == _unit && !(_unit getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
			private _Rwait = ["EMF_RWait", "Place rallypoint", "rsc\rallypoint\restricted.paa", {hint format["can only be done once every %1 minutes", str(_cooldown)];}, {(vehicle _unit) == _unit && (_unit getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
			[_unit, 1, ["ACE_SelfActions"], _RPlace] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _unit];
			[_unit, 1, ["ACE_SelfActions"], _Rwait] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _unit];
		};
		case ("STRING"): {
			{
				if ((_x getVariable ["unitSquadRole", "RFL"]) == "SL") then {
					private _RPlace = ["EMF_RPlace", "Place rallypoint", "rsc\rallypoint\place.paa", _EMF_FUNC_PLACE, {(vehicle _x) == _x && !(_x getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
					private _Rwait = ["EMF_RWait", "Place rallypoint", "rsc\rallypoint\restricted.paa", {hint format["can only be done once every %1 minutes", str(_cooldown)];}, {(vehicle _x) == _x && (_x getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
					[_x, 1, ["ACE_SelfActions"], _RPlace] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
					[_x, 1, ["ACE_SelfActions"], _Rwait] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
				};
			} forEach allPlayers;
		};
		default {
		    (format['EMFrallypoint!Error [Unit must be a object, array or a string : %1', (typeName _unit)]) remoteExec ["hint", 0];
		};
};
