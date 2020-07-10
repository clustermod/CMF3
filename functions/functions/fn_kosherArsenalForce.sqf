params["_obj"];

EMF_arsenalFunc =
{
	params["_obj"];
	_arsenalLoadouts = missionNamespace getVariable "EMF_KA_ArsenalKit";
	_arsenalObj = "HeliHEmpty" createVehicleLocal [0,0,0];

	if (typeName _arsenalLoadouts == "ARRAY") then
	{
		{
			if (player getVariable ["unitTeamRole", 0] == _forEachIndex) then
			{
				[(toUpper(player getVariable ["unitSquadRole", "RFL"])), _arsenalObj, false] execVM (format["rsc\loadouts\%1.sqf", _x]);
			}
		} forEach _arsenalLoadouts;
	} else {
		if (typeName _arsenalLoadouts == "STRING") then
		{
			[(toUpper(player getVariable ["unitSquadRole", "RFL"])), _arsenalObj, false] execVM (format["rsc\loadouts\%1.sqf", _arsenalLoadouts]);
		}
	};

	_valid = false;
	while {!_valid} do
	{
		["Open",[nil, _arsenalObj, false]] call bis_fnc_arsenal;
		waitUntil { isnull ( uinamespace getvariable "RSCDisplayArsenal" ) };
		_obj removeAction (_obj getvariable "bis_fnc_arsenal_action");
		_obj setvariable ['bis_fnc_arsenal_action',nil];

		_permittedGear 	= _obj getVariable ["EMF_KA_permittedGear", 0];
		_weapons = [(primaryWeapon _obj), (handgunWeapon _obj), (secondaryWeapon _obj)];
		_magazines = magazines _obj;
		_items = ((items _obj) + [(uniform _obj)] + [(vest _obj)] + [(goggles _obj)] + [(hmd _obj)] + [(headGear _obj)] + (assignedItems _obj));
		if ((primaryWeapon _obj) != "") then
		{
			_items pushBackUnique ((weaponsItems _obj) select 0);
		};
		if ((secondaryWeapon _obj) != "") then
		{
			_items pushBackUnique ((weaponsItems _obj) select 1);
		};
		if ((handgunWeapon _obj) != "") then
		{
			_items pushBackUnique ((weaponsItems _obj) select 2);
		};
		_backpack = backpack _obj;

		_loadoutValid = [true, ""];
		{
			if (typeName _x == "STRING") then
			{
				if (!(_x in (_permittedGear select 3) or _x == "")) exitWith {_loadoutValid = [false, getText(configfile >> "CfgWeapons" >> _x >> "displayName")];};
			}
		} forEach _weapons;
		{
			if (!(_x in (_permittedGear select 2) or _x == "")) exitWith {_loadoutValid = [false, getText(configfile >> "CfgMagazines" >> _x >> "displayName")];};
		} forEach _magazines;
		{
			if (!(_x in (_permittedGear select 1) or _x == "" or _x == "ItemRadioAcreFlagged")) exitWith {_loadoutValid = [false, _x/*getText(configfile >> "CfgWeapons" >> _x >> "displayName")*/];};
		} forEach _items;

		if (!(_backpack in (_permittedGear select 0) or _backpack == "")) then {_loadoutValid = [false, getText(configfile >> "CfgVehicles" >> _backpack >> "displayName")];};

		if (!(_loadoutValid select 0)) then
		{
			[format["<t color='#ff0000'>you have an illegal item: %1</t>", str(_loadoutValid select 1)], -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
		} else {
			_valid = true;
		};
	};

	if (_arsenalLight) then
	{
		deleteVehicle EMF_KA_LIGHT;
	};

	_obj setVariable ["EMF_KA_Done", true];
	["AmmoboxExit", _arsenalObj] call BIS_fnc_arsenal;
	deleteVehicle _arsenalObj;
};

[_obj] remoteExecCall ["EMF_arsenalFunc", _obj];
