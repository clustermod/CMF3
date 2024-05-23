#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes custom spectator camera scripts
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_aar_fnc_initDisplaySpectator
 *
 * Public: No
 */
params ["_display"];

private _ctrlReportsGroup = _display ctrlCreate ["CMF_reportsGroup", 60009];

[QGVAR(onSpectatorHide), {
    _thisArgs params ["_ctrlReportsGroup"];
    
    _ctrlReportsGroup ctrlSetFade 1;
    _ctrlReportsGroup ctrlCommit 0.25;
}, [_ctrlReportsGroup]] call CBA_fnc_addEventHandlerArgs;

[QGVAR(onSpectatorShow), {
    _thisArgs params ["_ctrlReportsGroup"];
    
    _ctrlReportsGroup ctrlSetFade 0;
    _ctrlReportsGroup ctrlCommit 0.25;
}, [_ctrlReportsGroup]] call CBA_fnc_addEventHandlerArgs;

/* Update visibility */
GVAR(oldUiVisible) = ace_spectator_uiVisible;
[{
    if (GVAR(oldUiVisible) isEqualTo ace_spectator_uiVisible) exitWith {};
    
    if (ace_spectator_uiVisible) then {
        [QGVAR(onSpectatorShow), []] call CBA_fnc_localEvent;
    } else {
        [QGVAR(onSpectatorHide), []] call CBA_fnc_localEvent;
    };
    
    GVAR(oldUiVisible) = ace_spectator_uiVisible;
}] call CBA_fnc_addPerFrameHandler;