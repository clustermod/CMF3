#include "script_component.hpp"

/* Create log collector */
GVAR(logOut) = [];
GVAR(errorOut) = [];

/* Log Script errors */
addMissionEventHandler ["ScriptError", {
    params ["_errorText", "_sourceFile", "_lineNumber", "_errorPos", "_content", "_stackTraceOutput"];

    if (!is3DENPreview && { isNull getAssignedCuratorLogic cmf_player && { call BIS_fnc_admin isEqualTo 0 } }) exitWith {};

    private _notif = composeText [
        text format ["[SCRIPT] ERROR: %1", _errorText], 
        lineBreak,
        text format ["at %1:%2", _sourceFile, _lineNumber]
    ];

    GVAR(errorOut) pushBack [QUOTE(PREFIX), QUOTE(MODULE), _errorText, _errorPos, _sourceFile, _lineNumber];

    [QGVAR(errorNotification), _notif] call CBA_fnc_globalEvent;
}];