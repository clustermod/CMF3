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
 * [] call cmf_zeus_fnc_safestartCutoffPhases
 *
 * Public: No
 */
SCRIPT(safestartCutoffPhases);

private _addFunction = {
    private _onConfirm = {
        (_this select 0) params ["_name", "_cutoff", "_code"];
        private _cutoffPhases = missionNameSpace getVariable [QEGVAR(gameplay,safestart_phaseCutOffs), []];

        _cutoffPhases pushBack [_name, time + (_cutOff * 60), _code];
        missionNameSpace setVariable [QEGVAR(gameplay,safestart_phaseCutOffs), _cutoffPhases, true];
    };

    ["Add: Cutoff Phase", [
        ["EDIT", ["Phase name", "Name of the cutoff phase"], [""]],
        ["SLIDER", ["Cutoff Time", "(In minutes)"], [0, 60, 20, 0]],
        ["EDIT:CODE", ["On Complete", "Code that get's executed when the phase completes"], [""]]
    ], _onConfirm, {}] call zen_dialog_fnc_create;
};

["CMF: Safestart", "Add Cutoff Phase", _addFunction, ""] call zen_custom_modules_fnc_register;

private _removeFunction = {
    private _onConfirm = {
        (_this select 0) params ["_name", "_cutoff", "_code"];
        private _cutoffPhases = missionNameSpace getVariable [QEGVAR(gameplay,safestart_phaseCutOffs), []];

        _cutoffPhases pushBack [_name, _cutOff, _code];
        missionNameSpace setVariable [QEGVAR(gameplay,safestart_phaseCutOffs), _cutoffPhases, true];
    };

    /* Get current cutoff phases */
    private _cutoffPhases = missionNameSpace getVariable [QEGVAR(gameplay,safestart_phaseCutOffs), []];

    /* get indexes */
    private _values = [];
    for "_i" from 0 to count _cutoffPhases do {
        _values pushBack _i;
    };

    ["Remove: Cutoff Phase", [
        ["LIST", ["Phase name", "Name of the cutoff phase"], [_values, _cutoffPhases, 0, 5]]
    ], _onConfirm, {}] call zen_dialog_fnc_create;
};

["CMF: Safestart", "Remove Cutoff Phase", _removeFunction, ""] call zen_custom_modules_fnc_register;
