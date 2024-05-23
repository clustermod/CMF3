#include "script_component.hpp"
/*
 * Author: Eric
 * Opens a dialog to submit an after action report, this will only work on the clusterCommunity server.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_aar_fnc_submitAAR
 *
 * Public: No
 */
SCRIPT(submitReportAction);

/* Code to submit report */
private _submit = {
    (_this select 0) params ["_anon", "_mission", "_player"];

    /* Check if player wants to be anonymous */
    private _name = [name player, ""] select _anon;

    /* Call script serverside (extDB3 only installed serverside) */
    private _oldReports = missionNameSpace getVariable [QGVAR(reports), []];
    _oldReports pushBack [_name, _mission, _player, (name player)];
    GVAR(reports) = _oldReports;
    publicVariable QGVAR(reports);

    /* Raise event */
    [QGVAR(onSubmitReport), []] call CBA_fnc_localEvent;
};

/* Create dialog using Zeus Enhanced */
private _dialog = [LSTRING(performance_report_displayname), [
    ["CHECKBOX", [LSTRING(anonymous_title), LSTRING(anonymous_tooltip)], true],
    ["EDIT:MULTI", [LSTRING(mission_feedback_title), LSTRING(mission_feedback_tooltip)], [""]],
    ["EDIT:MULTI", [LSTRING(player_feedback_title), LSTRING(player_feedback_tooltip)], [""]]
], _submit] call zen_dialog_fnc_create;
