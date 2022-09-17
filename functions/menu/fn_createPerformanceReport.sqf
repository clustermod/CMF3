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
 * [] call emf_aceMenu_fnc_createPerformanceReport
 *
 * Public: No
 */

// FIX LATER
scriptName "functions\aceMenu\fn_createMapsFixAction.sqf";
private["_reportAction"];

if (isDedicated) exitWith {};

// Check if action already exists
if !(isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_report_performance"]] call ace_interact_menu_fnc_findActionNode)}) exitWith {};

_reportAction = ["emf_report_performance", "Debrief report", "rsc\data\icon_ace_debrief_ca.paa", {
    private _submit = {
        params["_diagValues"];

        private _name = "";
        if !(_diagValues select 0) then {
        _name = name player;
        };

        [[_name, _diagValues], {
            if (!isServer) exitWith {};
            params["_name", "_diagValues"];

            private _sql = format["SELECT * FROM cc_session_history WHERE status='ACTIVE';"];
            private _ret = "extDB3" callExtension format["%1:cc_status:%2", 0, _sql];

            private _sessionID = ((((call compile _ret) select 1) select 0) select 0);
            private _sql = format["INSERT INTO cc_session_reports (owner,mission_feedback,player_feedback,session_id)VALUES('%1','%2','%3',%4);", _name, (_diagValues select 2), (_diagValues select 1), str _sessionID];
            "extDB3" callExtension format["%1:cc_status:%2", 0, _sql];
        }] remoteExec ["call", 2];

    };

    ["Performance Report", [
        ["CHECKBOX", ["Anonymous", "Do you want this debrief article to remain anonymous?"], true],
        ["EDIT:MULTI", ["Player Performance Feedback", "Feedback on player performance"], [""]],
        ["EDIT:MULTI", ["Mission Feedback", "Feedback on mission"], [""]]
    ], _submit] call zen_dialog_fnc_create;
}, {true}] call ace_interact_menu_fnc_createAction;

[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _reportAction] call ace_interact_menu_fnc_addActionToClass;
