#include "script_component.hpp"
/*
 * Author: [Authors]
 * [Description]
 * 
 * Arguments:
 * 0: Argument <TYPE>
 * 
 * Return Value:
 * Value <TYPE>
 * 
 * Example:
 * [] call cmf_[module]_fnc_[functionName]
 * 
 * Public: [yes/no]
 */

params ["_dialog", ["_config", configNull]];

[(_dialog displayCtrl IDC_BUTTON_INFANTRY)] call FUNC(updateCategory);