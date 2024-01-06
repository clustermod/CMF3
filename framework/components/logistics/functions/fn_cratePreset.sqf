#include "script_component.hpp"
/*
 * Author: Eric
 * Loads logistics crate defines from given preset
 * 
 * Arguments:
 * 0: Preset name <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myLogistics"] call cmf_logistics_fnc_cratepreset
 * 
 * Public: Yes
 */
params ["_name"];

if (isNil "_name") exitWith { ERROR_MSG("No preset defined") };
private _path = format["rsc\loadouts\%1.sqf", _name];
if !(FILE_EXISTS(_path)) exitWith { ERROR_MSG_1("Unable to find preset: %1", _name); };

private _presets = [call compile preprocessFileLineNumbers _path] call CBA_fnc_hashCreate;
GVAR(crateConfig) = _presets;
publicVariable QGVAR(crateConfig);

{
    private _key = _x;
    private _preset = [_presets, _x] call CBA_fnc_hashGet;

    private _presetData = [_preset] call FUNC(presetCompile);

    /* Create amount tracker */
    private _crateHash = missionNamespace getVariable [QGVAR(crateHash), [] call CBA_fnc_hashCreate];
    private _newAmount = [_crateHash, _key, 0] call CBA_fnc_hashSet;
    GVAR(crateHash) = _newAmount;
    publicVariable QGVAR(crateHash);

    /* Using this method won't allow for using the same crate for different crates */
    [(_presetData select 1), "init", compile ("
        params ['_crate'];
        if (_crate getVariable ['ace_cargo_customName', ''] isEqualTo '') then {
            [_crate, 'ace_cargo_customName', '" + _key + " Crate | '] call CBA_fnc_setVarNet;
        };
        [_crate, true] call ace_dragging_fnc_setCarryable;
        [_crate, true] call ace_dragging_fnc_setDraggable;

        clearItemCargoGlobal _crate;
        clearMagazineCargoGlobal _crate;
        clearWeaponCargoGlobal _crate;
        clearBackpackCargoGlobal _crate;
        
        {_crate addWeaponCargoGlobal _x} forEach "+str(_presetData select 2)+";
        {_crate addMagazineCargoGlobal _x} forEach "+str(_presetData select 3)+";
        {_crate addItemCargoGlobal _x} forEach "+str(_presetData select 4)+";

        if (count "+str(_presetData select 5)+" > 0) then {
            private _cargoSpace = 0;
            {
                _cargoSpace = _cargoSpace + _x;
            } forEach ("+str(_presetData select 5)+" apply { ([_x select 0] call ace_cargo_fnc_getSizeItem) * (_x select 1) });
            [_crate, _cargoSpace] call ace_cargo_fnc_setSpace;
            {
                private _cargo = _x;
                for '_i' from 0 to (_cargo select 1) do {
                    [(_cargo select 0), _crate] call ace_cargo_fnc_loadItem;
                };
            } forEach "+str(_presetData select 5)+";
        };
    "), true, [], true] call CBA_fnc_addClassEventHandler;
} forEach ([_presets] call CBA_fnc_hashKeys);