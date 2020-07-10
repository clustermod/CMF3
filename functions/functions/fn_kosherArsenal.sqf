params[["_arsenalLight", false], ["_forcePrimary", true]];
waitUntil{!alive player};
waitUntil{alive player};
uisleep 0.1;

player setpos [((getPos player) select 0) + random[-5, 0, 5], ((getPos player) select 1) + random[-5, 0, 5], ((getPos player) select 2)];

if (_arsenalLight) then
{
	EMF_KA_LIGHT = "#lightpoint" createVehicle getPos player;
	EMF_KA_LIGHT setPosASL getPosASL player;
	EMF_KA_LIGHT setLightBrightness 0.2;
	EMF_KA_LIGHT setLightAmbient [1.0, 1.0, 1.0];
	EMF_KA_LIGHT setLightColor [1.0, 1.0, 1.0];
};
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
removeAllWeapons player;
removeAllItems player;
player unlinkItem "Itemradio";
player unlinkItem "ItemRadioAcreFlagged";
[player, "ACRE_PRC343"] call acre_sys_core_fnc_removeGear;
[player] call acre_sys_core_fnc_getGear;

_valid = false;

_newfirearmEH = [(primaryWeapon player), (handgunWeapon player), (secondaryWeapon player)] spawn
{
	params["_prevPrimary", "_prevHandgun", "_prevSecondary"];
	while {true} do
	{
		waitUntil{((primaryWeapon player) != _prevPrimary) or ((handgunWeapon player) != _prevHandgun) or ((secondaryWeapon player) != _prevSecondary)};

		if ((primaryWeapon player) != _prevPrimary) then
		{
			_magazine = primaryWeaponMagazine player;
			{
				player removeMagazines _x;
				player removePrimaryWeaponItem _x;
			} forEach _magazine;
		};

		if ((handgunWeapon player) != _prevHandgun) then
		{
			_magazine = handgunMagazine player;
			{
				player removeMagazines _x;
				player removeHandgunItem _x;
			} forEach _magazine;
		};

		if ((secondaryWeapon player) != _prevSecondary) then
		{
			_magazine = secondaryWeaponMagazine player;
			{
				player removeMagazines _x;
			} forEach _magazine;
		};
		_magazine = nil;
	};
};

while {!_valid} do
{
	["Open",[nil, _arsenalObj, false]] call bis_fnc_arsenal;
	waitUntil { isnull ( uinamespace getvariable "RSCDisplayArsenal" ) };
	player removeAction (player getvariable "bis_fnc_arsenal_action");
	player setvariable ['bis_fnc_arsenal_action',nil];

	_permittedGear 	= player getVariable ["EMF_KA_permittedGear", 0];
	_weapons = [(primaryWeapon player), (handgunWeapon player), (secondaryWeapon player), (binocular player)];
	_magazines = magazines player;
	_items = ((items player) + [(uniform player)] + [(vest player)] + [(goggles player)] + [(hmd player)] + [(headGear player)] + (assignedItems player));
	_backpack = backpack player;

	_loadoutValid = [true, ""];
	{
		if (typeName _x == "STRING") then
		{
			if (!(_x in (_permittedGear select 3) or _x == "")) exitWith {_loadoutValid = [false, getText(configfile >> "CfgWeapons" >> _x >> "displayName")];};
		};
	} forEach _weapons;
	{
		if (!(_x in (_permittedGear select 2) or _x == "")) exitWith {_loadoutValid = [false, getText(configfile >> "CfgMagazines" >> _x >> "displayName")];};
	} forEach _magazines;
	{
		if (_x != (binocular player)) then
		{
			if (!(_x in (_permittedGear select 1) or _x == "" or _x == "ItemRadioAcreFlagged")) exitWith {_loadoutValid = [false, _x/*getText(configfile >> "CfgWeapons" >> _x >> "displayName")*/];};
		};
	} forEach _items;

	if (!(_backpack in (_permittedGear select 0) or _backpack == "")) then {_loadoutValid = [false, getText(configfile >> "CfgVehicles" >> _backpack >> "displayName")];};

	if ((primaryWeapon player) == "" and _forcePrimary) then
	{
		_loadoutValid = [false, "REQ"];
	};

	if (!(_loadoutValid select 0)) then
	{
		if ((_loadoutValid select 1) == "REQ") then
		{
			["<t color='#ff0000'>You are required to have a primary firearm</t>", -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
		} else {
			[format["<t color='#ff0000'>you have an illegal item: %1</t>", str(_loadoutValid select 1)], -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
		};
	} else {
		_valid = true;
	};
	uisleep 0;
};

terminate _newfirearmEH;

if (_arsenalLight) then
{
	deleteVehicle EMF_KA_LIGHT;
};

player setVariable ["EMF_KA_Done", true];
["AmmoboxExit", _arsenalObj] call BIS_fnc_arsenal;
deleteVehicle _arsenalObj;
