#include "script_component.hpp"
/*
 * Author: Eric
 * Initialize checklist display
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Config <CONFIG>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_3den_fnc_initDisplayChecklist
 *
 * Public: No
 */
if (!is3DEN) exitWith {};
params ["_display", ["_config", configNull]];

private _checkGraphic = {
    if _this then {
        "a3\3den\data\controls\ctrlcheckbox\baseline_texturechecked_ca.paa"
    } else {
        "a3\3den\data\controls\ctrlcheckbox\textureunchecked_ca.paa"
    };
};

private _checkColor = {
    if _this then {
        [0.00, 0.42, 0.23, 1.00]
    } else {
        [0.99, 0.30, 0.00, 1.00]
    };
};

private _listStatus = [] call FUNC(checklist);
private _ctrlList = _display displayCtrl IDC_CHECKLIST;

{
    _ctrlList lbAdd (_x select 0);
    _ctrlList lbSetTooltip [_forEachIndex, (_x select 1)];
    _ctrlList lbSetPicture [_forEachIndex, (_x select 2)];
    _ctrlList lbSetColor [_forEachIndex, (_x select 3)];
} forEach [
    ["Player Units", "Does playable units exist", (_listStatus select 0) call _checkGraphic, (_listStatus select 0) call _checkColor],
    ["Zeus", "Does a Zeus unit exist", (_listStatus select 1) call _checkGraphic, (_listStatus select 0) call _checkColor],
    ["Respawns", "Does a respawn point exist", (_listStatus select 2) call _checkGraphic, (_listStatus select 0) call _checkColor],
    ["Loadout", "Does a loadout exist and is it working", (_listStatus select 3) call _checkGraphic, (_listStatus select 0) call _checkColor],
    ["Ammobox", "Does a ammobox exist", (_listStatus select 4) call _checkGraphic, (_listStatus select 0) call _checkColor],
    ["Mission Data", "Has Mission Data been set", (_listStatus select 5) call _checkGraphic, (_listStatus select 0) call _checkColor]
];