#include "script_component.hpp"
/*
 * Author: Eric
 * Displays a notification
 *
 * Arguments:
 * 0: Text <ANY>
 * 1: Size of the textbox <NUMBER> (default: 1.5)
 * 2: Target Unit. Will only display if target is the player controlled object <OBJECT> (default: cmf_player)
 * 3: Custom Width <NUMBER> (default: 10)
 *
 * Return Value:
 * None
 *
 * Example:
 * [["Test: %1", 123], 1.5] call cmf_common_fnc_notification
 * ["wow", 1, cmf_player, 3] call cmf_common_fnc_notification
 *
 * Public: Yes
 */
params [["_text",""], ["_color", GVAR(notificationColors) get "DEFAULT"], ["_speed", 4], ["_displaySide", "right"]];

if (isDedicated || !hasInterface) exitWith {};
if(isNil QGVAR(notifications)) then {
    GVAR(notifications) = [];
};

disableSerialization;
private _display = findDisplay 46;

if (_text isEqualType "") then {
    _text = parseText _text;
};

private _height = 0.01;
private _posX = 0;
private _posY = 0;

if(_displaySide isEqualTo "left") then {
    _posX = NOTIFICATION_M + safeZoneX;
} else {
    _posX = safeZoneW + safeZoneX - NOTIFICATION_M - NOTIFICATION_W;
};

private _borderCtrl = _display ctrlCreate ["RscText", -1];
private _textCtrl = _display ctrlCreate ["RscStructuredText", -1];

_borderCtrl ctrlSetPosition [_posX, _posY, NOTIFICATION_BORDER_W, _height];
_borderCtrl ctrlSetBackgroundColor _color;
_borderCtrl ctrlSetFade 1;
_borderCtrl ctrlCommit 0;
_borderCtrl ctrlSetFade 0;
_borderCtrl ctrlCommit 0.4;

_textCtrl ctrlSetStructuredText _text;
_textCtrl ctrlSetPosition [(_posX + NOTIFICATION_BORDER_W), _posY, NOTIFICATION_W - NOTIFICATION_BORDER_W, _height];
_adjustedHeight = (ctrlTextHeight _textCtrl);
_textCtrl ctrlSetPosition [(_posX + NOTIFICATION_BORDER_W), _posY, NOTIFICATION_W - NOTIFICATION_BORDER_W, _adjustedHeight];
_textCtrl ctrlCommit 0;
_borderCtrl ctrlSetPosition [_posX, _posY, NOTIFICATION_BORDER_W, _adjustedHeight];
_borderCtrl ctrlCommit 0;
_textCtrl ctrlSetBackgroundColor [0.129,0.129,0.129, 0.129];
_textCtrl ctrlSetFade 1;
_textCtrl ctrlCommit 0;
_textCtrl ctrlSetFade 0;
_textCtrl ctrlCommit 0.4;

[{
    disableSerialization;
    {
        _x ctrlSetFade 1;
        _x ctrlCommit 0.3;
    } forEach _this;
}, [_textCtrl, _borderCtrl], _speed] call CBA_fnc_waitAndExecute;

[{
    {
        ctrlDelete _x;
    } forEach _this;
}, [_textCtrl, _borderCtrl], _speed + 0.3] call CBA_fnc_waitAndExecute;

GVAR(notifications) = ([[_borderCtrl, _textCtrl]] + GVAR(notifications)) select {!isNull (_x select 0) && { !isNull (_x select 1) }};

private _offsetY = 0;
if (count GVAR(notifications) > 0) then {
    private _activeNotifications = 0;
    {
        _x params ["_ctrlBorder", "_ctrlText"];

        if (_x findIf { isNull _x } isEqualTo -1) then {
            _ctrlBorder ctrlSetPosition [_posX, (_posY + _offsetY)];
            _ctrlText ctrlSetPosition [(_posX + NOTIFICATION_BORDER_W), (_posY + _offsetY)];
            _ctrlBorder ctrlCommit 0.25;
            _ctrlText ctrlCommit 0.25;
            _offsetY = _offsetY + NOTIFICATION_M + ((ctrlPosition _ctrlText) select 3);

            if (_activeNotifications > 3) then {
                _ctrlText ctrlSetFade 1;
                _ctrlText ctrlCommit 0.2;
                _ctrlBorder ctrlSetFade 1;
                _ctrlBorder ctrlCommit 0.2;
            };

            _activeNotifications = _activeNotifications + 1;
        };
    } forEach GVAR(notifications);
};