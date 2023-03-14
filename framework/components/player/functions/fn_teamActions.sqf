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
 * [] call cmf_player_fnc_teamActions
 *
 * Public: No
 */

 if (!hasInterface) exitWith {};

/* Waituntil player is alive */
waitUntil { alive player && !isNull player };

/* Menu items for the group menu */
private _childrenGroup = {
    params ["_target"];
    private _actions = [];

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
private _icon = switch ((group player) getVariable [QEGVAR(common,sqd_type), "INF"]) do {
    case ("INF"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_inf_ca.paa" };
    case ("ARMOR"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_armor_ca.paa" };
    case ("TRANS"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_unknown_ca.paa" };
    case ("CAS"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_air_ca.paa" };
    case ("LOGI"): { "ca\ui\data\markers\b_support.paa" };
    case ("WEAPONS"): { "ca\ui\data\markers\b_mortar.paa" };
    case ("SUPPORT"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_unknown_ca.paa" };
    case ("MECH"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_mech_inf_ca.paa" };
    case ("MOTOR"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_motor_inf_ca.paa" };
    case ("HQ"): { "a3\ui_f\data\gui\cfg\hints\icon_text\b_hq_ca.paa" };
    default { "a3\ui_f\data\gui\cfg\hints\icon_text\b_unknown_ca.paa" };
};

/* Change title to current group name */
private _modifier = {
    (_this select 3) set [1, (groupID group player)];
};

private _groupAction = [QGVAR(team_main), (groupID group player), _icon, {}, { leader group player == player }, _childrenGroup, [], "", 4, [false, false, false, true, false], _modifier] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "ACE_TeamManagement"], _groupAction] call ace_interact_menu_fnc_addActionToClass;
