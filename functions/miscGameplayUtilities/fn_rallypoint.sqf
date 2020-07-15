params["_unit", ["_cooldown", 10]];
scopeName "main";
if (!hasInterface) exitwith {};

_rallyplace = ["_rallyplace", "Place Rallypoint", "rsc\rallypoint\place.paa", {rallyplace = true;}, {(vehicle player) == player}] call ace_interact_menu_fnc_createAction;
_rallywait = ["_rallywait", "Place Rallypoint", "rsc\rallypoint\restricted.paa", {hint format["can only be done once every %1 minutes", str(_cooldown)];}, {true}] call ace_interact_menu_fnc_createAction;

[_unit, 1, ["ACE_SelfActions"], _rallyplace] call ace_interact_menu_fnc_addActionToObject;

rallyplace = false;

cancel = false;

while {true} do {
scopeName "mainloop";

	waituntil {rallyplace};

	// create temporary global variable
	place = true;

	// create the backpacks and add an action to "default action"
	if (!isNil "_rallypoint") then {
		deleteVehicle _rallypoint;
	};
	_rallypoint = "Misc_backpackheap_EP1" createvehicle [0, 0, 0];

	_StartAction = player addAction ["", {place = false;}, "", 0, false, true, "DefaultAction"];

	_StopAction = player addAction ["Cancel", {cancel = true;}, "", 1, false, true, "Optics"];

	// block the create action
	[player, 1, ["ACE_SelfActions", "_rallyplace"]] call ace_interact_menu_fnc_removeActionFromObject;
	[player, 1, ["ACE_SelfActions"], _rallywait] call ace_interact_menu_fnc_addActionToObject;


	1 cutRsc ["LMBhint","PLAIN"];


	//move to where player is looking until _action is triggered
	while {place} do {
		scopeName "movepack";
		_dir = screenToWorld [0.5,0.5];

		if (player distance _dir < 5) then {
			_rallypoint setPos _dir;
		};

		if (cancel) then {
			deleteVehicle _rallypoint;
			breakTo "mainloop";
		};

	};

	//remove action
	player removeAction _StartAction;
	player removeAction _StopAction;
	1 cutRsc ["Default","PLAIN"];

	//remove temporary global variable
	place = nil;

	if (!cancel) then {
		if (player distance (position _rallypoint) > 5) exitwith {
			deleteVehicle _rallypoint;
			hint "Rallypoint too far away";
		};


		_rallyrespawn = _unit getVariable [(format ["%1_RP", (name _unit)]), "notSet"];
		_rallyobject = _unit getVariable [(format ["%1_RPObject", (name _unit)]), "notSet"];
		if (typeName _rallyrespawn == "ARRAY") then {
			_rallyrespawn call BIS_fnc_removeRespawnPosition;
			deleteVehicle _rallyobject;
		};

		_rallymarker = [west, (position _rallypoint)] call BIS_fnc_addRespawnPosition;
		_unit setVariable [format ["%1_RP", (name _unit)], _rallymarker];
		_unit setVariable [format ["%1_RPObject", (name _unit)], _rallypoint];

		// sleep x minutes
		uisleep (_cooldown*60);

	};

	// initiate waituntil again
	rallyplace = false;

	// re-add the create action
	[player, 1, ["ACE_SelfActions", "_rallywait"]] call ace_interact_menu_fnc_removeActionFromObject;
	[player, 1, ["ACE_SelfActions"], _rallyplace] call ace_interact_menu_fnc_addActionToObject;

	cancel = false;
};
