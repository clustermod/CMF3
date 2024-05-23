#include "script_component.hpp"

[QUOTE(FRAMEWORK: Common), QGVAR(toggleHUD), [LSTRING(toggle_hud_displayname), LSTRING(toggle_hud_tooltip)], {}, {
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
    if GVAR(hud_show) then {

        GVAR(hud_show) = false;

        /* Hide vanilla elements */
        showHUD [false, false, false, false, false, false, false, false, false, false, false];

        /* Hide Shacktac elements */
        GVAR(hud_STUI_UIMode) = STHud_Settings_HUDMode;
        GVAR(hud_STUI_nametags) = STNT_Settings_Enabled;
        GVAR(hud_STUI_groupIndicators) = STGI_Settings_Enabled;
        STHud_UIMode = 0;
        STNT_Enabled = false;
        STGI_Enabled = false;

        /* Hide Ace elements */
        _staminaBarContainer ctrlShow false;
        _staminaBarContainer ctrlCommit 0;
        GVAR(hud_ace_nametags) = ace_nametags_showPlayerNames;
        ace_nametags_showPlayerNames = 0;
        call ace_nametags_fnc_updateSettings;

        /* Hide ACRE PAX */ // This code needs refactoring
        [] spawn {
            while { !GVAR(hud_show) && { !isnull objectParent player } } do {
                ("acre_sys_gui_vehicleInfo" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
                sleep 0.01;
            };

            if (!isNull objectParent player) then {
                [true] call acre_sys_gui_fnc_showVehicleInfo;
            };
        };


        /* Raise event */
        [QGVAR(onHUDHidden), []] call CBA_fnc_localEvent;
    } else {

        GVAR(hud_show) = true;

        /* Show vanilla HUD */
        showHUD GVAR(hud_default);

        /* Show Shacktac elements */
        STHud_UIMode = GVAR(hud_STUI_UIMode);
        STNT_Enabled = GVAR(hud_STUI_nametags);
        STGI_Enabled = GVAR(hud_STUI_groupIndicators);

        /* Show Ace elements */
        _staminaBarContainer ctrlShow true;
        _staminaBarContainer ctrlCommit 0;
        ace_nametags_showPlayerNames = GVAR(hud_ace_nametags);
        call ace_nametags_fnc_updateSettings;

        /* Raise event */
        [QGVAR(onHUDShown), []] call CBA_fnc_localEvent;
    };
}, [15, [false, true, false]]] call EFUNC(common,addKeybind);