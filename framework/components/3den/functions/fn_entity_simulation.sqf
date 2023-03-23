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
 * [[_myToolsMenu], "Toggle 3DEN simulation"] call cmf_3den_fnc_entity_simulation
 *
 * Public: No
 */
SCRIPT(entity_simulation);

 params ["_path", "_name", [ "_icon", ""]];

private _action = {
    if (count get3DENSelected "object" == 0) exitWith {
        ["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
    };
    
    private _selections = get3DENSelected "object";
    private _first = (_selections) select 0;
    private _toggle = (simulationEnabled _first);

    {
        _x enableSimulation _toggle;
    } forEach _selections;

    private _statusText = format ["%1 3DEN Simulation for %2 object(s)", ["Disabled", "Enabled"] select _toggle, count _selections];
    [_statusText, 0, 1] call BIS_fnc_3DENNotification;
};

/* Create menu */
[_path, _name, _icon, _action] call FUNC(addMenuItem);
