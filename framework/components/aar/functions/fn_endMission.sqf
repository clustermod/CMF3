#include "script_component.hpp"
/*
 * Author: Eric
 * Hijacks the endMission Module to show a custom mission ending
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_aar_fnc_endMission
 *
 * Public: No
 */

/* Custom end mission function */ // @TODO: Replace spawn
EFUNC(inline_aar,endMission) = {
    /* Close mission end type dialog (or timeout if user doesn't have dialog)*/
    private _timeout = serverTime + 3;
    waitUntil { if (_timeout < serverTime) exitWith { true }; !isNull (uiNamespace getVariable ["RscDisplayAttributesModuleEndMission", controlNull]) };
    if (isNull (uiNamespace getVariable "RscDisplayAttributesModuleEndMission")) exitWith { };
    (uiNamespace getVariable "RscDisplayAttributesModuleEndMission") closeDisplay 2;

    /* Custom end mission display */
    private _statement = {
        /* remoteExecute for all players */
        [(_this select 0), {
            params ["_opSuccess", "_tacSuccess", "_objectivesState", "_message"];

            /* Generate the seperate sections */
            private _missionData = missionNameSpace getVariable [QEGVAR(common,missionData), []];
            private _hash = [_missionData] call CBA_fnc_hashCreate;
            private _operationName = [_hash, "M_TITLE", [getMissionConfigValue ['IntelBriefingName', briefingName]] call EFUNC(common,hexToASCII)] call CBA_fnc_hashGet;
            private _op = format ["<t color='#%3'>%1 was an operational %2</t>", _operationName, (["Success", "Failure"] select !_opSuccess), (["fcba03", "fc3d03"] select !_opSuccess)];
            private _tac = format ["<t>%1 was a tactical %2</t>", _operationName, (["Success", "Failure"] select !_tacSuccess)];
            private _message = _message splitString toString [13, 10] joinString "<br/>";
            if (_message != "") then { _message = format ["<br/> <t>%1</t>", _message]; };
            private _objectives = _objectivesState splitString toString [13,10] joinString "<br/>";
            if (_objectives != "") then { _objectives = format ["<br/><t color='#888888'>%1</t>", _objectives]; };

            /* Get group statistics */
            private _groupDeaths = 0;
            { _groupDeaths = _groupDeaths + (_x getVariable [QGVAR(stats_deaths), 0]) } forEach units (group player);
            private _enemyGroupKills = 0;
            { _enemyGroupKills = _enemyGroupKills + (_x getVariable [QGVAR(stats_E_kills), 0]) } forEach units (group player);
            private _friendlyGroupKills = 0;
            { _friendlyGroupKills = _friendlyGroupKills + (_x getVariable [QGVAR(stats_F_kills), 0]) } forEach units (group player);
            private _civilianGroupKills = 0;
            { _civilianGroupKills = _civilianGroupKills + (_x getVariable [QGVAR(stats_C_kills), 0]) } forEach units (group player);

            private _stats = composeText [
                "<t size='0.3' color='#888888' font='EtelkaMonospacePro'>",
                format ["        Group Deaths: %1 <br/>", _groupDeaths],
                format ["   Group Enemy Kills: %1 <br/>", _enemyGroupKills],
                format ["Group Friendly Kills: %1 <br/>", _friendlyGroupKills],
                format ["Group Civilian Kills: %1", _civilianGroupKills],
                "<br/><br/>",
                format ["         Your Deaths: %1 <br/>", (player getVariable [QGVAR(stats_deaths), 0])],
                format ["    Your Enemy Kills: %1 <br/>", (player getVariable [QGVAR(stats_E_kills), 0])],
                format [" Your Friendly Kills: %1 <br/>", (player getVariable [QGVAR(stats_F_kills), 0])],
                format [" Your Civilian Kills: %1 <br/>", (player getVariable [QGVAR(stats_C_kills), 0])],
                "</t>"
            ];

            private _text = format [
                "<t>%1</t><br/><t size='0.8'>%2</t><t size='0.6'>%3</t><t size='0.5'>%4</t><br/><br/>%5", _op, _tac, _message, _objectives, _stats
            ];

            sleep 1;
            [0, "BLACK", 6, 0] spawn BIS_fnc_fadeEffect;
            [_text, -1, -1, 6, 1] spawn BIS_fnc_dynamicText;
            sleep 10;
            [1, "BLACK", 3, 0] spawn BIS_fnc_fadeEffect;

            /* Put everyone in spectator*/
            [true, true, true] call ace_spectator_fnc_setSpectator;

            /* Show kill and death stats aslong as spectator is active */
            [_groupDeaths, _enemyGroupKills, _friendlyGroupKills, _civilianGroupKills, _op, _tac, _message, _objectives] spawn {
                player setVariable [QGVAR(spectatorStatus), true];
                ["ace_spectator_displayUnloaded", { player setVariable [QGVAR(spectatorStatus), false] }] call CBA_fnc_addEventHandler;

                private _statsText = format ["<t align='center' size='1.1'>%1</t><br/><t align='center' size='1'>%2</t align='center'><t size='0.9'>%3</t><t size='0.8'>%4</t><br/><br/>", (_this select 4), (_this select 5), (_this select 6), (_this select 7)];

                _statsText = _statsText + "<t size='0.9'>";
                _statsText = _statsText + format["<t align='left' color='#888888'>Group Deaths:</t> <t align='right' color='#888888'>%1</t><br/>", _this select 0];
                _statsText = _statsText + format["<t align='left' color='#888888'>Group Enemy Kills:</t> <t align='right' color='#888888'>%1</t><br/>", _this select 1];
                _statsText = _statsText + format["<t align='left' color='#888888'>Group Friendly Kills:</t> <t align='right' color='#888888'>%1</t><br/>", _this select 2];
                _statsText = _statsText + format["<t align='left' color='#888888'>Group Civilian Kills:</t> <t align='right' color='#888888'>%1</t><br/>", _this select 3];
                _statsText = _statsText + "<br/>";
                _statsText = _statsText + format["<t align='left' color='#888888'>Your Deaths:</t> <t align='right' color='#888888'>%1</t><br/>", (player getVariable [QGVAR(stats_deaths), 0])];
                _statsText = _statsText + format["<t align='left' color='#888888'>Your Enemy Kills:</t> <t align='right' color='#888888'>%1</t><br/>", (player getVariable [QGVAR(stats_E_kills), 0])];
                _statsText = _statsText + format["<t align='left' color='#888888'>Your Friendly Kills:</t> <t align='right' color='#888888'>%1</t><br/>", (player getVariable [QGVAR(stats_F_kills), 0])];
                _statsText = _statsText + format["<t align='left' color='#888888'>Your Civilian Kills:</t> <t align='right' color='#888888'>%1</t><br/>", (player getVariable [QGVAR(stats_C_kills), 0])];
                _statsText = _statsText + format["<t align='left' color='#888888'>Shots Fired:</t> <t align='right' color='#888888'>%1</t><br/>", (player getVariable [QGVAR(stats_shots_fired), 0])];
                // @TODO: Make sure to save stats incase of a rejip

                while { player getVariable QGVAR(spectatorStatus) } do {
                    hintSilent parseText _statsText;
                    sleep 1;
                };
                hintSilent "";
            };

            /* make players type out an AAR */
            sleep 2;
            call FUNC(submitAAR);
            waitUntil { isNull (uiNamespace getVariable "zen_common_display") };

            /* Open dialog for reading */
            waitUntil { count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) != 0 };

            private _display = findDisplay 60000 createDisplay QGVAR(aarReadingDisplay);
            uiNamespace setVariable [QGVAR(aarIndex), 0];

            /* Set first AAR entry */
            private _currentAAR = ( missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) select 0;
            (_display displayCtrl 100) ctrlSetText (_currentAAR select 0);
            (_display displayCtrl 101) ctrlSetText (_currentAAR select 1);
            (_display displayCtrl 102) ctrlSetText (_currentAAR select 2);
            (_display displayCtrl 300) ctrlSetText format ["AAR Feedback (%1/%2)", (uiNamespace getVariable [QGVAR(aarIndex), 0]) + 1, (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]))];

            /* Update AAR amount */
            _display spawn {
                private _curValue = (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]));
                while { !isNull _this } do {
                    waitUntil { count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) != _curValue };
                    private _curValue = (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]));
                    (ctrlParent _ctrl displayCtrl 300) ctrlSetText format ["AAR Feedback (%1/%2)", (uiNamespace getVariable [QGVAR(aarIndex), 0]) + 1, _curValue];
                };
            };

            /* Previous */
            (_display displayCtrl 200) ctrlAddEventHandler ["ButtonClick", {
                params ["_ctrl"];

                private _index = uiNamespace getVariable [QGVAR(aarIndex), 0];
                private _currentAAR = ( missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) select 0 max (_index - 1);
                (ctrlParent _ctrl displayCtrl 100) ctrlSetText (_currentAAR select 0);
                (ctrlParent _ctrl displayCtrl 101) ctrlSetText (_currentAAR select 1);
                (ctrlParent _ctrl displayCtrl 102) ctrlSetText (_currentAAR select 2);
                (ctrlParent _ctrl displayCtrl 300) ctrlSetText format ["AAR Feedback (%1/%2)", (0 max (_index + 1)), (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]))];

                uiNamespace setVariable [QGVAR(aarIndex), (0 max (_index - 1))];
            }];

            /* Next */
            (_display displayCtrl 201) ctrlAddEventHandler ["ButtonClick", {
                params ["_ctrl"];

                private _index = uiNamespace getVariable [QGVAR(aarIndex), 0];
                private _currentAAR = ( missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) select count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) min (_index + 1);
                (ctrlParent _ctrl displayCtrl 100) ctrlSetText (_currentAAR select 0);
                (ctrlParent _ctrl displayCtrl 101) ctrlSetText (_currentAAR select 1);
                (ctrlParent _ctrl displayCtrl 102) ctrlSetText (_currentAAR select 2);
                (ctrlParent _ctrl displayCtrl 300) ctrlSetText format ["AAR Feedback (%1/%2)",
                    (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) min (_index + 2)),
                    (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]))
                ];

                uiNamespace setVariable [QGVAR(aarIndex), (count (missionNameSpace getVariable [QGVAR(AAR_playerReports), []]) min (_index + 1))];
            }];

        }] remoteExec ["spawn", 0, true];
    };

    /* Create dialog for zeus */
    ["End Scenario", [
        ["CHECKBOX", ["Operational success", "Was the operation/mission successfull?"], true],
        ["CHECKBOX", ["tactical success", "Was the tactical aspect of the operation successfull (did the operation stay below the casualty or resource limit)?"], true],
        ["EDIT:MULTI", ["Completed Objectives (SHIFT + ENTER for new line) <optional>", "Write a list of objectives and their state (completed, failed)."], ""],
        ["EDIT:MULTI", ["Message (SHIFT + ENTER for new line) <optional>", "Message displayed in operation end screen"], ""]
    ], _statement, {}] call zen_dialog_fnc_create;
};

/* Hijack module */
private _EHIndex = addMissionEventHandler ["EntityCreated", {
    params ["_entity"];

    if (typeof _entity isEqualTo "ModuleEndMission_F" && local _entity) then {
        deleteVehicle _entity;
        [] spawn EFUNC(inline_aar,endMission);
    };
}];

GVAR(endMission_moduleOverride) = ["EntityCreated", _EHIndex];