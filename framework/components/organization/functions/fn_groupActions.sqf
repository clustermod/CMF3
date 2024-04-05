#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a group menu for team leaders to control their group.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_player_fnc_teamActions
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

/* Menu items for the group menu */
private _childrenGroup = {
    params ["_target"];
    private _actions = [];

    /* Register Team */
    private _action = [QGVAR(registerGroup), "Register Group", "a3\ui_f_curator\data\displays\rscdisplaycurator\modegroups_ca.paa", {
        private _types = [GVAR(orbat)] call CBA_fnc_hashKeys;
        [
            "Group Parameters",
            [
                ["SLIDER", "Group Level", [0, 3, 0, 0], true],
                ["LIST", "Group Type", [_types, _types, 0]],
                ["SLIDER", "Group Priority", [0, 50, 0, 0], true]
            ],
            {
                _this spawn {
                    params ["_values", "_group"];
                    private _result = ["Are you sure? This can break the current group organization!", "Confirm", true, true] call BIS_fnc_guiMessage;
                    if (!_result) exitWith {};

                    if ([_group] call FUNC(groupIsRegistered)) then {
                        [[_group], FUNC(groupUnregister)] remoteExec ["call", 2]; // Call on server
                    };

                    [[_group, round (_values select 0), _values select 1, round (_values select 2)], FUNC(groupRegister)] remoteExec ["call", 2]; // Call on server
                };
            },
            {},
            group _player
        ] call zen_dialog_fnc_create;

        [group _player] call FUNC(groupRegister);
    }, { true }] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];

    /* Reorganize side */
    private _action = [QGVAR(registerGroup), "Reorganize all Groups", "a3\modules_f\data\iconstrategicmaporbat_ca.paa", {
        _player spawn {
            params ["_values", "_group"];
            private _result = ["Are you sure? This will reorganize every group on your side!", "Confirm", true, true] call BIS_fnc_guiMessage;
            if (!_result) exitWith {};

            [[side _this], FUNC(groupReorganize)] remoteExec ["call", 2];
        };
    }, { !ESETTING(gameplay,safestart) || !(missionNamespace getVariable [QGVAR(safestart_disable), false]) }] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];

    /* Create an action for each team member */
    {
        if (_x != player) then {
            private _action = ([format [QGVAR(member_%1), name _x], (name _x), "a3\ui_f\data\igui\rscingameui\rscunitinfo\si_stand_ca.paa", { }, { true }, {
                params ["_target", "", "_unit"];
                private _actions = [];

                /* Assign red team */
                private _action = ([QGVAR(assignTeamRed), "Assign Red", "z\ace\interaction\ui\team\team_white_ca.paa", {
                    ["CBA_teamColorChanged", [(_this select 2), "RED"]] call CBA_fnc_globalEvent;
                }, { assignedTeam (_this select 2) != "RED" }, {}, _unit, "", 4, [false, false, false, false, false], {
                    ['RED', '\z\ace\addons\interaction\UI\team\team_white_ca.paa', _this select 3] call ace_interaction_fnc_modifyTeamManagementAction;
                }] call ace_interact_menu_fnc_createAction);
                _actions pushBack [_action, [], _target];

                /* Assign green team */
                private _action = ([QGVAR(assignTeamGreen), "Assign Green", "z\ace\interaction\ui\team\team_white_ca.paa", {
                    ["CBA_teamColorChanged", [(_this select 2), "GREEN"]] call CBA_fnc_globalEvent;
                }, { assignedTeam (_this select 2) != "GREEN" }, {}, _unit, "", 4, [false, false, false, false, false], {
                    ['GREEN', '\z\ace\addons\interaction\UI\team\team_white_ca.paa', _this select 3] call ace_interaction_fnc_modifyTeamManagementAction;
                }] call ace_interact_menu_fnc_createAction);
                _actions pushBack [_action, [], _target];

                /* Assign blue team */
                private _action = ([QGVAR(assignTeamBlue), "Assign Blue", "z\ace\interaction\ui\team\team_white_ca.paa", {
                    ["CBA_teamColorChanged", [(_this select 2), "BLUE"]] call CBA_fnc_globalEvent;
                }, { assignedTeam (_this select 2) != "BLUE" }, {}, _unit, "", 4, [false, false, false, false, false], {
                    ['BLUE', '\z\ace\addons\interaction\UI\team\team_white_ca.paa', _this select 3] call ace_interaction_fnc_modifyTeamManagementAction;
                }] call ace_interact_menu_fnc_createAction);
                _actions pushBack [_action, [], _target];

                /* Assign yellow team */
                private _action = ([QGVAR(assignTeamYellow), "Assign Yellow", "z\interaction\ace\ui\team\team_white_ca.paa", {
                    ["CBA_teamColorChanged", [(_this select 2), "YELLOW"]] call CBA_fnc_globalEvent;
                }, { assignedTeam (_this select 2) != "YELLOW" }, {}, _unit, "", 4, [false, false, false, false, false], {
                    ['YELLOW', '\z\ace\addons\interaction\UI\team\team_white_ca.paa', _this select 3] call ace_interaction_fnc_modifyTeamManagementAction;
                }] call ace_interact_menu_fnc_createAction);
                _actions pushBack [_action, [], _target];

                /* Unassigned team */
                private _action = ([QGVAR(unAssignTeam), "Kick from team", "z\ace\interaction\UI\team\team_white_ca.paa", {
                    ["CBA_teamColorChanged", [(_this select 2), "MAIN"]] call CBA_fnc_globalEvent;
                }, { assignedTeam (_this select 2) != "MAIN" }, {}, _unit, "", 4, [false, false, false, false, false], {
                    ['MAIN', '\z\ace\addons\interaction\UI\team\team_white_ca.paa', _this select 3] call ace_interaction_fnc_modifyTeamManagementAction;
                }] call ace_interact_menu_fnc_createAction);
                _actions pushBack [_action, [], _target];

                /* Kick from group */
                private _action = ([QGVAR(unAssignGroup), "Kick from group", "\z\ace\addons\interaction\UI\team\team_management_ca.paa", {
                    _oldGroup = units group (_this select 2);
                    _newGroup = createGroup side group (_this select 2);
                    [(_this select 2)] joinSilent _newGroup; {(_this select 2) reveal _x} forEach _oldGroup;
                }, { true }, {}, _unit] call ace_interact_menu_fnc_createAction);
                _actions pushBack [_action, [], _target];

                _actions;
            }, _x] call ace_interact_menu_fnc_createAction);
            _actions pushBack [_action, [], _target];
        };
    } forEach units group player;

    _actions;
};

/* Get icon that represents the group type */
private "_icon";
if ([group player] call FUNC(groupIsRegistered)) then {
    private _groupData = [group player] call FUNC(groupGetData);
    _icon = ([GVAR(orbat), _groupData select 1, {}, "\A3\ui_f\data\map\markers\nato\b_unknown.paa"] call CBA_fnc_hashGet) select 1;

    if (_icon isEqualTo "") then {
        _icon = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
    };
} else {
    _icon = "\A3\ui_f\data\map\markers\nato\b_unknown.paa";
};

/* Change title to current group name */
private _modifier = {
    (_this select 3) set [1, (groupID group player)];
};

private _action = [QGVAR(team_main), (groupID group player), _icon, {}, { leader group player isEqualTo player }, _childrenGroup, [], "", 4, [false, false, false, true, false], _modifier] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions", "ACE_TeamManagement"], _action, true] call ACEFUNC(interact_menu,addActionToClass);