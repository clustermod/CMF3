#include "script_component.hpp"
/*
 * Author: Eric
 * Fills crate with passed cargo
 * 
 * Arguments:
 * 0: Crate <OBJECT>
 * 1: Cargo Preset <ARRAY>
 * 	- 0: Empty <NIL>
 *	- 1: Empty <NIL>
 *	- 2: weapons <ARRAY>
 *	- 3: magazines <ARRAY>
 *	- 4: items <ARRAY>
 *	- 5: ace cargo <ARRAY>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [this, _myPreset] call cmf_logistics_fnc_fillCrate
 * 
 * Public: Yes
 */
params ["_crate", "_cargoPreset"];

if is3DEN exitWith {
    private _equipment = [
        [
            [(_cargoPreset select 4) apply { _x select 0 }, (_cargoPreset select 4) apply { _x select 1 }],
            [(_cargoPreset select 3) apply { _x select 0 }, (_cargoPreset select 3) apply { _x select 1 }],
            [(_cargoPreset select 2) apply { _x select 0 }, (_cargoPreset select 2) apply { _x select 1 }],
            [[],[]] // Backpacks
        ], 
        false
    ];

    _crate set3DENAttribute ["ammoBox", str _equipment];
};

if (!isServer && { !local _crate }) exitWith {};

clearItemCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

{_crate addWeaponCargoGlobal _x} forEach (_cargoPreset select 2);
{_crate addMagazineCargoGlobal _x} forEach (_cargoPreset select 3);
{_crate addItemCargoGlobal _x} forEach (_cargoPreset select 4);

if (count (_cargoPreset select 5) > 0) then {
    private _cargoSpace = 0;
    {
        _cargoSpace = _cargoSpace + _x;
    } forEach ((_cargoPreset select 5) apply { ([_x select 0] call ace_cargo_fnc_getSizeItem) * (_x select 1) });
    [_crate, _cargoSpace] call ace_cargo_fnc_setSpace;
    {
        private _cargo = _x;
        for '_i' from 0 to (_cargo select 1) do {
            [(_cargo select 0), _crate] call ace_cargo_fnc_loadItem;
        };
    } forEach (_cargoPreset select 5);
};