disableSerialization;
#include "script_component.hpp"
/*
 * Author: Eric
 * 3DEN function init, adds all 3den tools for cmf
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * [] execVM "functions\3den\fn_init.sqf"
 *
 * Public: No
 */
SCRIPT(init);

/* Check if menu already exists and if it does delete it */
private _ctrlMenuStrip = findDisplay 313 displayCtrl 120;
for "_i" from 0 to (_ctrlMenuStrip menuSize []) -1 step 1 do {
    if (_ctrlMenuStrip menuText [_i] isEqualTo "CMF") then {
        _ctrlMenuStrip menuDelete [_i];
    };
};

/* Set default  */
"Multiplayer" set3DENMissionAttribute ["GameType", "coop"];

/* Create CMF menu */
private _indexMain = [[], "CMF"] call cmf_3den_fnc_addMenuItem;

/* Create CMF: Mission Data */
[_indexMain] call cmf_3den_fnc_setConfig;

/* Create unit spawner menu */
private _unitMenu = [[_indexMain], LSTRING(unitSpawner_displayName), "a3\ui_f\data\igui\rscingameui\rscunitinfo\si_stand_ca.paa"] call FUNC(addMenuItem);

/* Unit sizes (fireteam, squad, platoon, Company) */
private _infantryMenu = [[_indexMain, _unitMenu], LSTRING(infantry_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_inf_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(fireteam_displayName), "FIRETEAM", "ca\ui\data\markers\n_inf.paa"] call cmf_3DEN_fnc_unitSpawner;
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(squad_displayName), "SQUAD", "ca\ui\data\markers\n_inf.paa"] call cmf_3DEN_fnc_unitSpawner;
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(platoon_displayName), "PLATOON", "ca\ui\data\markers\n_inf.paa"] call cmf_3DEN_fnc_unitSpawner;
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(company_displayName), "COMPANY", "ca\ui\data\markers\n_inf.paa"] call cmf_3DEN_fnc_unitSpawner;

/* Air Elements */
private _airMenu = [[_indexMain, _unitMenu], LSTRING(air_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_air_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _airMenu], LSTRING(light_rotary_cas_trans_displayName), "PHANTOM", "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(rotary_cas), "REAPER", "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(heavy_rotary_cas_displayName), "UGLY", "CUP\AirVehicles\CUP_AirVehicles_AH1Z\data\ui\icomap_ah1z_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(ground_attack_jet_displayName), "HAWG", "CUP\AirVehicles\CUP_AirVehicles_AV8B\data\ui\icomap_av8b_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(fighter_bomber_jet_displayName), "PAVEMENT", "CUP\AirVehicles\CUP_AirVehicles_Su25\data\ui\icomap_su25.paa"] call FUNC(unitSpawner);

/* Armor Elements */
private _armorMenu = [[_indexMain, _unitMenu], LSTRING(armor_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_armor_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _armorMenu], LSTRING(apc_displayName), "SIERRA", "CUP\WheeledVehicles\CUP_WheeledVehicles_BRDM2\data\icomap_brdm_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _armorMenu], LSTRING(ifv_displayName), "MIKE", "CUP\TrackedVehicles\CUP_TrackedVehicles_BMP\data\map_ico\icomap_bmp2_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _armorMenu], LSTRING(mbt_displayName), "TANGO", "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _armorMenu], "ANVIL (SPAAG/AAA)", "ANVIL", "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa"] call FUNC(unitSpawner);

/* Support Elements */
private _supportMenu = [[_indexMain, _unitMenu], LSTRING(support_elements_displayName), "ca\ui\data\markers\b_support.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(mortar_team_displayName), "MORTARS", "ca\ui\data\markers\n_mortar.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(recon_sniper_team_displayName), "ROMEO", "ca\ui\data\markers\n_recon.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(logistics_team_displayName), "LOGI", "ca\ui\data\markers\n_support.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(engineers_team_displayName), "ENGI", "ca\ui\data\markers\n_maint.paa"] call FUNC(unitSpawner);

/* Weapons Elements */
private _weaponsMenu = [[_indexMain, _unitMenu], LSTRING(weapons_elements_displayName), "ca\ui\data\markers\b_mortar.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(mmg_team_displayName), "MMG", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(hmg_team_displayName), "HMG", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(mat_team_displayName), "MAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(hat_team_displayName), "HAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _weaponsMenu], "DHAT (Deployed Anti-Tank, Heavy)", "DHAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unitSpawner);

/* Special Elements */
private _specialMenu = [[_indexMain, _unitMenu], LSTRING(special_elements_displayName), "ca\ui\data\markers\b_uav.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _specialMenu], LSTRING(rgr_riflesquad_displayName), "RGR_RFL_SQUAD", "ca\ui\data\markers\n_uav.paa"] call FUNC(unitSpawner);
[[_indexMain, _unitMenu, _specialMenu], LSTRING(rgr_machinegunsquad_displayName), "RGR_MG_SQUAD", "ca\ui\data\markers\n_uav.paa"] call FUNC(unitSpawner);

/* Custom unit */
[[_indexMain, _unitMenu], LSTRING(custom_unit_displayName), "UNIT", "a3\ui_f\data\gui\cfg\hints\icon_text\b_unknown_ca.paa"] call FUNC(unitSpawner);

/* Zeus unit */
[[_indexMain, _unitMenu], LSTRING(zeus_unit_displayName), "ZEUS", "a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa"] call FUNC(unitSpawner);



/* Create a tools menu */
private _toolsMenu = [[_indexMain], LSTRING(tools_displayName), "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_functions_ca.paa"] call FUNC(addMenuItem);

/* Create a general tools menu */
private _generalToolsMenu = [[_indexMain, _toolsMenu], "General", "a3\3den\data\displays\display3den\toolbar\open_ca.paa"] call FUNC(addMenuItem);

/* Add ACRE rack tool */
[[_indexMain, _toolsMenu, _generalToolsMenu], "Add Radio Rack (ACRE)", "a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa"] call FUNC(addRadioRack);

/* Toggle simulation for selected objects */
[[_indexMain, _toolsMenu, _generalToolsMenu], LSTRING(toggle_sim_3den_displayName), "a3\modules_f\data\editterrainobject\textureunchecked_wall_ca.paa", {
    { _x enableSimulation !(simulationEnabled _x); } forEach get3DENSelected "object";
}] call FUNC(addMenuItem);

/* Make simple objects and disable simulation and damage */
[[_indexMain, _toolsMenu, _generalToolsMenu], LSTRING(make_obj_simple_displayName), "z\ace\addons\zeus\ui\icon_module_zeus_editable_objects_ca.paa"] call FUNC(simplifySelectedObject);

/* Create a ACE tools menu */
private _ACEToolsMenu = [[_indexMain, _toolsMenu], "ACE3", "z\ace\addons\common\data\logo_ace3_ca.paa"] call FUNC(addMenuItem);

/* Make object draggable */
[[_indexMain, _toolsMenu, _ACEToolsMenu], "Make draggable", "z\ace\addons\dragging\ui\icons\box_drag.paa", {
    {
        if !([_x, "[this, true] call ace_dragging_fnc_setDraggable"] call FUNC(inInit)) then {            
            [_x, "[this, false] call ace_dragging_fnc_setDraggable"] call FUNC(removeFromInit);
            [_x, "[this, true] call ace_dragging_fnc_setDraggable"] call FUNC(addToInit);
        };
    } forEach get3DENSelected "object";
    ["Enabled Dragging", 0, 1] call BIS_fnc_3DENNotification;
}] call FUNC(addMenuItem);

/* Make object non-draggable */
[[_indexMain, _toolsMenu, _ACEToolsMenu], "Disable dragging", "z\ace\addons\dragging\ui\icons\box_drag.paa", {
    {
        if !([_x, "[this, false] call ace_dragging_fnc_setDraggable"] call FUNC(inInit)) then {            
            [_x, "[this, true] call ace_dragging_fnc_setDraggable"] call FUNC(removeFromInit);
            [_x, "[this, false] call ace_dragging_fnc_setDraggable"] call FUNC(addToInit);
        };
    } forEach get3DENSelected "object";
    ["Disabled Dragging", 0, 1] call BIS_fnc_3DENNotification;
}] call FUNC(addMenuItem);

/* Make object carryable */
[[_indexMain, _toolsMenu, _ACEToolsMenu], "Make carryable", "z\ace\addons\dragging\ui\icons\box_carry.paa", {
    {
        if !([_x, "[this, true] call ace_dragging_fnc_setCarryable"] call FUNC(inInit)) then {            
            [_x, "[this, false] call ace_dragging_fnc_setCarryable"] call FUNC(removeFromInit);
            [_x, "[this, true] call ace_dragging_fnc_setCarryable"] call FUNC(addToInit);
        };
    } forEach get3DENSelected "object";
    ["Enabled Carrying", 0, 1] call BIS_fnc_3DENNotification;
}] call FUNC(addMenuItem);

/* Make object non-carryable */
[[_indexMain, _toolsMenu, _ACEToolsMenu], "Disable carrying", "z\ace\addons\dragging\ui\icons\box_carry.paa", {
    {
        if !([_x, "[this, false] call ace_dragging_fnc_setCarryable"] call FUNC(inInit)) then {            
            [_x, "[this, true] call ace_dragging_fnc_setCarryable"] call FUNC(removeFromInit);
            [_x, "[this, false] call ace_dragging_fnc_setCarryable"] call FUNC(addToInit);
        };
    } forEach get3DENSelected "object";
    ["Disabled Carrying", 0, 1] call BIS_fnc_3DENNotification;
}] call FUNC(addMenuItem);

/* Create a kosherArsenal tools menu */
private _kosherArsenalToolsMenu = [[_indexMain, _toolsMenu], "Kosher Arsenal", "a3\3den\data\displays\display3den\toolbar\open_ca.paa"] call FUNC(addMenuItem);

/* Make selected objects into ammoboxes */
[[_indexMain, _toolsMenu, _kosherArsenalToolsMenu], LSTRING(make_ammobox_displayName), "a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa"] call FUNC(assignAmmobox);



/* Shortcut to lobby manager */
[[_indexMain], LSTRING(lobby_manager_displayName), "a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa", {
    call (uiNamespace getVariable 'CBA_fnc_openLobbyManager');
}] call FUNC(addMenuItem);

/* Open menu where you can view all the textures in arma */
[[_indexMain], LSTRING(iconviewer_displayName), "a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa", {
    ["onload"] call FUNC(iconViewer);
}] call FUNC(addMenuItem);

/* Report a bug with CMF */
[[_indexMain], LSTRING(report_bug), "a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", {
    createDialog "cmf_utility_reportBug";
}] call FUNC(addMenuItem);
