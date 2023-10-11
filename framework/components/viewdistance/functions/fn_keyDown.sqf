#include "script_component.hpp"
/*
 * Author: Eric
 * Handle increasing / decreasing viewdistance by hotkey
 *
 * Arguments:
 * 0: Update type (0: decrease, 1: increase) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [0] call cmf_viewdistance_fnc_keyDown
 *
 * Public: No
 */
SCRIPT(keyDown);

if (GVAR(keyDown)) exitWith {};
GVAR(keyDown) = true;

private ["_vehTypeString"];
private _updateType = [_this, 0, 0, [0]] call BIS_fnc_param;
private _updateValue = if (_updateType isEqualTo 0) then {-500} else {500};

if (!isNull (findDisplay 2900)) then {call FUNC(openDialog)};

switch (GVAR(vehType)) do {
    case 1: {
        _vehTypeString = "car";
    };
    case 2: {
        _vehTypeString = "air";
    };
    default {
        _vehTypeString = "foot";
    };
};

private _updateMode = call compile ("cmf_viewdistance_" + _vehTypeString + "SyncMode");
private _viewDistVar = "cmf_viewdistance_" + _vehTypeString;
private _viewDist = call compile _viewDistVar;
private _objViewDistVar = "cmf_viewdistance_" + _vehTypeString + "Obj";
private _objViewDist = call compile _objViewDistVar;
private _vdDiff = _viewDist - _objViewDist;

switch (_updateMode) do {
    case 1: {
        private _viewDistValue = _viewDist + _updateValue min GVAR(maxView) max 500;

        private _percentVar = "CHVD_" + _vehTypeString + "SyncPercentage";
        private _percentValue = call compile _percentVar;

        private _objViewDistValue = _viewDistValue * _percentValue min GVAR(maxObj);

        if (_objViewDistValue >= 500) then {
            call compile format ["%1 = %2", _viewDistVar, _viewDistValue];
            call compile format ["profileNamespace setVariable ['%1',%1]", _viewDistVar];
            call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
            call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];

            [3] call FUNC(updateSettings);
        };
    };
    case 2: {
        private _objViewDistValue = _objViewDist + _updateValue min _viewDist min GVAR(maxObj) max 500;
        call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];

        [4] call FUNC(updateSettings);
    };
    default {
        private _viewDistValue = _viewDist + _updateValue min GVAR(maxView) max (500 + _vdDiff);
        private _objViewDistValue = _objViewDist + _updateValue min (_viewDistValue - _vdDiff) min GVAR(maxObj) max 500;
        call compile format ["%1 = %2", _viewDistVar, _viewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _viewDistVar];

        call compile format ["%1 = %2", _objViewDistVar, _objViewDistValue];
        call compile format ["profileNamespace setVariable ['%1',%1]", _objViewDistVar];

        [3] call FUNC(updateSettings);
    };
};

private _vdString = "";
for "_i" from 1 to (35) step 1 do {
    if ((call compile _viewDistVar) < GVAR(maxView) / 35 * _i) then {
        _vdString = _vdString + "·";
    } else {
        _vdString = _vdString + "I";
    };
};

private _ovdString = "";
for "_i" from 1 to (35) step 1 do {
    if ((call compile _objViewDistVar) < GVAR(maxObj) / 35 * _i) then {
        _ovdString = _ovdString + "·";
    } else {
        _ovdString = _ovdString + "I";
    };
};

hintSilent parseText format [
    "<t align='left' size='1.33'>
        %2:	<t align='right'>%3</t> <br />
        <t size='2' shadow='0' color='%1'>%4</t> <br />
        %5: <t align='right'>%6</t> <br />
        <t size='2' shadow='0' color='%1'>%7</t>
    </t>",
    [
        profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843], profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019], profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862],
        profilenamespace getvariable ['GUI_BCG_RGB_A',0.7]
    ] call BIS_fnc_colorRGBAtoHTML, "View Distance", call compile _viewDistVar, _vdString, "View Distance", call compile _objViewDistVar, _ovdString
];

terminate (missionNamespace getVariable [QGVAR(hintHandle), scriptNull]);
GVAR(hintHandle) = [] spawn {
    uiSleep 2;
    hintSilent "";
};

[] spawn {
    uiSleep 0.05;
    GVAR(keyDown) = false;
};
