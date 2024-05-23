#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a roster of the current players. Get's executed automatically
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_gameplay_fnc_roster
 *
 * Public: No
 */

// @TODO: also get unassigned players from outside the dynamic group system
[{ !isNull player && { alive player } }, {
    player createDiarySubject ["cmf_roster", "Player Roster"];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) then {
            /* Remove outdated roster */
            {
                player removeDiaryRecord ["cmf_roster", _x select 8]
            } forEach (player allDiaryRecords "cmf_roster");
        } else {
            /* Add Each of the highest level groups */
            private _groupHash = [GVAR(groups), side cmf_player, []] call CBA_fnc_hashGet;
            private _levels = [_groupHash] call CBA_fnc_hashKeys;
            if (count _levels isEqualTo 0) exitWith { cmf_player createDiaryRecord ["cmf_roster", ["No Registered Groups.", ""]] };

            {
                cmf_player removeDiaryRecord ["cmf_roster", _x select 8];
            } forEach (cmf_player allDiaryRecords "cmf_roster");

            _levels sort false;
            private "_topLevelGroups";
            {
                private _groups = [_groupHash, _x, []] call CBA_fnc_hashGet;

                if (_groups findIf { units _x findIf { isPlayer _x } > -1 } > -1) exitWith {
                    _topLevelGroups = _groups;
                };
            } forEach _levels;

            if (isNil "_topLevelGroups") exitWith { cmf_player createDiaryRecord ["cmf_roster", ["No Registered Groups.", ""]] };

            reverse _topLevelGroups;

            FUNC(ToE_recursiveCheck) = {
                params ["_group", ["_indent", ""]];

                private _formattedString = "";

                private _formatGroupHeader = { format ["<font face='PuristaBold'>%1</font><br/>", _this] };

                private _groupNames = _group getVariable [QGVAR(groupName), ["UNKNOWN", "UNKNOWN"]];
                private _groupData = [_group] call FUNC(groupGetData);
                private _units = units _group;
                _groupData params ["_level", "", "", "_children"];

                if (count _units isNotEqualTo 0) then {
                    if (count _children > 0) then {
                        _formattedString = _formattedString + "<br/>" + _indent + ((_groupNames select 1) call _formatGroupHeader);
                        _indent = _indent + "    ";
                    };


                    _formattedString = _formattedString + _indent + ((_groupNames select 0) call _formatGroupHeader);
                    {
                        if (isPlayer _x) then {
                            private _roleDescription = "None";
                            if (roleDescription _x != "") then {
                                _roleDescription = (roleDescription _x splitString "@") select 0;
                            };

                            _formattedString = _formattedString + _indent + format ["    <font color='#fcba03'> %1</font>, %2<br/>", name _x, _roleDescription];
                        };
                    } forEach units _group;
                };

                /* Sort children */
                _children = [_children, [], {
                    private _group = _x;
                    private _groupData = [_group] call FUNC(groupGetData);
                    private _groupNames = _group getVariable [QGVAR(groupName), ["UNKNOWN", "UNKNOWN"]];
                    _groupData params ["", "_type", "", "_children"];

                    private _childrenCount = count _children;
                    private _alphabetOrder = GVAR(phoneticAlphabet) findIf { (_x select [0, 1]) isEqualTo (_groupNames select [0, 1]) };

                    _childrenCount + ([1000, -_alphabetOrder] select (_type isEqualTo "INF"))
                }, "DESCEND"] call BIS_fnc_sortBy;

                {
                    if (units _x findIf { isPlayer _x } > -1) then {
                        _formattedString = _formattedString + ([_x, _indent] call FUNC(ToE_recursiveCheck));
                    }
                } forEach _children;

                _formattedString;
            };


            {
                private _group = _x;
                if (units _group findIf { isPlayer _x } > -1) then {
                    private _groupNames = _group getVariable [QGVAR(groupName), ["UNKNOWN", "UNKNOWN"]];
                    private _formattedString = "<br/><font size='12'>";

                    _formattedString = _formattedString + ([_group] call FUNC(ToE_recursiveCheck));

                    cmf_player createDiaryRecord ["cmf_roster", [(_groupNames select 1), _formattedString]];
                }
            } forEach _topLevelGroups;
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;