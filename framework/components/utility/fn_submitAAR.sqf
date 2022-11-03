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
 * [] call cmf_menu_fnc_submitReportAction
 *
 * Public: No
 */
SCRIPT(submitReportAction);

/* Check if it's being executed on the Clustercommunity server */
if (serverName != "Clustercommunity") exitWith { hint "This function will only work on the Clustercommunity Server" };

/* Code to submit report */
private _submit = {
    params["_diagValues"];

    /* Check if player wants to be anonymous */
    private _name = "";
    if !(_diagValues select 0) then {
        _name = name player;
    };

    /* Call script serverside (extDB3 only installed serverside) */
    [[_name, _diagValues], {
        if (!isServer) exitWith {};
        params["_name", "_diagValues"];

        /* Get the current session */
        private _sql = format["SELECT * FROM cc_session_history WHERE status='ACTIVE';"];
        private _ret = "extDB3" callExtension format["%1:cc_status:%2", 0, _sql];

        /* Upload the report to the CC database */
        private _sessionID = ((((call compile _ret) select 1) select 0) select 0);
        private _sql = format["INSERT INTO cc_session_reports (owner,mission_feedback,player_feedback,session_id)VALUES('%1','%2','%3',%4);", _name, (_diagValues select 2), (_diagValues select 1), str _sessionID];
        "extDB3" callExtension format["%1:cc_status:%2", 0, _sql];
    }] remoteExec ["call", 2];

    /* Raise event */
    [QGVAR(debrief_onSubmit), []] call CBA_fnc_localEvent;
};

/* Create dialog using Zeus Enhanced */
[LSTRING(performance_report_displayname), [
    ["CHECKBOX", [LSTRING(anonymous_title), LSTRING(anonymous_tooltip)], true],
    ["EDIT:MULTI", [LSTRING(player_feedback_title), LSTRING(player_feedback_tooltip)], [""]],
    ["EDIT:MULTI", [LSTRING(mission_feedback_title), LSTRING(mission_feedback_tooltip)], [""]]
], _submit] call zen_dialog_fnc_create;
