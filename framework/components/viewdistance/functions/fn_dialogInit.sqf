#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes viewdistance dialog
 * 
 * Arguments:
 * 0: Dialog <DIALOG>
 * 1: Config <CONFIG>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_viewdistance_fnc_dialogInit
 * 
 * Public: No
 */

params ["_dialog", ["_config", configNull]];

[(_dialog displayCtrl IDC_BUTTON_INFANTRY)] call FUNC(updateCategory);