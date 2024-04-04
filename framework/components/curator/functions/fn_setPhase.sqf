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
 * call cmf_zeus_fnc_setPhase
 *
 * Public: No
 */
SCRIPT(setPhase);

private _onConfirm = {
    (_this select 0) params ["_name"];

    EGVAR(gameplay,safestart_phase) = [_name, serverTime];
    publicVariable QEGVAR(gameplay,safestart_phase);
};

["Change: Phase", [
    ["EDIT", ["Phase name", "Name of the phase"], [""]]
], _onConfirm, {}] call zen_dialog_fnc_create;