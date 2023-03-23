#include "script_component.hpp"
/*
 * Author: Eric
 * Makes selected objects into simple objects.
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
 * [[_myToolsMenu], "Simplify Object"] call cmf_3den_fnc_simplifySelectedObject
 *
 * Public: No
 */
SCRIPT(simplifySelectedObject);

 params ["_path", "_name", [ "_icon", ""]];

private _action = {
    if (count get3DENSelected "object" == 0) exitWith {
        ["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
    };
    
    {
        _command = toString {
            this spawn {
                private _obj = createSimpleObject[(typeof _this), (getposASL _this), false];
                _obj setVectorDirAndUp [(vectorDir _this), (vectorUp _this)];
                deleteVehicle _this;
            };
        };

        if !([_x, _command] call FUNC(inInit)) then {            
            [_x, _command] call FUNC(addToInit);
            _x set3DENAttribute ["enableSimulation", false];
            _x set3DENAttribute ["allowDamage", false];
        } else {
            [_x, _command] call FUNC(removeFromInit);
            _x set3DENAttribute ["enableSimulation", true];
            _x set3DENAttribute ["allowDamage", true];
        };
    } forEach get3DENSelected "object";

    ["Toggled Simplified selected objects", 0, 1] call BIS_fnc_3DENNotification;
};

/* Create menu */
[_path, _name, _icon, _action] call FUNC(addMenuItem);
