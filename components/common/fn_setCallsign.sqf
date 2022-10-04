#include "script_component.hpp"
/*
 * Author: Eric
 * Sets squad callsign and optionally type and level
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Callsign <STRING>
 * 2: Type <STRING> (Optional)
 * 3: Command Level <STRING> (Optional)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myGroup, "A1", "ARMOR", "PLT"] call cmf_common_fnc_setCallsign
 *
 * Public: Yes
 */
SCRIPT(setCallsign);
if (!isServer) exitWith {};
params["_group", "_callsign", ["_type", "INF"], ["_level", "FT"]];

/* Set the group's callsign */
_group setGroupId [_callsign];
_group setVariable [QGVAR(sqd_callsign), _callsign, true];

/* Set the group's squad type */
_group setVariable [QGVAR(sqd_type), _type, true];

/* Set the groups size and the group's unit's the ranks */
private _sizes = ("true" configClasses (missionConfigFile >> "CMF_ORBAT" >> "SIZES")) apply {configName _x};
_group setVariable [QGVAR(sqd_size), _level, true];
if (_level in _sizes) then {
    private _leaderRank = getText (missionConfigFile >> "CMF_ORBAT" >> "SIZES" >> toUpper _level >> "leadRank");
    private _generalRank = getText (missionConfigFile >> "CMF_ORBAT" >> "SIZES" >> toUpper _level >> "generalRank");
    {
        if ((rank _x) isEqualTo "PRIVATE") then {
            if (_x isEqualTo (leader _group)) then {
                [_x, _leaderRank] remoteExec ["setRank", 0, true];
            } else {
                [_x, _generalRank] remoteExec ["setRank", 0, true];
            };
        };
    } forEach units _group;
} else {
    if ((rank (leader _group)) isEqualTo "PRIVATE") then {
        [(leader _group), "SERGEANT"] remoteExec ["setRank", 0, true];
    };
};

/* Set group gesture colors */
private _color = [1,0.88,0,0.7];
private _leadColor = [1,0.88,0,0.95];
switch (_level) do {

    /* Set colors for fireteam elements */
    case ("FT"): {
        switch (true) do {
            case (["A", _callsign] call BIS_fnc_inString): { _color = [1,0,0,0.7]; _leadColor = [1,0,0,0.95] };
            case (["B", _callsign] call BIS_fnc_inString): { _color = [0,1,0,0.7]; _leadColor = [0,1,0,0.95] };
            case (["C", _callsign] call BIS_fnc_inString): { _color = [0,0,1,0.7]; _leadColor = [0,0,1,0.95] };
            default { _color = [1,0.54,0,0.7]; _leadColor = [1,0.54,0,0.95] };
        };
    };

    /* Set colors for squad elements */
    case ("SQD"): {
        switch (true) do {
            case (["ASL", _callsign] call BIS_fnc_inString): { _color = [1,0,0,0.7]; _leadColor = [1,0,0,0.95] };
            case (["BSL", _callsign] call BIS_fnc_inString): { _color = [0,1,0,0.7]; _leadColor = [0,1,0,0.95] };
            case (["CSL", _callsign] call BIS_fnc_inString): { _color = [0,0,1,0.7]; _leadColor = [0,0,1,0.95] };
            default { _color = [1,0.54,0,0.7]; _leadColor = [1,0.54,0,0.95] };
        };
    };

    /* Set color for platoon elements */
    case ("PLT"): {
        switch (true) do {
            case (["HQ", _callsign] call BIS_fnc_inString): { _color = [1,1,0,0.7]; _leadColor = [1,1,0,0.95] };
            case (["PHANTOM", _callsign] call BIS_fnc_inString): { _color = [0,0,1,0.7]; _leadColor = [0,0,1,0.95] };
            case (["REAPER", _callsign] call BIS_fnc_inString): { _color = [0,0,1,0.7]; _leadColor = [0,0,1,0.95] };
            case (["UGLY", _callsign] call BIS_fnc_inString): { _color = [0,0,1,0.7]; _leadColor = [0,0,1,0.95] };
            case (["HAWG", _callsign] call BIS_fnc_inString): { _color = [0.85,0.64,0.12,0.7]; _leadColor = [0.85,0.64,0.12,0.95] };
            case (["PAVEMENT", _callsign] call BIS_fnc_inString): { _color = [0.85,0.64,0.12,0.7]; _leadColor = [0.85,0.64,0.12,0.95] };
            default { _color = [1,0.54,0,0.7]; _leadColor = [1,0.54,0,0.95] };
        };
    };

    /* Set color for company elements */
    case ("COY"): {
        switch (true) do {
            case (["HQ", _callsign] call BIS_fnc_inString): { _color = [0.05,0.05,0.05,0.7]; _leadColor = [0.05,0.05,0.05,0.95] };
        };
    };
};
[[_callsign, _color, _leadColor], ace_map_gestures_fnc_addGroupColorMapping] remoteExec ["call", 0, true];

/* Set the group parameters for each unit in the group */
{
    _x setVariable [QGVAR(group), [_callsign, _type, _level], true];
} forEach units _group;

/* Raise event */
[QGVAR(onGroupCallsignChanged), _this, _group] call CBA_fnc_targetEvent;
