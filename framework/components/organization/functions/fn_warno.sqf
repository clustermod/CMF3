#include "script_component.hpp"
/*
 * Author: Eric
 * Displays a warning order on the map
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_organization_fnc_warno
 * 
 * Public: No
 */

if (!fileExists "WARNO.sqf") exitWith {};

[{ !isNull player }, {
    private _warno = call compile preprocessFileLineNumbers "WARNO.sqf";

    private _formattedDate = format ["%3/%2/%1 %4:%5", 
        date select 0, 
        (["", "0"] select (date select 1 < 10)) + str (date select 1),
        (["", "0"] select (date select 2 < 10)) + str (date select 2),
        (["", "0"] select (date select 3 < 10)) + str (date select 3),
        (["", "0"] select (date select 4 < 10)) + str (date select 4)
    ];

    private _missionData = missionNameSpace getVariable [QEGVAR(common,missionData), []];
    private _hash = [_missionData] call CBA_fnc_hashCreate;
    private _operationName = [_hash, "M_TITLE", [getMissionConfigValue ['IntelBriefingName', briefingName]] call EFUNC(common,hexToASCII)] call CBA_fnc_hashGet;

    private _worldName = getText (configFile >> "CfgWorlds" >> worldName >> "description");

    private _weather = call EFUNC(environment,getWeatherDescriptors);
    private _env = [
        "Date: <font color=""#fcba03"">" + _formattedDate + "</font>",
        "Operation: <font color=""#fcba03"">" + _operationName + "</font>",
        "Terrain: <font color=""#fcba03"">" + _worldName + "</font>",
        "Weather: <font color=""#fcba03""><log subject=""cmf_environment"" record=""1"">" + (_weather select 0) + " at " + (_weather select 1) + " with winds at " + (_weather select 2) + "</log></font>"
    ] joinString "<br/>";

    /* Parse Markdown and remove chasing and trailing newlines */
    _warno = _warno apply { 
        _parsed = [_x, true] call EFUNC(common,parseMarkdown);
        _parsed = [_parsed, [_parsed, 5] call BIS_fnc_trimString] select (_parsed select [0, 5] isEqualTo "<br/>");
        [_parsed, [_parsed, 0, count _parsed - 5] call BIS_fnc_trimString] select (_parsed select [count _parsed - 5, 5] isEqualTo "<br/>")
    };

    player createDiaryRecord ["Diary", ["Command / Signal", (_warno select 4)]];
    player createDiaryRecord ["Diary", ["Administration / Logistics", _warno select 3]];
    player createDiaryRecord ["Diary", ["Execution", _warno select 2]];
    player createDiaryRecord ["Diary", ["Mission", _warno select 1]];


    player createDiaryRecord ["Diary", ["Situation", _env + "<br/><br/>" + (_warno select 0)]];
}] call CBA_fnc_waitUntilAndExecute;
