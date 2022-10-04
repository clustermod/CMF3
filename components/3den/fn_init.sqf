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

/* Include custom functions */
#include "fn_unitConstructor.sqf"
#include "fn_unitSpawner.sqf"
#include "fn_iconViewer.sqf"

/* Define the string localize function */
EFUNC(main,localize) = compile preprocessFileLineNumbers QUOTE(PATHTO_SYS(main,fn_localize));

/* Creates menu in top bar */
disableSerialization;

/* Check if menu already exists and if it does delete it */
private _ctrlMenuStrip = findDisplay 313 displayCtrl 120;
for "_i" from 0 to (_ctrlMenuStrip menuSize []) -1 step 1 do {
    if (_ctrlMenuStrip menuText [_i] isEqualTo "CMF") then {
        _ctrlMenuStrip menuDelete [_i];
    };
};

/* Create CMF menu */
private _indexMain = _ctrlMenuStrip menuAdd [[], "CMF"];

/* Create unit spawner menu */
private _unitSpawner = _ctrlMenuStrip menuAdd [[_indexMain], LSTRING(unitSpawner_displayName)];

/* Unit sizes (fireteam, squad, platoon, Company) */
private _unitSizes = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(infantry_elements_displayName)];
private _fireteamSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes], LSTRING(fireteam_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _fireteamSpawner], "[""FIRETEAM""] spawn cmf_3den_fnc_unitSpawner"];
private _squadSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes], LSTRING(squad_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _squadSpawner], "[""SQUAD""] spawn cmf_3den_fnc_unitSpawner"];
private _platoonSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes], LSTRING(platoon_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _platoonSpawner], "[""PLATOON""] spawn cmf_3den_fnc_unitSpawner"];
private _CompanySpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes], LSTRING(company_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _CompanySpawner], "[""COMPANY""] spawn cmf_3den_fnc_unitSpawner"];

/* Air Elements */
private _airUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(air_elements_displayName)];
private _phantomSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits], LSTRING(light_rotary_cas_trans_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _phantomSpawner], "[""PHANTOM""] spawn cmf_3den_fnc_unitSpawner"];
private _reaperSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits], LSTRING(rotary_cas)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _reaperSpawner], "[""REAPER""] spawn cmf_3den_fnc_unitSpawner"];
private _uglySpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits], LSTRING(heavy_rotary_cas_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _uglySpawner], "[""UGLY""] spawn cmf_3den_fnc_unitSpawner"];
private _hawgSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits], LSTRING(ground_attack_jet_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _hawgSpawner], "[""HAWG""] spawn cmf_3den_fnc_unitSpawner"];
private _pavementSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits], LSTRING(fighter_bomber_jet_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _pavementSpawner], "[""PAVEMENT""] spawn cmf_3den_fnc_unitSpawner"];

/* Armor Elements */
private _armorUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(armor_elements_displayName)];
private _sierraSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _armorUnits], LSTRING(apc_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _armorUnits, _sierraSpawner], "[""SIERRA""] spawn cmf_3den_fnc_unitSpawner"];
private _mikeSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _armorUnits], LSTRING(ifv_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _armorUnits, _mikeSpawner], "[""MIKE""] spawn cmf_3den_fnc_unitSpawner"];
private _tangoSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _armorUnits], LSTRING(mbt_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _armorUnits, _tangoSpawner], "[""TANGO""] spawn cmf_3den_fnc_unitSpawner"];

/* Support Elements */
private _supportUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(support_elements_displayName)];
private _mortarsSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits], LSTRING(mortar_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _mortarsSpawner], "[""MORTARS""] spawn cmf_3den_fnc_unitSpawner"];
private _romeoSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits], LSTRING(recon_sniper_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _romeoSpawner], "[""ROMEO""] spawn cmf_3den_fnc_unitSpawner"];
private _logiSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits], LSTRING(logistics_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _logiSpawner], "[""LOGI""] spawn cmf_3den_fnc_unitSpawner"];
private _engiSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits], LSTRING(engineers_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _engiSpawner], "[""ENGI""] spawn cmf_3den_fnc_unitSpawner"];

/* Weapons Elements */
private _weaponUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(weapons_elements_displayName)];
private _mmgSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits], LSTRING(mmg_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _mmgSpawner], "[""MMG""] spawn cmf_3den_fnc_unitSpawner"];
private _hmgSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits], LSTRING(hmg_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _hmgSpawner], "[""HMG""] spawn cmf_3den_fnc_unitSpawner"];
private _matSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits], LSTRING(mat_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _matSpawner], "[""MAT""] spawn cmf_3den_fnc_unitSpawner"];
private _hatSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits], LSTRING(hat_team_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _hatSpawner], "[""HAT""] spawn cmf_3den_fnc_unitSpawner"];

/* Special Elements */
private _specialUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(special_elements_displayName)];
private _rgrRifleSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _specialUnits], LSTRING(rgr_riflesquad_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _specialUnits, _rgrRifleSpawner], "[""RGR_RFL_SQUAD""] spawn cmf_3den_fnc_unitSpawner"];
private _rgrMGSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _specialUnits], LSTRING(rgr_machinegunsquad_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _specialUnits, _rgrMGSpawner], "[""RGR_MG_SQUAD""] spawn cmf_3den_fnc_unitSpawner"];

/* Custom unit */
private _singleUnit = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(custom_unit_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _singleUnit], "[""UNIT""] spawn cmf_3den_fnc_unitSpawner"];

/* Zeus unit */
private _zeusUnit = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner], LSTRING(zeus_unit_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _zeusUnit], "[""ZEUS""] spawn cmf_3den_fnc_unitSpawner"];

/* Create a tools menu */
private _tools = _ctrlMenuStrip menuAdd [[_indexMain], LSTRING(tools_displayName)];

/* Enable simulation for selected objects */
private _3denSimulationEn = _ctrlMenuStrip menuAdd [[_indexMain, _tools], LSTRING(enable_sim_3den_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _tools, _3denSimulationEn], "{ _x enableSimulation true; } forEach get3DENSelected ""object"""];

/* Disable simulation for selected objects */
private _3denSimulationDis = _ctrlMenuStrip menuAdd [[_indexMain, _tools], LSTRING(disable_sim_3den_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _tools, _3denSimulationDis], "{ _x enableSimulation false; } forEach get3DENSelected ""object"""];

/* Make simple objects and disable simulation and damage */
private _simpleObj = _ctrlMenuStrip menuAdd [[_indexMain, _tools], LSTRING(make_obj_simple_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _tools, _simpleObj], "
    {
        _x set3DENAttribute [""enableSimulation"", false];
        _x set3DENAttribute [""allowDamage"", false];
        _x set3DENAttribute [""Init"", ""
            this spawn {
              private _obj = createSimpleObject[(typeof _this), (getposASL _this), false];
              _obj setVectorDirAndUp [(vectorDir _this), (vectorUp _this)];
              deleteVehicle _this;
            }
        ""];

    } forEach get3DENSelected ""object"""
];

/* Make selected objects into ammoboxes */
private _3denSimulationDis = _ctrlMenuStrip menuAdd [[_indexMain, _tools], LSTRING(make_ammobox_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _tools, _3denSimulationDis], "{ _x set3DENAttribute [""Init"", ""[this] call cmf_kosherArsenal_fnc_ammobox;""]; } forEach get3DENSelected ""object"""];

/* Shortcut to lobby manager */
private _lobbyManager = _ctrlMenuStrip menuAdd [[_indexMain], LSTRING(lobby_manager_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _lobbyManager], "call (uiNamespace getVariable 'CBA_fnc_openLobbyManager')"];

/* Open menu where you can view all the textures in arma */
private _iconViewer = _ctrlMenuStrip menuAdd [[_indexMain], LSTRING(iconviewer_displayName)];
_ctrlMenuStrip menuSetAction [[_indexMain, _iconViewer], "[""onload""] call cmf_3den_fnc_iconViewer;"];
