#include "script_component.hpp"
/*
 * Author: Eric
 * Change syncmode
 *
 * Arguments:
 * 0: Textbox <CONTROL>
 * 1: Variable String <STRING>
 * 2: Slider <CONTROL>
 * 3: Slider Textbox <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myTextCtrl, "foot", _mySliderCtrl, _mySliderTextCtrl] call cmf_viewdistance_fnc_setInputSyncmode
 *
 * Public: No
 */
SCRIPT(setInputSyncmode);

private _textBoxCtrl = [_this, 0, controlNull, [0, controlNull]] call BIS_fnc_param;
private _varString = [_this, 1, "", [""]] call BIS_fnc_param; // type of variable to use: foot/car/air
private _sliderCtrl = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
private _sliderTextboxCtrl = [_this, 3, controlNull, [0, controlNull]] call BIS_fnc_param;

private _inputValue = [ctrlText _textBoxCtrl, "0123456789"] call BIS_fnc_filterString;
private _inputValue = if (_inputValue == "") then {1} else {call compile _inputValue min 100 max 1};

ctrlSetText [_textBoxCtrl, (str _inputValue + "%")];

private _percentageVar = "cmf_viewdistance_" + _varString + "SyncPercentage";
private _percentage = _inputValue / 100;
call compile format ["%1 = %2", _percentageVar, _percentage];
call compile format ["profileNamespace setVariable ['%1',%1]", _percentageVar];

private _viewDistVar = "cmf_viewdistance_" + _varString;
private _viewDist = call compile _viewDistVar;
private _objVDVar = "cmf_viewdistance_" + _varString + "Obj";
private _objVD = _viewDist * _percentage min GVAR(maxObj);

sliderSetPosition [_sliderCtrl, _objVD];
ctrlSetText [_sliderTextboxCtrl, str round _objVD];

call compile format ["%1 = %2", _objVDVar, _objVD];
call compile format ["profileNamespace setVariable ['%1',%1]", _objVDVar];

[2] call FUNC(updateSettings);
