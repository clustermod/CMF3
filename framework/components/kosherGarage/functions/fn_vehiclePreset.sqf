#include "script_component.hpp"
/*
 * Author: Eric
 * Parses vehicle preset
 * 
 * Arguments:
 * 0: Preset <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myPreset"] call cmf_kosherGarage_fnc_vehiclePreset
 * 
 * Public: Yes
 */
params ["_preset"];

if (isNil QGVAR(vehiclePresets)) then {
    GVAR(vehiclePresets) = [] call CBA_fnc_hashCreate;
};

_preset = call compile preprocessFileLineNumbers format ["rsc\loadouts\%1.sqf", _preset];

{
    _x params [["_key", ""], ["_value", []]];

    GVAR(vehiclePresets) = [GVAR(vehiclePresets), _key, _value] call CBA_fnc_hashSet;
} forEach _preset;