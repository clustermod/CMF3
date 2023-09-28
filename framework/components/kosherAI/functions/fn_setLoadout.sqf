#include "script_component.hpp"
/*
 * Author: Eric
 * Set's randomized loadout on AI from loadoutfile
 * 
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Role <STRING>
 * 2: Whitelist <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [_unit, "SL", _myLoadoutFile] call cmf_kosherAI_fnc_setLoadout
 * 
 * Public: No
 */

params["_unit", "_role", "_whitelist"];

/* Strip unit naked */
[_unit] call EFUNC(utility,stripUnit);

/* Randomize the loadout they get based on the available items */
_unit addBackpack (selectRandom (_whitelist select 0));
_unit addVest (selectRandom (_whitelist select 1));
_unit forceAddUniform (selectRandom (_whitelist select 2));
_unit addGoggles (selectRandom (_whitelist select 3));
_unit addHeadgear (selectRandom (_whitelist select 4));

/* Add random weapons for each slot */
private _primaries = (_whitelist select 7) select { getNumber (configFile >> "CfgWeapons" >> _x >> "type") isEqualTo 1 };
private _secondaries = (_whitelist select 7) select { getNumber (configFile >> "CfgWeapons" >> _x >> "type") isEqualTo 4 };
private _handguns = (_whitelist select 7) select { getNumber (configFile >> "CfgWeapons" >> _x >> "type") isEqualTo 2 };
private _primary = selectRandom _primaries;
private _secondary = selectRandom _secondaries;
private _handgun = selectRandom _handguns;

/* Seperate grenades from magazines */
private _grenades = (_whitelist select 6) select { _x call BIS_fnc_isThrowable };
private _magazines = (_whitelist select 6) select { !(_x call BIS_fnc_isThrowable) };

if (!isNil "_primary") then {
	[_unit, _primary] remoteExec ["addWeapon", _unit];

	if (_primary != primaryWeapon _unit) then {
		[_unit, _primary] remoteExec ["addWeapon", _unit];
		WARNING("Failed to add primary weapon on unit");
	};

	private _primaryMagazines = _magazines select { _x in (compatibleMagazines _primary) };
	for "_i" from 0 to round (random 5) do {
		_unit addMagazineGlobal selectRandom _primaryMagazines;
	};
};

if (!isNil "_secondary") then {
	[_unit, _secondary] remoteExec ["addWeapon", _unit];

	if (_secondary != secondaryWeapon _unit) then {
		[_unit, _secondary] remoteExec ["addWeapon", _unit];
		WARNING("Failed to add secondary weapon on unit");
	};

	private _secondaryMagazines = _magazines select { _x in (compatibleMagazines _secondary) };
	for "_i" from 0 to round (random 4) do {
		_unit addMagazineGlobal selectRandom _secondaryMagazines;
	};
};

if (!isNil "_handgun") then {
	[_unit, _handgun] remoteExec ["addWeapon", _unit];

	if (_handgun != handgunWeapon _unit) then {
		[_unit, _handgun] remoteExec ["addWeapon", _unit];
		WARNING("Failed to add handgun weapon on unit");
	};

	private _handgunMagazines = _magazines select { _x in (compatibleMagazines _handgun) };
	for "_i" from 0 to round (random 2) do {
		_unit addMagazineGlobal selectRandom _handgunMagazines;
	};
};

/* Add random weapon attachments if they are available */
for "_i" from 0 to 2 do {
	_unit addPrimaryWeaponItem (selectRandom (_whitelist select 5));
};

/* Add grenades */
for "_i" from 0 to round (random 3) do {
	_unit addMagazineGlobal selectRandom _grenades;
};

/* Add Explosives */
private _compatibleMagazines = (compatibleMagazines primaryWeapon _unit) + (compatibleMagazines handgunWeapon _unit) + (compatibleMagazines secondaryWeapon _unit);
private _explosives = _magazines select { !(_x in _compatibleMagazines) };
for "_i" from 0 to round (random 2) do {
	_unit addMagazineGlobal selectRandom _explosives;
};

/* Add medical equipment */
if (_role == "MED") then {
	for "_i" from 0 to (random 30) do {
		_unit addItem (selectRandom (_whitelist select 8));
	}
} else {
	_unit addItem "Medikit"; _unit addItem "Medikit";
};

/* Add basic shit */
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";

/* Force Ai to use primary after loadout has been set */
if (primaryweapon _unit != "") then {
	_unit selectweapon primaryWeapon _unit;
};