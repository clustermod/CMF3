#include "script_component.hpp"
/*
 * Author: Eric
 * Toggles the HUD so players can take pictures without the HUD being visible
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_menu_fnc_toggleHUDAction
 *
 * Public: No
 */
SCRIPT(toggleHUDAction);

/* Save the default showHUD parameters */
if (isNil QGVAR(hud_default)) then {
    GVAR(hud_default) = shownHUD;
};

/* Create variable to track if HUD is hidden */
if (isNil QGVAR(hud_show)) then {
    GVAR(hud_show) = true;
};

/* Toggle the HUD */
private _staminaBarContainer = uiNamespace getVariable ["ace_advanced_fatigue_staminaBarContainer", controlNull];
if (GVAR(hud_show)) then {

    /* Hide vanilla elements */
    showHUD [false, false, false, false, false, false, false, false, false, false, false];

    /* Hide Shacktac elements */
    STHud_UIMode = 0;

    /* Hide Ace elements */
    _staminaBarContainer ctrlShow false;
    _staminaBarContainer ctrlCommit 0;

    GVAR(hud_show) = false;
} else {

    /* Show vanilla HUD */
    showHUD GVAR(hud_default);

    /* Show Shacktac elements */
    STHud_UIMode = STHud_Settings_HUDMode;

    /* Show Ace elements */
    _staminaBarContainer ctrlShow true;
    _staminaBarContainer ctrlCommit 0;

    GVAR(hud_show) = true;
};
