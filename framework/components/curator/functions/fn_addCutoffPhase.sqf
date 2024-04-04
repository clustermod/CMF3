#include "script_component.hpp"
/*
 * Author: Eric
 * module to add/remove safestart cutoff phases
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_safestartCutoffPhases
 *
 * Public: No
 */
SCRIPT(safestartCutoffPhases);

private _onConfirm = {
    (_this select 0) params ["_name", "_cutoff", "_code"];
    private _cutoffPhases = missionNameSpace getVariable [QEGVAR(gameplay,safestart_phaseCutOffs), []];

    _cutoffPhases pushBack [_name, time + (_cutOff * 60), _code];
    EGVAR(gameplay,safestart_phaseCutOffs) = _cutoffPhases;
    publicVariable QEGVAR(gameplay,safestart_phaseCutOffs);
};

["Add: Cutoff Phase", [
    ["EDIT", ["Phase name", "Name of the cutoff phase"], [""]],
    ["SLIDER", ["Cutoff Time", "(In minutes)"], [0, 60, 20, 0]],
    ["EDIT:CODE", ["On Complete", "Code that get's executed when the phase completes"], [""]]
], _onConfirm, {}] call zen_dialog_fnc_create;