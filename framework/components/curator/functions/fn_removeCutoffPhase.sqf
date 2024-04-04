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

    _cutoffPhases pushBack [_name, _cutOff, _code];
    EGVAR(gameplay,safestart_phaseCutOffs) = _cutoffPhases;
    publicVariable QEGVAR(gameplay,safestart_phaseCutOffs);
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