#include "script_component.hpp"

waitUntil { !isNil QEGVAR(3den,menu_entity) };

private _path = EGVAR(3den,menu_entity);

private _nameVehicle = [
    "Rename Vehicle",
    "a3\ui_f_curator\data\rsccommon\rscattributerespawnposition\guer_ca.paa",
    {
        ["Settings", [["EDIT", ["Vehicle Name", "What to name the vehicle."], [""]]], {
            (_this select 0) params [["_name", ""]];

            {
                private _init = _x get3DENAttribute ["Init", ""];
                _init = (_init select 0) splitString endl;

                private _lineIndex = _init findIf { "ace_cargo_customName" in toLower _x };

                if (_name isEqualTo "") exitWith {
                    _init deleteAt _lineIndex;
                    ["Removed Custom Name", 0, 1] call BIS_fnc_3DENNotification;
                };

                if (_lineIndex > -1) then {
                    _init set [_lineIndex, _init regexReplace ['(\["ace_cargo_customName", ").*?("\])', _name]]
                } else {
                    _init append format ["this setVariable [""ace_cargo_customName"", %1];", _name];
                };

                _x set3DENAttribute ["Init", _init joinString endl];
                ["Set Custom Name", 0, 1] call BIS_fnc_3DENNotification;
            } forEach get3DENSelected "Object";

        }, {}, []] call zen_dialog_fnc_create;
    }
];

[
    _path,
    QUOTE(MODULE_BEAUTIFIED),
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa",
    {},
    [],
    [
        _nameVehicle
    ]
] call EFUNC(3den,addMenuItem);