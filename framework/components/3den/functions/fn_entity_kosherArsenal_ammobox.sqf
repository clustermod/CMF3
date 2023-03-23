#include "script_component.hpp"
/*
 * Author: Eric
 * Assigns selected 3den objects as kosher arsenal ammoboxes.
 *
 * Arguments:
 * 0: Path <ARRAY>
 * 1: Name <STRING>
 * 2: Icon <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_myToolsMenu], "Assign Ammobox"] call cmf_3den_fnc_assignAmmobox
 *
 * Public: No
 */
SCRIPT(assignAmmobox);

params ["_path", "_name", [ "_icon", ""]];

private _action = {
    if (count get3DENSelected "object" == 0) exitWith {
        ["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
    };

    private _command = toString {[this] call EFUNC(kosherArsenal,ammobox)};
    {
        if !([_x, _command] call FUNC(inInit)) then {            
            [_x, _command] call FUNC(addToInit);
        } else {
            [_x, _command] call FUNC(removeFromInit);
        };
    } forEach get3DENSelected "object";

    ["Toggled selected objects as kosher arsenal ammoboxes", 0, 1] call BIS_fnc_3DENNotification;
};

[_path, _name, _icon, _action] call FUNC(addMenuItem);
