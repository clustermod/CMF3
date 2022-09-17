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
 * [east, "exampleLoadout"] call emf_kosherArsenal_fnc_kosherAI
 *
 * Public: Yes
 */
SCRIPT(kosherAI);
params["_side", "_loadoutFile"];

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
    _unit addWeapon (selectRandom (_whitelist select 7));

    /* Add random weapon attachments if they are available */
    for "_i" from 0 to 2 do {
        _unit addPrimaryWeaponItem (selectRandom (_whitelist select 5));
    };

    /* Add random magazines (this also adds grenades) */
    for "_i" from 0 to (random 6) do {
        _unit addMagazineGlobal (selectRandom (_whitelist select 6));
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
            if (side _x isEqualTo _side && !(_x getVariable [QGVAR(kosherai_initialized), false])) then {
                /* Get unit's role */
                private _role = [_x] call _fnc_aiType;

                /* Get the loadout file */
                private _whitelist = ([_role] call compile(preprocessFileLineNumbers format["rsc\loadouts\%1.sqf", _loadoutFile])) select 1;

                /* Set the unit's loadout */
                [_x, _role, _whitelist] call _fnc_setLoadout;
                _x setVariable [QGVAR(kosherai_initialized), true];
            };
            sleep 0.03;
        } forEach allUnits;
        sleep 1;
    };
};
