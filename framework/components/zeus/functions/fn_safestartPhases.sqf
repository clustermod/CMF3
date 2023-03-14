#include "script_component.hpp"
/*
 * Author: Eric
 * module to change safestart phase
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_zeus_fnc_safestartPhases
 *
 * Public: No
 */
SCRIPT(safestartPhases);

private _addFunction = {
    private _onConfirm = {
        (_this select 0) params ["_name"];

        missionNameSpace setVariable [QEGVAR(gameplay,safestart_phase), [_name, EGVAR(main,unifiedTime)], true];
    };

    ["Change: Phase", [
        ["EDIT", ["Phase name", "Name of the phase"], [""]]
    ], _onConfirm, {}] call zen_dialog_fnc_create;
};

["CMF: Safestart", "Change Phase", _addFunction, ""] call zen_custom_modules_fnc_register;
