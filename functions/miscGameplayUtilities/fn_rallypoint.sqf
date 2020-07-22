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
 * <Boolean>
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
	private _cooldown = (player getVariable ["EMF_RP_PARAMS", [player, 10, "Misc_backpackheap_EP1"]] select 1);
	private _PHObj = (player getVariable ["EMF_RP_PARAMS", [player, 10, "Misc_backpackheap_EP1"]] select 2);

	// Define 2 variables to be used as states
	EMF_RP_Placed = false;
	EMF_RP_Canceled = false;

	// Create dialog
	5000 cutRsc ["EMF_rallyPointDialog", "PLAIN"];

	// Create a eventHandler detecting mouse inputs
	private _keyEventhandler = (findDisplay 46) displayAddEventHandler ["mouseButtonDown", '
		params ["_displayorcontrol", "_button"];
		if (_button == 1) then {
		    EMF_RP_Canceled = true;
		};
		if (_button == 0) then {
				EMF_RP_Placed = true;
		};
	'];

	// Create a physical representation
	private _RPObj = _PHObj createVehicle (getPos player);

	// Create a loop to move the physical object
	private _moveRP = _RPObj spawn {
		while {true} do
		{
			private _dir = screenToWorld [0.5,0.5];

			if (player distance _dir < 5) then {
				_this setPos _dir;
			};
		};
		[_this, _dir] remoteExec ["setPos", 0, true];
	};

	// Create a eventHandler listening for DefaultAction key press
	private _RPPlaceEH = [_RPObj, _cooldown, _moveRP, _keyEventhandler] spawn
	{
		params["_RPObj", "_cooldown", "_moveRP", "_keyEventhandler"];

		// Block defaultAction from firing
		[player, ["", {}, "", 0, false, true, "DefaultAction", "!EMF_RP_Placed && !EMF_RP_Canceled"]] remoteExec ["addAction", 0, true];
		waitUntil {EMF_RP_Placed};
		if ((player distance _RPObj) <= 5) then {
			terminate _moveRP;
			(findDisplay 46) displayRemoveEventHandler ["mouseButtonDown", _keyEventhandler];
			5000 cutRsc ["Default", "PLAIN"];

			// Get and remove any old Rallypoint
			private _PREVRP = player getVariable ["EMF_RP_PREVRP", nil];
			if (!isNil "_PREVRP") then
			{
				(_PREVRP select 0) remoteExec ["deleteVehicle", 0, true];
				(_PREVRP select 1) call BIS_fnc_removeRespawnPosition;
			};

			// Create new Rallypoint spawnpoint
			private _RPRespawn = [(side player), (getPos _RPObj), format["%1 rally point", (groupId (group player))]] call BIS_fnc_addRespawnPosition;

			// Create a variable to facilitate data on the rallypoint
			player setVariable ["EMF_RP_PREVRP", [_RPObj, _RPRespawn], true];

			// Lock the rallypoint action for the duration of the cooldown
			player setVariable ["EMF_RP_Lock", true, true];

			_cooldown spawn
			{
				// Unlock the rallypoint action after _cooldown has lasted
				sleep (_this * 60);
				player setVariable ["EMF_RP_Lock", false, true];
			};
		} else {
			hint "Too far away from RP";
		};
	};

	[_RPObj, _RPPlaceEH, _moveRP, _keyEventhandler] spawn
	{
		params["_RPObj", "_RPPlaceEH", "_moveRP", "_keyEventhandler"];
		waitUntil {EMF_RP_Canceled};
		terminate _moveRP;
		(findDisplay 46) displayRemoveEventHandler ["mouseButtonDown", _keyEventhandler];
		5000 cutRsc ["Default", "PLAIN"];

		deleteVehicle _RPObj;
		terminate _RPPlaceEH;
	};
};

if (isNil "_unit") exitWith {  ['Unit is not set'] call BIS_fnc_error; 'Unit is not set' call BIS_fnc_log;};

private _RPlace = ["EMF_RPlace", "Place rallypoint", "\A3\ui_f\data\map\markers\military\end_CA.paa", _EMF_FUNC_PLACE, {(vehicle player) == player && !(player getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;
private _Rwait = ["EMF_RWait", "Place rallypoint", "\A3\ui_f\data\map\markers\military\objective_CA.paa", {hint format["can only be done once every %1 minutes", str((player getVariable ["EMF_RP_PARAMS", [objNull, 10, ""]]) select 1)];}, {(vehicle player) == player && (player getVariable ["EMF_RP_Lock", false])}] call ace_interact_menu_fnc_createAction;

switch (typeName _unit) do {
    case ("ARRAY"): {
			{
				_x setVariable ["EMF_RP_PARAMS", [_unit, _cooldown, _PHObj], true];
				[_x, 1, ["ACE_SelfActions"], _RPlace] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
				[_x, 1, ["ACE_SelfActions"], _Rwait] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
			} forEach _unit;
			true;
    };
		case ("OBJECT"): {
			_unit setVariable ["EMF_RP_PARAMS", [_unit, _cooldown, _PHObj], true];
			[_unit, 1, ["ACE_SelfActions"], _RPlace] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _unit];
			[_unit, 1, ["ACE_SelfActions"], _Rwait] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _unit];
			true;
		};
		case ("STRING"): {
			{
				private _hasRally = _x getVariable ["EMF_RP_PARAMS", [objNull, 5, ""]];
				if ((_x getVariable ["unitSquadRole", "RFL"]) == "SL" && isNull (_hasRally select 0)) then {
					_x setVariable ["EMF_RP_PARAMS", [_unit, _cooldown, _PHObj], true];
					[_x, 1, ["ACE_SelfActions"], _RPlace] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
					[_x, 1, ["ACE_SelfActions"], _Rwait] remoteExecCall ["ace_interact_menu_fnc_addActionToObject", _x];
				};
				true;
			} forEach allPlayers;
		};
		default {
				['Unit must be type "OBJECT", "ARRAY" or "STRING", type %1 supplied', (typeName _unit)] call BIS_fnc_error;
				['Unit must be type "OBJECT", "ARRAY" or "STRING", type %1 supplied', (typeName _unit)] call BIS_fnc_log;
				false;
		};
};
