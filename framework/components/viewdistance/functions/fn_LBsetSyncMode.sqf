#include "script_component.hpp"
/*
 * Author: Eric
 * Change syncmode from listbox control
 *
 * Arguments:
 * 0: Mode <NUMBER>
 * 1: Variable String <STRING>
 * 2: Textbox <CONTROL>
 * 3: Slider <CONTROL>
 * 4: Slider Textbox <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1, "foot", _myTextCtrl, _mySliderCtrl, _mySliderTextCtrl] call cmf_viewdistance_fnc_LBsetSyncMode
 *
 * Public: No
 */
SCRIPT(LBsetSyncMode);

private _mode = _this select 0;
private _varString = [_this, 1, "", [""]] call BIS_fnc_param;
private _textBoxCtrl = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
private _sliderCtrl = [_this, 3, controlNull, [0, controlNull]] call BIS_fnc_param;
private _sliderTextboxCtrl = [_this, 4, controlNull, [0, controlNull]] call BIS_fnc_param;

switch (_mode) do {
    case 1: {
        ctrlEnable [_textBoxCtrl, true];
        private _percentageVar = "cmf_viewdistance_" + _varString + "SyncPercentage";
        private _percentage = call compile _percentageVar;
        ctrlSetText [_textBoxCtrl, format ["%1",_percentage * 100] + "%"];

        private _viewDistVar = "cmf_viewdistance_" + _varString;
        private _viewDist = call compile _viewDistVar;
        private _objVDVar = "cmf_viewdistance_" + _varString + "Obj";
        private _objVD = _viewDist * _percentage min GVAR(maxObj);

        //disable VD slider and textbox because they are not in use
        ctrlEnable [_sliderCtrl, false];
        sliderSetPosition [_sliderCtrl, _objVD];
        ctrlEnable [_sliderTextboxCtrl, false];
        ctrlSetText [_sliderTextboxCtrl, str round _objVD];

        call compile format ["%1 = %2", _objVDVar, _objVD];
        call compile format ["profileNamespace setVariable ['%1',%1]", _objVDVar];
    };
    default {
        ctrlEnable [_textBoxCtrl, false];
        ctrlSetText [_textBoxCtrl, ""];

        /* enable VD slider and textbox in case they are disabled */
        ctrlEnable [_sliderCtrl, true];
        ctrlEnable [_sliderTextboxCtrl, true];
    };
};

private _modeVar = "cmf_viewdistance_" + _varString + "SyncMode";
call compile format ["%1 = %2", _modeVar, _mode];
call compile format ["profileNamespace setVariable ['%1',%1]", _modeVar];

[2] call FUNC(updateSettings);
