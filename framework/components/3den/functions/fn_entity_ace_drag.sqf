#include "script_component.hpp"
/*
 * Author: Eric
 * Toggle ACE draggable property on selected objects
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
 * [[_myToolsMenu], "Toggle Carryable"] call cmf_3den_fnc_ace_drag
 *
 * Public: No
 */

 params ["_path", "_name", [ "_icon", ""]];

private _action = {
    if (count get3DENSelected "object" == 0) exitWith {
        ["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
    };

    private _enableCommand = "[this, true] call ace_dragging_fnc_setDraggable";
    private _disableCommand = "[this, fales] call ace_dragging_fnc_setDraggable";
    
    private _selections = get3DENSelected "object";
    private _first = (_selections) select 0;
    private _isSet = ([_first, _enableCommand] call FUNC(inInit) || [_first, _disableCommand] call FUNC(inInit));
    private _toggle = ([_first, _enableCommand] call FUNC(inInit) || !_isSet);

    {
        if (_toggle) then {
            if ([_x, _disableCommand] call FUNC(inInit)) then {
                [_x, _disableCommand] call FUNC(removeFromInit);
            };

            [_x, _enableCommand] call FUNC(addToInit);
        } else {
            if ([_x, _enableCommand] call FUNC(inInit)) then {
                [_x, _enableCommand] call FUNC(removeFromInit);
            };

            [_x, _disableCommand] call FUNC(addToInit);
        };
    } forEach _selections;

    private _statusText = format ["%1 Dragging for %2 object(s)", ["Disabled", "Enabled"] select _toggle, count _selections];
    [_statusText, 0, 1] call BIS_fnc_3DENNotification;
};

/* Create menu */
[_path, _name, _icon, _action] call FUNC(addMenuItem);
