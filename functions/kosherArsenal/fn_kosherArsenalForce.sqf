/*
 * Author: Eric
 * Forces the spawn arsenal on a player to allow changing all gear within a whitelist
 *
 * Arguments:
 * 0: obj <OBJECT>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [this] call EMF_fnc_kosherArsenalForce
 *
 * public: Yes
*/

params["_obj"];

// Check if params are set and is of correct type
if (isNil "_obj") exitWith {  ['Object is not set'] call BIS_fnc_error; 'Object is not set' call BIS_fnc_log; false;};
if (typeName _obj != "OBJECT") exitWith {  ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_error; ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_log; false;};

EMF_arsenalFunc =
{
	[] spawn
		{
		// Get arsenal object
		private _arsenalObj = player getVariable ["EMF_KA_ArsenalObj", objNull];

		private _valid = false;

		// Create a eventHandler to remove any magazines from newly equipped weapons aswell as remove magazines spawned by them.
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

		// Set EMF_KA_Done to true so that the player can't force open a arsenal again and delete the arsenal object
		player setVariable ["EMF_KA_Done", true];
		["AmmoboxExit", _arsenalObj] call BIS_fnc_arsenal;
	};
};

remoteExecCall ["EMF_arsenalFunc", _obj];
true;
