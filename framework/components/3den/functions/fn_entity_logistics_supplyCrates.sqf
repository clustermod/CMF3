#include "script_component.hpp"
/*
 * Author: Eric
 * Generate standard resupply crates based on a loadout
 *
 * Arguments:
 * 0: Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_3den_fnc_supplyCrates
 *
 * Public: No
 */

params ["_path"];

/* Medical Crate Generator */
private _medCrate = {
    private _medical = ["MED"] call compile preprocessFileLineNumbers "rsc\loadouts\v2_usmc_1980.sqf";
    _medical params ["_version", "_loadout"];
    if (["1.3", _version] call EFUNC(utility,versionCompare) isEqualTo -1) exitWith { };

    /* Create crate */
    private _crate = create3DENEntity ["Object", "ACE_medicalSupplyCrate_advanced", screenToWorld [0.5, 0.5], true];

    /* Define base loadout */
    private _medCrateDef = [
        ["kat_IV_16", 10],
        ["kat_aatKit", 5],
        ["ACE_adenosine", 5],
        ["kat_amiodarone", 5],
        ["ACE_fieldDressing", 20],
        ["ACE_elasticBandage", 25],
        ["ACE_packingBandage", 30],
        ["ACE_quikclot", 15],
        ["kat_chestSeal", 10],
        ["ACE_epinephrine", 10],
        ["kat_IO_FAST", 5],
        ["kat_guedel", 5],
        ["kat_larynx", 10],
        ["kat_lidocaine", 5],
        ["ACE_morphine", 10],
        ["ACE_plasmaIV", 5],
        ["ACE_plasmaIV_500", 10],
        ["ACE_splint", 10],
        ["ACE_bodyBag", 10]
    ];

    /* Check if Medic has access to the base items */
    _loadout params ["_backpacks", "_vests", "_uniforms", "_facewear", "_headgear", "_attachments", "_magazines", "_weapons", "_items"];
    {
    	if ((_x select 0) in _items) then {
            clearItemCargoGlobal _crate;
            clearMagazineCargoGlobal _crate;
            clearWeaponCargoGlobal _crate;
            clearBackpackCargoGlobal _crate;

            _crate addItemCargoGlobal _x;
    	};
    } forEach _medCrateDef;

    /* save inventory and set custom name */
    _crate set3DENAttribute ["Init", "this setVariable [""ace_cargo_customName"", ""Medical Crate"", true];"];
    save3DENInventory [_crate];
};

/* Add menu actions */
[_path, "Create Medical Crate", "", _medCrate] call FUNC(addMenuItem);
