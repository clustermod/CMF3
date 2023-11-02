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

params ["_control"];

private _dialog = ctrlParent _control;
private _buttonIndex = ["INFANTRY", "VEHICLE", "AIR"];
private _oldCategory = _dialog getVariable [QGVAR(category), ""];
private _newCategory = _buttonIndex select ((ctrlIDC _control) - 600);

if (_oldCategory == _newCategory) exitWith {};

_dialog setVariable [QGVAR(category), _newCategory];

private _oldControl = (_dialog displayCtrl (600 + (_buttonIndex find _oldCategory)));
_oldControl ctrlSetBackgroundColor [0, 0, 0, 0.5];
_oldControl ctrlSetTextColor [1, 1, 1, 1];

_control ctrlSetBackgroundColor [1, 1, 1, 0.5];
_control ctrlSetTextColor [0, 0, 0, 1];

/* Update menu to new category */
private _updateSliders = {
    params ["_dialog", "_values"];

    (_dialog displayCtrl IDC_SLIDER_VIEWDISTANCE) sliderSetPosition (_values select 0);
    (_dialog displayCtrl IDC_SLIDER_OBJECTS) sliderSetPosition (_values select 1);
    (_dialog displayCtrl IDC_SLIDER_PIP) sliderSetPosition (_values select 2);
    (_dialog displayCtrl IDC_SLIDER_SHADOW) sliderSetPosition (_values select 3);
    (_dialog displayCtrl IDC_SLIDER_TERRAIN) sliderSetPosition (_values select 4);

    [(_dialog displayCtrl IDC_SLIDER_VIEWDISTANCE), (_values select 0)] call FUNC(updateSlider);
    [(_dialog displayCtrl IDC_SLIDER_OBJECTS), (_values select 1)] call FUNC(updateSlider);
    [(_dialog displayCtrl IDC_SLIDER_PIP), (_values select 2)] call FUNC(updateSlider);
    [(_dialog displayCtrl IDC_SLIDER_SHADOW), (_values select 3)] call FUNC(updateSlider);
    [(_dialog displayCtrl IDC_SLIDER_TERRAIN), (_values select 4)] call FUNC(updateSlider);
};

switch (_newCategory) do {
    case "INFANTRY": {
        private _infantry = profileNamespace getVariable ["cmf_viewdistance_infantry", [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
        [_dialog, _infantry] call _updateSliders;
    };
    case "VEHICLE": {
        private _vehicle = profileNamespace getVariable ["cmf_viewdistance_vehicle", [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
        [_dialog, _vehicle] call _updateSliders;
    };
    case "AIR": {
        private _air = profileNamespace getVariable ["cmf_viewdistance_air", [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
        [_dialog, _air] call _updateSliders;
    };
};