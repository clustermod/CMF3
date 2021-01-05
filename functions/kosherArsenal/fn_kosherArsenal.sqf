/*
 * Author: Eric
 * Launches kosherArsenal, a arsenal rewrite that only allows the player to pick a loadout upon respawn. Player will be able to open "rearm arsenal's" later
 * created with: EMF_fnc_kosherAmmoBox.
 *
 * Arguments:
 * 0: arsenalLight <BOOL>
 * 1: forcedPrimary <BOOL>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [true, true] call EMF_fnc_kosherArsenal
 *
 * public: No
*/

params[["_arsenalLight", false], ["_forcePrimary", true]];

// Wait until player respawns the first time (replace with a respawn eventhandler)
waitUntil {!alive Player};
waitUntil {alive Player};
uisleep 0.1;

// Since players won't be able to move immediately randomly move them around in a 5m radius from the respawn position
player setpos [((getPos player) select 0) + random[-5, 0, 5], ((getPos player) select 1) + random[-5, 0, 5], ((getPos player) select 2)];

// If _arsenalLight is true attach a light to the player
if (_arsenalLight) then
{
	EMF_KA_LIGHT = "#lightpoint" createVehicle getPos player;
	EMF_KA_LIGHT setPosASL getPosASL player;
	EMF_KA_LIGHT setLightBrightness 0.2;
	EMF_KA_LIGHT setLightAmbient [1.0, 1.0, 1.0];
	EMF_KA_LIGHT setLightColor [1.0, 1.0, 1.0];
};

// Get whitelists set with EMF_fnc_kosherArsenalLoad
private _arsenalLoadouts = player getVariable "EMF_KA_ArsenalKit";
private _arsenalObj = "HeliHEmpty" createVehicleLocal [0,0,0];

// Open the whitelist corresponding with the player's team
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

// Remove all items from the player
removeAllItems player;
player unlinkItem "Itemradio";
player unlinkItem "ItemRadioAcreFlagged";
[player, "ACRE_PRC343"] call acre_sys_core_fnc_removeGear;
[player] call acre_sys_core_fnc_getGear;

private _valid = false;

// Create a eventHandler to remove any magazines from newly equipped weapons aswell as remove magazines spawned by them.
private _newfirearmEH = [(primaryWeapon player), (handgunWeapon player), (secondaryWeapon player)] spawn
{
	params["_prevPrimary", "_prevHandgun", "_prevSecondary"];
	while {true} do
	{
		waitUntil{((primaryWeapon player) != _prevPrimary) or ((handgunWeapon player) != _prevHandgun) or ((secondaryWeapon player) != _prevSecondary)};

		if ((primaryWeapon player) != _prevPrimary) then
		{
			private _magazine = primaryWeaponMagazine player;
			{
				player removeMagazines _x;
				player removePrimaryWeaponItem _x;
			} forEach _magazine;
		};

		if ((handgunWeapon player) != _prevHandgun) then
		{
			private _magazine = handgunMagazine player;
			{
				player removeMagazines _x;
				player removeHandgunItem _x;
			} forEach _magazine;
		};

		if ((secondaryWeapon player) != _prevSecondary) then
		{
		private	_magazine = secondaryWeaponMagazine player;
			{
				player removeMagazines _x;
			} forEach _magazine;
		};
	};
};

// Main loop, opens the arsenal and validates wether or not the player loadout is valid upon exitting the arsenal.
while {!_valid} do
{
	// Open arsenal
	["Open",[nil, _arsenalObj, false]] call bis_fnc_arsenal;
	waitUntil { isnull ( uinamespace getvariable "RSCDisplayArsenal" ) };

	// Create arrays of player's selected loadout
	private _permittedGear 	= player getVariable ["EMF_KA_permittedGear", 0];
	private _weapons = [(primaryWeapon player), (handgunWeapon player), (secondaryWeapon player), (binocular player)];
	private _magazines = magazines player;
	private _items = ((items player) + [(uniform player)] + [(vest player)] + [(goggles player)] + [(hmd player)] + [(headGear player)] + (assignedItems player));
	private _backpack = backpack player;

	// Validate if the player's loadout is valid according to the whitelist
	private _loadoutValid = [true, ""];
	{
		if (typeName _x == "STRING") then
		{
			if (!(_x in (_permittedGear select 3) or _x == "")) exitWith {_loadoutValid = [false, /*getText(configfile >> "CfgWeapons" >> _x >> "displayName")*/_x];};
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

	// If the loadout was valid exit the current loop
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
};

// Remove the switchWeapon eventHandler
terminate _newfirearmEH;

// delete the arsenalLight
if (_arsenalLight) then
{
	deleteVehicle EMF_KA_LIGHT;
};

// Set EMF_KA_Done to true so that the player can't force open a arsenal again and delete the arsenal object
player setVariable ["EMF_KA_Done", true];
["AmmoboxExit", _arsenalObj] call BIS_fnc_arsenal;
//deleteVehicle _arsenalObj;

player setVariable ["EMF_KA_ArsenalObj", _arsenalObj];
true;
