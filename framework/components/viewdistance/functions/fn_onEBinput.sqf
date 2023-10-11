#include "script_component.hpp"
/*
 * Author: Eric
 * Get setting from GUI and update the viewdistance accordingly
 *
 * Arguments:
 * 0: Variable Type 1 <STRING>
 * 1: Slider 1 <CONTROL>
 * 2: Text 1 <CONTROL>
 * 3: Variable Type 2 <STRING>
 * 4: Slider 2 <CONTROL>
 * 5: Text 2 <CONTROL>
 * 6: Mode <STRING>
 * 7: Percent <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
SCRIPT(onEBinput);

private ["_updateType"];
private _varType1 = [_this, 0, "", [""]] call BIS_fnc_param;
private _slider1 = [_this, 1, controlNull, [0, controlNull]] call BIS_fnc_param;
private _text1 = [_this, 2, controlNull, [0, controlNull]] call BIS_fnc_param;
private _varType2 = [_this, 3, "", [""]] call BIS_fnc_param;
private _slider2 = [_this, 4, controlNull, [0, controlNull]] call BIS_fnc_param;
private _text2 = [_this, 5, controlNull, [0, controlNull]] call BIS_fnc_param;
private _modeVar = [_this, 6, "", [""]] call BIS_fnc_param;
private _percentVar = [_this, 7, "", [""]] call BIS_fnc_param;

if (count _this < 7) then {
    _updateType = 2;
} else {
    _modeVar = call compile _modeVar;
    switch (_modeVar) do {
        case 1: {
            _updateType = 3;
        };
        default {
            _updateType = 1;
        };
    };
};


private _textValue = [ctrlText _text1, "0123456789"] call BIS_fnc_filterString;
_textValue = if (_textValue == "") then {1} else {call compile _textValue min 12000 max 0};

/* Check if percentage sync mode is used, if so use a percentage coefficient */
private _viewDistValue = _textValue min GVAR(maxView);
private _objViewDistValue = if (_modeVar isEqualTo 1) then {_textValue  * (call compile _percentVar) min GVAR(maxObj)} else {_textValue min GVAR(maxObj)};

switch (_updateType) do {
    case 1: {
        sliderSetPosition [_slider1, _viewDistValue];
        sliderSetRange [_slider2, 0, _viewDistValue];

        call compile format ["%1 = %2", _varType1, _viewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

        /* Update object VD slider and text so it doesn't stay at higher value than VD slider */
        if ((call compile _varType2) > _viewDistValue) then {
            sliderSetPosition [_slider2, _objViewDistValue];
            ctrlSetText [_text2, str round _objViewDistValue];

            call compile format ["%1 = %2", _varType2, _objViewDistValue];
            call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
        };

        [_updateType] call FUNC(updateSettings);
    };
    case 2: {
        sliderSetPosition [_slider1, _objViewDistValue];

        call compile format ["%1 = %2", _varType1, _objViewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

        [_updateType] call FUNC(updateSettings);
    };
    case 3: {
        sliderSetPosition [_slider1, _viewDistValue];
        sliderSetRange [_slider2, 0, _viewDistValue];

        call compile format ["%1 = %2", _varType1, _viewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

        /* Update object VD slider and text so it doesn't stay at higher value than VD slider */
        if ((call compile _varType2) > _viewDistValue) then {
            sliderSetPosition [_slider2, _objViewDistValue];
            ctrlSetText [_text2, str round _objViewDistValue];

            call compile format ["%1 = %2", _varType2, _objViewDistValue];
            call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];
        };

        sliderSetPosition [_slider2, _objViewDistValue];
        ctrlSetText [_text2, str round _objViewDistValue];

        call compile format ["%1 = %2", _varType2, _objViewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _varType2];

        [_updateType] call FUNC(updateSettings);
    };
};
