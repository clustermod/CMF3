#include "script_component.hpp"
/*
 * Author: [Authors]
 * [Description]
 * 
 * Arguments:
 * 0: Argument <TYPE>
 * 
 * Return Value:
 * Value <TYPE>
 * 
 * Example:
 * [] call cmf_[module]_fnc_[functionName]
 * 
 * Public: [yes/no]
 */

params ["_value"];

private _vehicle = missionNamespace getVariable [QGVAR(vehicleType), "INFANTRY"];

private ["_varName"];
switch (_vehicle) do {
    case "INFANTRY": {
        _varName = QGVAR(infantry);
    };
    case "VEHICLE": {
        _varName = QGVAR(vehicle);
    };
    case "AIR": {
        _varName = QGVAR(air);
    };
};

private _savedValues = profileNamespace getVariable [_varName, [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
private _newView = (((_savedValues select 0) + _value) max 200) min 40000;
_savedValues set [0, _newView];

private _newObject = (((_savedValues select 1) + _value) max 200) min 40000;
_savedValues set [1, _newObject];

profileNamespace setVariable [_varName, _savedValues];

if (_value >= 0) then {
    [format ["Increased View Distance to: %1m", _newView toFixed 0]] call ACE_common_fnc_displayText;
} else {
    [format ["Decreased View Distance to: %1m", _newView toFixed 0]] call ACE_common_fnc_displayText;
};

[] call FUNC(updateViewDistance);