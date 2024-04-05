#include "script_component.hpp"
/*
 * Author: Eric
 * Fix a bug
 * 
 * Arguments:
 * 0: Target <OBJECT>
 * 
 * Return Value:
 * Child Action <ARRAY>
 * 
 * Example:
 * call cmf_menu_fnc_reportBug
 * 
 * Public: No
 */
params ["_target"];

private _action = ([QGVAR(bug_menu), "Bug Fixes", "components\menu\data\icon_ace_bug_ca.paa", {}, { true }, {
    private _actions = [];

    /* Fix endless loading bug Action */
    private _action = ([QGVAR(loadingbug), LSTRING(loading_bug_displayname), "components\menu\data\icon_ace_bug_ca.paa", {
        private _onConfirm = {
            params["_value"];
            [[], EFUNC(common,endLoadingScreen)] remoteExec ["call", _value, true];
        };

        /* Open a menu where you can select the player to apply the fix to */
        private _players = allPlayers;
        private _playerIds = _players apply { owner _x };
        private _playernames = _players apply { name _x };
        [LSTRING(select_player_displayname), [["LIST", [LSTRING(players), LSTRING(select_player_tooltip)], [_playerIds, _playernames, 0, 3]]], _onConfirm] call zen_dialog_fnc_create;
    }, { (!isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0) }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    /* Suicide action */
    private _action = ([QGVAR(suicide), "Suicide", "a3\ui_f_curator\data\cfgmarkers\kia_ca.paa", {
        _target spawn {
            private _result = ["Are you sure?", "Confirm", true, true] call BIS_fnc_guiMessage;
            if (_result) then {
                player setDamage 1;
            };
        };
    }, { alive player }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    private _action = ([
        QGVAR(reportBug), 
        ELSTRING(3den,report_bug), 
        "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", 
        { createDialog QEGVAR(utility,reportBug) }, 
        { true }
    ] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    _actions;
}] call ace_interact_menu_fnc_createAction);

_action;