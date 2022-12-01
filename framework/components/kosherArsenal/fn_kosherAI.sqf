#include "script_component.hpp"
/*
 * Author: Eric
 * Allows using kosherArsenal files with ai units
 *
 * Arguments:
 * 0: side <SIDE>
 * 1: file <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [east, "exampleLoadout"] call cmf_kosherArsenal_fnc_kosherAI
 *
 * Public: Yes
 */
SCRIPT(kosherAI);

params ["_side", "_loadoutFile"];

if (!isServer) exitWith {};

/* Function to set an ai unit's role */
private _fnc_aiType = {
    params["_unit"];
    /* Squad Leader */
    if ((leader _unit) isEqualTo _unit) exitWith {_unit setVariable[QGVAR(kosherai_role), "SL"]; "SL"};

    /* Medic */
    if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant") isEqualTo 1) exitWith {_unit setVariable[QGVAR(kosherai_role), "MED"]; "MED"};

    /* Engineer */
    if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "engineer") isEqualTo 1) exitWith {_unit setVariable[QGVAR(kosherai_role), "ENG"]; "ENG"};

    /* Anti-tank */
    if ((secondaryWeapon _unit) != "") exitWith {_unit setVariable[QGVAR(kosherai_role), "AT"]; "AT"};

    /* Machinegunner */
    if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "MachineGun") exitWith {_unit setVariable[QGVAR(kosherai_role), "MG"]; "MG"};

    /* Sniper */
    if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "SniperRifle") exitWith {_unit setVariable[QGVAR(kosherai_role), "MAR"]; "MAR"};

    /* Rifleman */
    _unit setVariable[QGVAR(kosherai_role), "RFL"]; "RFL"
};

/* Function to set a units loadout */
private _fnc_setLoadout = {
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

    _unit addWeapon selectRandom _primaries;
    _unit addWeapon selectRandom _secondaries;
    _unit addWeapon selectRandom _handguns;

    /* Add random weapon attachments if they are available */
    for "_i" from 0 to 2 do {
        _unit addPrimaryWeaponItem (selectRandom (_whitelist select 5));
    };

    /* Only get magazines that are compatible with selected weapons */
    private _compatibleMagazines = (compatibleMagazines primaryWeapon _unit) + (compatibleMagazines handgunWeapon _unit) + (compatibleMagazines secondaryWeapon _unit);

    /* Add random magazines, grenades and explosives (no way to check for explosives unfortunatly) */
    private _grenades = (_whitelist select 6) select { _x call BIS_fnc_isThrowable };
    private _magazines = (_whitelist select 6) select { !(_x call BIS_fnc_isThrowable) };
    private _explosives = _magazines select { !(_x in _compatibleMagazines) };
    _magazines = _magazines select { _x in _compatibleMagazines };

    for "_i" from 0 to round (random 5) do {
        _unit addMagazineGlobal selectRandom _magazines;
    };

    for "_i" from 0 to round (random 3) do {
        _unit addMagazineGlobal selectRandom _grenades;
    };

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
};

/* loop over all units and add to non-initialized units */
[_side, _loadoutFile, _fnc_aiType, _fnc_setLoadout] spawn {
    params ["_side", "_loadoutFile", "_fnc_aiType", "_fnc_setLoadout"];
    while { missionNamespace getVariable [QGVAR(kosherai_disable), true] } do {
        {
            if (side _x isEqualTo _side && !isPlayer _x && !(_x getVariable [QGVAR(kosherai_initialized), false])) then {
                /* Get unit's role */
                private _role = [_x] call _fnc_aiType;

                /* Get the loadout file */
                private _whitelist = ([_role] call compile(preprocessFileLineNumbers format["rsc\loadouts\%1.sqf", _loadoutFile])) select 1;

                /* Set the unit's loadout */
                [_x, _role, _whitelist] spawn _fnc_setLoadout;
                _x setVariable [QGVAR(kosherai_initialized), true];

                /* Raise event */
                [QGVAR(kosherai_onEnabled), [_x, _role]] call CBA_fnc_globalEvent;
            };
            sleep 0.03;
        } forEach allUnits;
        sleep 1;
    };
};