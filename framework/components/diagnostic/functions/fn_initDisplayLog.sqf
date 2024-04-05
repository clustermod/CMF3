#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes log display
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [] call cmf_diagnostic_fnc_initDisplayLog
 * 
 * Public: No
 */

params ["_display"];

private _formatTime = {
    ((_this select [3, 3]) apply { [_x, 2] call CBA_fnc_formatNumber }) joinString ":";
};

/* Style errors */
private _formattedError = GVAR(errorOut) apply {
    private _errorColor = (EGVAR(common,notificationColors) get "ERROR") call BIS_fnc_colorRGBtoHTML;
    private _infoColor = (EGVAR(common,notificationColors) get "INFO") call BIS_fnc_colorRGBtoHTML;
    format ["<t color='%3'>%1</t> <t color='%4'>%2</t>", (_x select 1) call _formatTime, (_x select 2), _infoColor, _errorColor];
};

/* Style log */
private _logContent = GVAR(logOut) apply {
    private _infoColor = (EGVAR(common,notificationColors) get "INFO") call BIS_fnc_colorRGBtoHTML;
    format ["<t color='%3'>%1</t> %2", (_x select 1) call _formatTime, (_x select 2), _infoColor];
};

_logContent append _formattedError;
_logContent sort true;

disableSerialization;
private _ctrlClear = _display displayCtrl IDC_LOG_CLEAR;
private _ctrlText = _display displayCtrl IDC_LOG_TEXT;
private _ctrlLines = _display displayCtrl IDC_LOG_LINES;
private _ctrlGroup = ctrlParentControlsGroup _ctrlText;

ctrlPosition _ctrlGroup params ["_xParent", "_yParent", "_wParent", "_hParent"];
_maxW = selectMax (_logContent apply {
    str parseText _x getTextWidth ["RobotoCondensedLight", LOG_FONTSIZE * 2]
});

_ctrlText ctrlSetPositionW (_maxW max _wParent);
_ctrlText ctrlCommit 0;

_ctrlText ctrlSetStructuredText parseText (_logContent joinString "<br/>");
_ctrlLines ctrlSetText str (count _logContent);
_ctrlText ctrlSetPosition [
    0,
    0,
    _wParent max _maxW,
    _hParent max ctrlTextHeight _ctrlText
];
_ctrlText ctrlCommit 0;

_ctrlGroup spawn {
    _this ctrlSetScrollValues [1,0];
};

_ctrlClear ctrlAddEventHandler ["ButtonClick", {
    _this spawn {
        params ["_ctrl"];

        private _result = ["This will clear the log. Are you sure?", "Confirm", true, true] call BIS_fnc_guiMessage;

        if (_result) then {
            call FUNC(errorFlush);
            call FUNC(logFlush);
            (ctrlParent _ctrl) closeDisplay 1;
        };
    };
}];