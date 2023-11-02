#include "script_component.hpp"

/* Display notification for script errors for admins and zeuses */
[QGVAR(scriptError), {
    params ["_errorText", "_sourceFile", "_lineNumber", "_errorPos", "_content", "_stackTraceOutput"];

    if (!is3DENPreview && { isNull getAssignedCuratorLogic cmf_player && { call BIS_fnc_admin isEqualTo 0 } }) exitWith {};

    private _notif = composeText [
        text format ["[SCRIPT] ERROR: %1", _errorText], 
        lineBreak,
        text format ["at %1:%2", _sourceFile, _lineNumber]
    ];

    GVAR(errorOut) pushBack [QUOTE(PREFIX), QUOTE(MODULE), _errorText, _errorPos, _sourceFile, _lineNumber];

    [_notif, EGVAR(common,notificationColors) get "ERROR", 8] call EFUNC(common,notification);
}] call CBA_fnc_addEventHandler;