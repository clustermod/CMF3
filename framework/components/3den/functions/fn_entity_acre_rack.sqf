#include "script_component.hpp"
/*
 * Author: Eric
 * Adds a entry to add a radio rack and radio to selected vehicle in 3DEN
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
 * [[_myToolsMenu], "Add Radio Rack (ACRE)"] call cmf_3den_fnc_addRadioRack
 *
 * Public: No
 */
SCRIPT(addRadioRack);

params ["_path", "_name", [ "_icon", ""]];

private _action = {
    if (count get3DENSelected "object" == 0) exitWith {
        ["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
    };

    private _display3DEN = uiNamespace getVariable "Display3DEN";
    private _display = _display3DEN createDisplay "cmf_3den_addRack";

    /* Collect button controls */
    private _addCtrl = _display displayCtrl 1;
    private _radioCtrl = _display displayCtrl 100;

    /* Fill combobox with data */
    {
        private _index = _radioCtrl lbAdd ([(_x select 1) + "_ID_1"] call acre_api_fnc_getDisplayName);
        _radioCtrl lbSetData [_index, str _x];
    } forEach [["ACRE_VRC103", "ACRE_PRC117F"], ["ACRE_VRC64", "ACRE_PRC77"], ["ACRE_VRC110", "ACRE_PRC152"], ["ACRE_VRC111", "ACRE_PRC148"], ["ACRE_SEM90", "ACRE_SEM70"]];
    _radioCtrl lbSetSelected [1, true];

    /* Handle unit spawn */
    _addCtrl ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];

        private _display = ctrlParent _ctrl;
        private _vehicles = get3DENSelected "object";
        private _comboCtrl = _display displayCtrl 100;
        private _radio = call compile (_comboCtrl lbData (lbCurSel _comboCtrl));

        if (isNil "_radio") exitWith {
            ["You need to select a radio", 1, 1] call BIS_fnc_3DENNotification;
        };

        if (count _vehicles isEqualTo 0) exitWith {
            ["You need to select at least one object", 1, 1] call BIS_fnc_3DENNotification;
        };

        {
            private _oldInit = (_x get3DENAttribute "Init") select 0;
            private _newInit = format["[this, {[_this, [""%1"", ""Rack"", ""Rack"", false, [""crew""], [], ""%2"", [], []], true, {}], acre_api_fnc_addRackToVehicle}] remoteExec [""call"", 0, true];", (_radio select 0), (_radio select 1)];

            _x set3DENAttribute ["Init", _oldInit + _newInit];
        } forEach _vehicles;

        ["Added radio to vehicles", 0, 1] call BIS_fnc_3DENNotification;
    }];
};

[_path, _name, _icon, _action] call FUNC(addMenuItem);
