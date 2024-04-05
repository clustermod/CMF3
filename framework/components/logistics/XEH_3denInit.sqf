#include "script_component.hpp"

waitUntil { !isNil QEGVAR(3den,menu_entity) };

private _path = EGVAR(3den,menu_entity);

private _crateLoadoutAction = [
    "Set Crate Loadout",
    "a3\ui_f\data\map\vehicleicons\iconcrateord_ca.paa",
    {
        if (count get3DENSelected "object" isEqualTo 0) exitWith {
            ["No units selected", 0, 1] call BIS_fnc_3DENNotification;
        };

        private _setLoadout = {
            params ["_values", "_crates"];

            private _path = format["rsc\loadouts\%1.sqf", (_values select 0)];
            if !(FILE_EXISTS(_path)) exitWith { ERROR_MSG_1("Unable to find preset: %1", (_values select 0)); };

            private _presets = [call compile preprocessFileLineNumbers _path] call CBA_fnc_hashCreate;
            private _preset = [_presets, (_values select 1)] call CBA_fnc_hashGet;
            private _presetData = [_preset] call FUNC(presetCompile);

            {
                [_x, _presetData] call FUNC(fillCrate);
            } forEach _crates;

            [format ["Set crate loadout for %1 objects.", count _crates], 0, 2] call BIS_fnc_3DENNotification;
        };

        ["Set Crate Loadout", [
            ["EDIT", ["Logistics File", "Logistics file to use"], [""]],
            ["EDIT", ["Crate type", "Type of create to make e.g. Fireteam, Medical etc. (case sensitive)"], [""]]
        ], _setLoadout, {}, (get3DENSelected "object") select { !(_x isKindOf "Man") }] call zen_dialog_fnc_create;
    }
];

[
    _path, 
    QUOTE(MODULE_BEAUTIFIED),
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa",
    {},
    [],
    [
        _crateLoadoutAction
    ]
] call EFUNC(3den,addMenuItem);