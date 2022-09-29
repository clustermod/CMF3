/*
 * Author: Eric
 * kosher arsenal for AI
 *
 * Arguments:
 * 0: side <SIDE>
 * 1: file <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [east, "exampleLoadout"] call emf_kosherArsenal_fnc_aiArsenal
 *
 * Public: Yes
 */
scriptName "functions\kosherArsenal\fn_aiArsenal.sqf";
params["_side", "_loadoutFile"];

missionNamespace setVariable ["emf_kosherai_enabled", true, true];
missionNamespace setVariable ["emf_kosherai_side", _side, true];
missionNamespace setVariable ["emf_kosherai_loadoutFile", _loadoutFile, true];

// Initialize preplaced units
{
  if (side _x isEqualTo _side) then {
    private _role = [_x] call emf_fnc_setAIType;
    private _whitelist = ([_role] call compile(preprocessFileLineNumbers format["rsc\loadouts\%1.sqf", _loadoutFile])) select 0;

    // strip unit
    [_x] call emf_utilities_fnc_stripUnit;

    // Randomize spawn loadout
    _x addBackpack (selectRandom (_whitelist select 0));
    _x addVest (selectRandom (_whitelist select 1));
    _x forceAddUniform (selectRandom (_whitelist select 2));
    _x addGoggles (selectRandom (_whitelist select 3));
    _x addHeadgear (selectRandom (_whitelist select 4));
    _x addWeapon (selectRandom (_whitelist select 7));

    for "_i" from 0 to 2 do {
    	_x addPrimaryWeaponItem (selectRandom (_whitelist select 5));
    };
    for "_i" from 0 to (random 6) do {
      _x addMagazineGlobal (selectRandom (_whitelist select 6));
    };

    if (_role == "MED") then {
      for "_i" from 0 to (random 30) do {
        _x addItem (selectRandom (_whitelist select 8));
      }
    } else {
      _x addItem "Medikit"; _x addItem "Medikit";
    };
    _x linkItem "ItemMap";
    _x linkItem "ItemCompass";
    _x linkItem "ItemWatch";
  };
} forEach allUnits;
