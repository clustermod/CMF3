#include "script_component.hpp"

[   /* Set Lives */
    QUOTE(FRAMEWORK: Respawn),
    LSTRING(setLives),
    FUNC(setLives),
    QPATHTOF(data\icon_module_setLives_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Force Kosher Arsenal */
    QUOTE(FRAMEWORK: Kosher Arsenal),
    LSTRING(forceArsenal),
    FUNC(forceArsenal),
    QPATHTOF(data\icon_module_kosherArsenal_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Set ammobox */
    QUOTE(FRAMEWORK: Kosher Arsenal),
    LSTRING(setAmmobox),
    FUNC(setAmmobox),
    QPATHTOF(data\icon_module_ammobox_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Set Unit Parameters */
    QUOTE(FRAMEWORK: Respawn),
    LSTRING(setUnitParameters),
    FUNC(setUnitParameters),
    ""
] call zen_custom_modules_fnc_register;

[   /* Force Close Kosher Arsenal */
    QUOTE(FRAMEWORK: Kosher Arsenal),
    LSTRING(forceCloseArsenal),
    FUNC(forceCloseArsenal),
    QPATHTOF(data\icon_module_closeKosherArsenal_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Toggle Freezetime */
    QUOTE(FRAMEWORK: Common),
    LSTRING(toggleFreezeTime),
    FUNC(toggleFreezeTime),
    QPATHTOF(data\icon_module_disableSetDate_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Toggle spectator */
    QUOTE(FRAMEWORK: Common), 
    LSTRING(toggleSpectator), 
    FUNC(toggleSpectator),
    QPATHTOF(data\icon_module_spectate_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Enable rallypoints */
    QUOTE(FRAMEWORK: Respawn),
    LSTRING(enableRallypoints),
    FUNC(enableRallypoints),
    QPATHTOEF(respawn,data\icon_ace_rallypoint_place_ca.paa)
] call zen_custom_modules_fnc_register;

[   /* Disable rallypoints */
    QUOTE(FRAMEWORK: Respawn),
    LSTRING(disableRallypoints),
    FUNC(disableRallypoints),
    QPATHTOEF(respawn,data\icon_ace_rallypoint_disabled_ca.paa)
] call zen_custom_modules_fnc_register;

[
    QUOTE(FRAMEWORK: Safestart),
    "Set Phase",
    FUNC(setPhase),
    ""
] call zen_custom_modules_fnc_register;

[
    QUOTE(FRAMEWORK: Safestart),
    "Add Cutoff Phase",
    FUNC(addCutoffPhase),
    ""
] call zen_custom_modules_fnc_register;

[
    QUOTE(FRAMEWORK: Safestart),
    "Remove Cutoff Phase",
    FUNC(removeCutoffPhase),
    ""
] call zen_custom_modules_fnc_register;

[   /* Set Random Loadout */
    QUOTE(FRAMEWORK: Kosher Arsenal),
    "Set Random Loadout",
    FUNC(randomLoadout),
    "a3\ui_f\data\gui\rsc\rscdisplayarsenal\uniform_ca.paa"
] call zen_custom_modules_fnc_register;

[   /* Set Crate Loadout */
    QUOTE(FRAMEWORK: Logistics),
    "Set Crate Loadout",
    FUNC(setCrateLoadout),
    "a3\ui_f\data\map\vehicleicons\iconcrateord_ca.paa"
] call zen_custom_modules_fnc_register;

call FUNC(playerInfo);

GVAR(zeusInfoShow) = true;

/* curator displayInit */
[IDD_ZEUS, FUNC(initDisplayCurator)] call EFUNC(common,displayAddInitEvent);

[QGVAR(toggleZeusInfo), {
    GVAR(zeusInfoShow) = !GVAR(zeusInfoShow);
}] call CBA_fnc_addEventHandler;

/* Show icon for rallypoints and artillery */
addMissionEventHandler ["Draw3D", {
    if (isNull curatorCamera || !GVAR(zeusInfoShow)) exitWith {};
    
    {
        drawIcon3D [getMissionPath "components\respawn\data\icon_ace_rallypoint_place_ca.paa", [1,1,1,0.7], ASLToAGL getPosASLVisual _x, 0.5, 0.5, 0];
    } forEach EGVAR(respawn,rallypoints);

    {
        _x params ["_side", "_target", "_mainSalvo"];
        drawIcon3D ["a3\ui_f\data\gui\cfg\communicationmenu\artillery_ca.paa", [1,1,1,0.7], _target, 0.5, 0.5, 0, format ["Fire Mission (%1): %2", _side, _mainSalvo]];
    } forEach EGVAR(ai,artilleryTargets);
}];