#include "script_component.hpp"

[QGVAR(errorNotification), {
    params ["_msg"];

    if (!is3DENPreview && { isNull getAssignedCuratorLogic cmf_player && { call BIS_fnc_admin isEqualTo 0 } }) exitWith {};

    [_msg, EGVAR(common,notificationColors) get "ERROR", 8] call EFUNC(common,notification);
}] call CBA_fnc_addEventHandler;

[QGVAR(warningNotification), {
    params ["_msg"];

    if (!is3DENPreview && { isNull getAssignedCuratorLogic cmf_player && { call BIS_fnc_admin isEqualTo 0 } }) exitWith {};

    [_msg, EGVAR(common,notificationColors) get "WARNING", 8] call EFUNC(common,notification);
}] call CBA_fnc_addEventHandler;

[{
    if (isNull cmf_player) exitWith { };
    [cmf_player, QGVAR(fps), floor diag_fps] call CBA_fnc_setVarNet;
}, 1] call CBA_fnc_addPerFrameHandler;

GVAR(longestFrame) = 0;
GVAR(shortestFrame) = 100;
[{
    /* if (diag_frameNo % 60 isNotEqualTo 0) exitWith {
        GVAR(longestFrame) = 0;
        GVAR(shortestFrame) = 100;
    }; */

    GVAR(longestFrame) = GVAR(longestFrame) max diag_deltaTime;
    GVAR(shortestFrame) = GVAR(shortestFrame) min diag_deltaTime;
}] call CBA_fnc_addPerFrameHandler;