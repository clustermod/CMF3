#include "script_component.hpp"
/*
 * Author: Eric
 * Creates the Debrief report action in ace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_menu_fnc_submitReportAction
 *
 * Public: No
 */
SCRIPT(submitReportAction);

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
};

/* Create dialog using Zeus Enhanced */
["Performance Report", [
    ["CHECKBOX", ["Anonymous", "Do you want this debrief article to remain anonymous?"], true],
    ["EDIT:MULTI", ["Player Performance Feedback", "Feedback on player performance"], [""]],
    ["EDIT:MULTI", ["Mission Feedback", "Feedback on mission"], [""]]
], _submit] call zen_dialog_fnc_create;
