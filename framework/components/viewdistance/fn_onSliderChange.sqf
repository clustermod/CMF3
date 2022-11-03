#include "script_component.hpp"
/*
 * Author: Eric
 * Get settings from GUI and update viewdistance
 *
 * Arguments:
 * 0: Variable Type 1 <STRING>
 * 1: Slider 1 <CONTROL>
 * 2: Slider Position <NUMBER>
 * 3: Text 1 <CONTROL>
 * 4: Variable Type 2 <STRING>
 * 5: Slider 2 <CONTROL>
 * 6: Text 2 <CONTROL>
 * 7: Mode <STRING>
 * 8: Percent <STRING>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
SCRIPT(onSliderChange);

private ["_sliderPos","_updateType"];
private _varType1 = [_this, 0, "", [""]] call BIS_fnc_param;
private _slider1 = ctrlIDC ([_this, 1, 0, [0, controlNull]] call BIS_fnc_param);
_sliderPos = [_this, 2, 0, [0]] call BIS_fnc_param;
private _text1 = [_this, 3, 0, [0, controlNull]] call BIS_fnc_param;
private _varType2 = [_this, 4, "", [""]] call BIS_fnc_param;
private _slider2 = [_this, 5, 0, [0, controlNull]] call BIS_fnc_param;
private _text2 = [_this, 6, 0, [0, controlNull]] call BIS_fnc_param;
private _modeVar = [_this, 7, "", [""]] call BIS_fnc_param;
private _percentVar = [_this, 8, "", [""]] call BIS_fnc_param;

if (count _this < 8) then {
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

/* Check if percentage sync mode is used, if so use a percentage coefficient */
private _viewDistValue = _sliderPos min GVAR(maxView) max 0;
private _objViewDistValue = if (_modeVar isEqualTo 1) then {_sliderPos  * (call compile _percentVar) min GVAR(maxObj)} else {_sliderPos min GVAR(maxObj)};

switch (_updateType) do {
	case 1: {
		sliderSetPosition [_slider1, _viewDistValue];
		ctrlSetText [_text1, str round _viewDistValue];
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
		ctrlSetText [_text1, str round _objViewDistValue];

		call compile format ["%1 = %2", _varType1, _objViewDistValue];
		call compile format ["profileNamespace setVariable ['%1',%1]", _varType1];

		[_updateType] call FUNC(updateSettings);
	};
	case 3: {
		sliderSetPosition [_slider1, _viewDistValue];
		ctrlSetText [_text1, str round _viewDistValue];
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
