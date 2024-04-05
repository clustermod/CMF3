#include "script_component.hpp"
/*
 * Author: Eric
 * Updates viewdistance slider values
 * 
 * Arguments:
 * 0: Control <CONTROL>
 * 1: New Value <NUMBER>
 * 
 * Return Value:
 * Value <TYPE>
 * 
 * Example:
 * call cmf_viewdistance_fnc_updateSlider
 * 
 * Public: No
 */

params ["_control", "_newValue"];

private _dialog = ctrlParent _control;
private _category = _dialog getVariable [QGVAR(category), "INFANTRY"];

private ["_varName"];
switch (_category) do {
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

switch (ctrlIDC _control) do {
    case IDC_SLIDER_VIEWDISTANCE: {
        private _stepSize = 100;
        if ((_newValue >= 5000) && { _newValue <= 15000 }) then {
            _stepSize = 500;
        };

        if (_newValue >= 15000) then {
            _stepSize = 1000;
        };

        (_dialog displayCtrl IDC_LABEL_VIEWDISTANCE) ctrlSetText format ["View Distance: %1m", _newValue toFixed 0];
        (_dialog displayCtrl IDC_SLIDER_OBJECTS) sliderSetRange [100, _newValue];
        (_dialog displayCtrl IDC_SLIDER_PIP) sliderSetRange [100, _newValue];
        [(_dialog displayCtrl IDC_SLIDER_OBJECTS), sliderPosition (_dialog displayCtrl IDC_SLIDER_OBJECTS)] call FUNC(updateSlider);
        [(_dialog displayCtrl IDC_SLIDER_PIP), sliderPosition (_dialog displayCtrl IDC_SLIDER_PIP)] call FUNC(updateSlider);
        (_dialog displayCtrl IDC_SLIDER_VIEWDISTANCE) sliderSetSpeed [_stepSize, _stepSize, _stepSize];
        _savedValues set [0, _newValue];
    };
    case IDC_SLIDER_OBJECTS: {
        private _stepSize = 100;
        if ((_newValue >= 5000) && { _newValue <= 15000 }) then {
            _stepSize = 500;
        };

        if (_newValue >= 15000) then {
            _stepSize = 1000;
        };

        (_dialog displayCtrl IDC_LABEL_OBJECTS) ctrlSetText format ["Object View Distance: %1m", _newValue toFixed 0];
        (_dialog displayCtrl IDC_SLIDER_OBJECTS) sliderSetSpeed [_stepSize, _stepSize, _stepSize];
        _savedValues set [1, _newValue];
    };
    case IDC_SLIDER_PIP: {
        (_dialog displayCtrl IDC_LABEL_PIP) ctrlSetText format ["PIP View Distance: %1m", _newValue toFixed 0];
        _savedValues set [2, _newValue];
    };
    case IDC_SLIDER_SHADOW: {
        (_dialog displayCtrl IDC_LABEL_SHADOW) ctrlSetText format ["Shadow View Distance: %1m", _newValue toFixed 0];
        _savedValues set [3, _newValue];
    };
    case IDC_SLIDER_TERRAIN: {
        _newValue = [[3.125, 6.25, 12.5, 25], _newValue] call EFUNC(common,nearestNumber);
        _savedValues set [4, _newValue];
        (_dialog displayCtrl IDC_LABEL_TERRAIN) ctrlSetText format ["Terrain Grid: %1", _newValue toFixed 3];
        _control sliderSetPosition _newValue;
    };
};

profileNamespace setVariable [_varName, _savedValues];

// call FUNC(updateViewDistance);