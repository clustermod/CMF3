#include "script_component.hpp"

waitUntil { !isNil QEGVAR(3den,menu_entity) };

private _path = EGVAR(3den,menu_entity);

private _ammoBoxAction = [
    LSTRING(3den_ammobox_displayName),
    "a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
    {
        if (count get3DENSelected "object" isEqualTo 0) exitWith {
            ["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
        };

        private _command = toString {[this] call FUNC(ammobox)};
        {
            if !([_x, _command] call EFUNC(3den,inInit)) then {
                [_x, _command] call EFUNC(3den,addToInit);
            } else {
                [_x, _command] call EFUNC(3den,removeFromInit);
            };
        } forEach get3DENSelected "object";

        ["Toggled selected objects as kosher arsenal ammoboxes", 0, 1] call BIS_fnc_3DENNotification;
    }
];

[
    _path, 
    "Kosher Arsenal",
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa",
    {},
    [],
    [
        _ammoBoxAction
    ]
] call EFUNC(3den,addMenuItem);

private _randomLoadoutAction = [
    "Set Random Loadout",
    "a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa",
    {
        if (count get3DENSelected "object" isEqualTo 0) exitWith {
            ["No units selected", 0, 1] call BIS_fnc_3DENNotification;
        };

        private _randomizeLoadout = {
            params ["_values", "_units"];

            private _loadout = format["rsc\loadouts\%1.sqf", _values select 1];
            if !(FILE_EXISTS(_loadout)) exitWith { ERROR_MSG_1("Unable to find loadoutfile: %1", _loadout) };
            private _whitelist = [_values select 0, player, true] call compile(preprocessFileLineNumbers _loadout);

            {
                [_x, _values select 0, _whitelist select 1] call EFUNC(kosherAI,setLoadout);
                save3DENInventory [_x];
            } forEach _units;

            [format ["Set random loadout for %1 units.", count _units], 0, 1] call BIS_fnc_3DENNotification;
        };

        ["Set Random Loadout", [
            ["EDIT", ["Role", "Role to set unit as"], ["RFL"]],
            ["EDIT", ["Loadoutfile", "Loadoutfile to use"], [""]]
        ], _randomizeLoadout, {}, (get3DENSelected "object") select { _x isKindOf "Man" }] call zen_dialog_fnc_create;

    }
];

[
    _path, 
    QUOTE(MODULE_BEAUTIFIED),
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa",
    {},
    [],
    [
        _ammoBoxAction,
        _randomLoadoutAction
    ]
] call EFUNC(3den,addMenuItem);