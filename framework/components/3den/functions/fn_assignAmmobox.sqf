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

    {
        private _oldInit = (_x get3DENAttribute "Init") select 0;
        private _newInit = toString {
            [this] call EFUNC(kosherArsenal,ammobox);
        };

        _x set3DENAttribute ["Init", _oldInit + endl + _newInit];
    } forEach get3DENSelected "object";

    ["Assigned selected objects as an kosher arsenal ammobox", 0, 1] call BIS_fnc_3DENNotification;
};

[_path, _name, _icon, _action] call cmf_3den_fnc_addMenuItem;
