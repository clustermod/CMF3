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
 * [] call emf_aceMenu_fnc_toggleHUDAction
 *
 * Public: No
 */
scriptName "functions\aceMenu\fn_createMapsFixAction.sqf";
private["_fixAction"];

if (isDedicated) exitWith {};

// Check if action already exists
if !(isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","EMF_BUGACTIONS", "emf_toggleHUD"]] call ace_interact_menu_fnc_findActionNode)}) exitWith {};

// Create tracker variables
GVAR(HUD_shownHUD) = shownHUD;
GVAR(HUD_HUDStatus) = true;

// Code to toggle HUD
private _toggleHUDActionCode = {
    private _staminaBarContainer = uiNamespace getVariable ["ace_advanced_fatigue_staminaBarContainer", controlNull];
    if (GVAR(HUD_HUDStatus)) then {
        // Vanilla
        showHUD [false, false, false, false, false, false, false, false, false, false, false];
        // Shacktac UI
        STHud_UIMode = 0;
        // ACE Fatigue
        _staminaBarContainer ctrlShow false;
        _staminaBarContainer ctrlCommit 0;

        GVAR(HUD_HUDStatus) = false;
    } else {
        showHUD GVAR(HUD_shownHUD);
        STHud_UIMode = STHud_Settings_HUDMode;
        _staminaBarContainer ctrlShow true;
        _staminaBarContainer ctrlCommit 0;

        GVAR(HUD_HUDStatus) = true;
    };
};

// Create ace action
private _hudAction = ["emf_toggleHUD", "Toggle HUD", "rsc\data\icon_viewDistance_ca.paa", _toggleHUDActionCode, {true}] call ace_interact_menu_fnc_createAction;
[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _hudAction] call ace_interact_menu_fnc_addActionToClass;

// Create keybind
["EMF", "emf_toggleHUD", ["Toggle HUD", "Toggles HUD so you can take pretty screenshots :)"], {}, _toggleHUDActionCode, [15, [false, true, false]]] call CBA_fnc_addKeybind;
