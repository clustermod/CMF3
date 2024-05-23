#include "script_component.hpp"
/*
 * Author: Eric
 * Adds ACE Interaction menu actions to logistics crates
 *
 * Arguments:
 * No
 *
 * Return Value:
 * No
 *
 * Example:
 * call cmf_logistics_fnc_crateActions
 *
 * Public: No
 */

/* Create actions */
private _action = [QGVAR(crate_menu), "Other", "", {}, { true }, {
    private _actions = [];

    /* Rename object */
    private _action = [QGVAR(renameObject), "Rename", "a3\3den\data\displays\display3den\panelright\customcomposition_edit_ca.paa", {
        ace_cargo_interactionVehicle = _target;
        createDialog "ace_cargo_renameMenu";
    }, {
        ace_cargo_enable &&
        { ace_cargo_enableRename } &&
        { (_target getVariable ["ace_cargo_canLoad", getNumber (configOf _target >> "ace_cargo_canLoad")]) in [true, 1] } &&
        { alive _target } &&
        { [_player, _target, ["isNotSwimming"]] call ace_common_fnc_canInteractWith }
    }] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];

    /* Destroy crate */
    private _action = ([QGVAR(renameObject), "Destroy Crate", "a3\ui_f_curator\data\cfgmarkers\kia_ca.paa", {
        _target spawn {
            private _result = ["Are you sure?", "Confirm", true, true] call BIS_fnc_guiMessage;
            if _result then {
                deleteVehicle _this;
            };
        };
    }, {
        ace_cargo_enable &&
        { missionNamespace getVariable [QGVAR(enableDestroy), true] } &&
        { (_target getVariable ["ace_cargo_canLoad", getNumber (configOf _target >> "ace_cargo_canLoad")]) in [true, 1] } &&
        { alive _target } &&
        { [_player, _target, ["isNotSwimming"]] call ace_common_fnc_canInteractWith }
    }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    _actions;
}] call ace_interact_menu_fnc_createAction;

/* Add action to class */
["ReammoBox_F", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
