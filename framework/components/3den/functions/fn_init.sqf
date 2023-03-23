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
private _indexMain = [[], "CMF"] call FUNC(addMenuItem);

/* Create CMF: Mission Data */
[_indexMain] call FUNC(main_setConfig);

/* Create unit spawner menu */
private _unitMenu = [[_indexMain], LSTRING(unit_spawner_displayName), "a3\ui_f\data\igui\rscingameui\rscunitinfo\si_stand_ca.paa"] call FUNC(addMenuItem);

/* Unit sizes (fireteam, squad, platoon, Company) */
private _infantryMenu = [[_indexMain, _unitMenu], LSTRING(infantry_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_inf_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(fireteam_displayName), "FIRETEAM", "ca\ui\data\markers\n_inf.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(squad_displayName), "SQUAD", "ca\ui\data\markers\n_inf.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(platoon_displayName), "PLATOON", "ca\ui\data\markers\n_inf.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _infantryMenu], LSTRING(company_displayName), "COMPANY", "ca\ui\data\markers\n_inf.paa"] call FUNC(unit_spawner);

/* Air Elements */
private _airMenu = [[_indexMain, _unitMenu], LSTRING(air_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_air_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _airMenu], LSTRING(light_rotary_cas_trans_displayName), "PHANTOM", "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(rotary_cas), "REAPER", "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(heavy_rotary_cas_displayName), "UGLY", "CUP\AirVehicles\CUP_AirVehicles_AH1Z\data\ui\icomap_ah1z_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(ground_attack_jet_displayName), "HAWG", "CUP\AirVehicles\CUP_AirVehicles_AV8B\data\ui\icomap_av8b_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _airMenu], LSTRING(fighter_bomber_jet_displayName), "PAVEMENT", "CUP\AirVehicles\CUP_AirVehicles_Su25\data\ui\icomap_su25.paa"] call FUNC(unit_spawner);

/* Armor Elements */
private _armorMenu = [[_indexMain, _unitMenu], LSTRING(armor_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_armor_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _armorMenu], LSTRING(apc_displayName), "SIERRA", "CUP\WheeledVehicles\CUP_WheeledVehicles_BRDM2\data\icomap_brdm_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _armorMenu], LSTRING(ifv_displayName), "MIKE", "CUP\TrackedVehicles\CUP_TrackedVehicles_BMP\data\map_ico\icomap_bmp2_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _armorMenu], LSTRING(mbt_displayName), "TANGO", "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _armorMenu], "ANVIL (SPAAG/AAA)", "ANVIL", "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa"] call FUNC(unit_spawner);

/* Support Elements */
private _supportMenu = [[_indexMain, _unitMenu], LSTRING(support_elements_displayName), "ca\ui\data\markers\b_support.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(mortar_team_displayName), "MORTARS", "ca\ui\data\markers\n_mortar.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(recon_sniper_team_displayName), "ROMEO", "ca\ui\data\markers\n_recon.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(logistics_team_displayName), "LOGI", "ca\ui\data\markers\n_support.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _supportMenu], LSTRING(engineers_team_displayName), "ENGI", "ca\ui\data\markers\n_maint.paa"] call FUNC(unit_spawner);

/* Weapons Elements */
private _weaponsMenu = [[_indexMain, _unitMenu], LSTRING(weapons_elements_displayName), "ca\ui\data\markers\b_mortar.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(mmg_team_displayName), "MMG", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(hmg_team_displayName), "HMG", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(mat_team_displayName), "MAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _weaponsMenu], LSTRING(hat_team_displayName), "HAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _weaponsMenu], "DHAT (Deployed Anti-Tank, Heavy)", "DHAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(unit_spawner);

/* Special Elements */
private _specialMenu = [[_indexMain, _unitMenu], LSTRING(special_elements_displayName), "ca\ui\data\markers\b_uav.paa"] call FUNC(addMenuItem);
[[_indexMain, _unitMenu, _specialMenu], LSTRING(rgr_riflesquad_displayName), "RGR_RFL_SQUAD", "ca\ui\data\markers\n_uav.paa"] call FUNC(unit_spawner);
[[_indexMain, _unitMenu, _specialMenu], LSTRING(rgr_machinegunsquad_displayName), "RGR_MG_SQUAD", "ca\ui\data\markers\n_uav.paa"] call FUNC(unit_spawner);

/* Custom unit */
[[_indexMain, _unitMenu], LSTRING(custom_unit_displayName), "UNIT", "a3\ui_f\data\gui\cfg\hints\icon_text\b_unknown_ca.paa"] call FUNC(unit_spawner);

/* Zeus unit */
[[_indexMain, _unitMenu], LSTRING(zeus_unit_displayName), "ZEUS", "a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa"] call FUNC(unit_spawner);



/* = ENTITY TOOLS = */
private _toolsMenu = [[_indexMain], LSTRING(tools_displayName), 
    "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_functions_ca.paa"] call FUNC(addMenuItem);

/* General */
private _generalToolsMenu = [[_indexMain, _toolsMenu], "General", 
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa"] call FUNC(addMenuItem);

[[_indexMain, _toolsMenu, _generalToolsMenu], "Add Radio Rack (ACRE)", 
    "a3\ui_f\data\gui\rsc\rscdisplayarsenal\radio_ca.paa"] call FUNC(entity_acre_rack);

[[_indexMain, _toolsMenu, _generalToolsMenu], LSTRING(toggle_sim_3den_displayName), 
    "a3\modules_f\data\editterrainobject\textureunchecked_wall_ca.paa"] call FUNC(entity_simulation);

[[_indexMain, _toolsMenu, _generalToolsMenu], LSTRING(make_obj_simple_displayName), 
    "z\ace\addons\zeus\ui\icon_module_zeus_editable_objects_ca.paa"] call FUNC(entity_simplify);


/* ACE */
private _ACEToolsMenu = [[_indexMain, _toolsMenu], "ACE3", 
    "z\ace\addons\common\data\logo_ace3_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _toolsMenu, _ACEToolsMenu], "Toggle ACE Carryable"] call FUNC(entity_ace_carry);
[[_indexMain, _toolsMenu, _ACEToolsMenu], "Toggle ACE Draggable"] call FUNC(entity_ace_drag);


/* Kosher Arsenal */
private _kosherArsenalToolsMenu = [[_indexMain, _toolsMenu], "Kosher Arsenal", 
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _toolsMenu, _kosherArsenalToolsMenu], LSTRING(make_ammobox_displayName), 
    "a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa"] call FUNC(entity_kosherArsenal_ammobox);


/* Logistics */
private _logisticsToolsMenu = [[_indexMain, _toolsMenu], "Logistics", 
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _toolsMenu, _logisticsToolsMenu]] call FUNC(entity_logistics_supplyCrates);


/* AI */
private _aiToolsMenu = [[_indexMain, _toolsMenu], "AI", 
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa"] call FUNC(addMenuItem);
[[_indexMain, _toolsMenu, _aiToolsMenu], "Toggle preventProne"] call FUNC(entity_ai_preventProne);


/* Shortcut to lobby manager */
[[_indexMain], LSTRING(lobby_manager_displayName), "a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa", {
    call (uiNamespace getVariable 'CBA_fnc_openLobbyManager');
}] call FUNC(addMenuItem);

/* Open menu where you can view all the textures in arma */
[[_indexMain], LSTRING(iconviewer_displayName), "a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa", {
    ["onload"] call FUNC(main_iconViewer);
}] call FUNC(addMenuItem);

/* Report a bug with CMF */
[[_indexMain], LSTRING(report_bug), "a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", {
    createDialog "cmf_utility_reportBug";
}] call FUNC(addMenuItem);
