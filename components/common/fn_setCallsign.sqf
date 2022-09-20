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

/* Set the group parameters for each unit in the group */
{
    _x setVariable [QGVAR(group), [_callsign, _type, _level], true];
} forEach units _group;

/* Raise event */
[QGVAR(onGroupCallsignChanged), _this, _group] call CBA_fnc_targetEvent;
