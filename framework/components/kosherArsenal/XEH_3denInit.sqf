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