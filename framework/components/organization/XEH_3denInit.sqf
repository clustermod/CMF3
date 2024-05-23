#include "script_component.hpp"

/* NATO Phonetic alphabet */
GVAR(phoneticAlphabet) = ["Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", 
    "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whisky", "Xray", "Yankee", "Zulu"];

/* Create groups hash for dynamic group system */
if (isNil QGVAR(groups)) then {
    GVAR(groups) = [[
        [west, [] call CBA_fnc_hashCreate],
        [east, [] call CBA_fnc_hashCreate],
        [independent, [] call CBA_fnc_hashCreate],
        [civilian, [] call CBA_fnc_hashCreate]
    ]] call CBA_fnc_hashCreate;
};

/* Parse Orbat */
if (isNil QGVAR(orbat)) then {
    private _orbat = call compile preprocessFileLineNumbers "rsc\organization\orbat.sqf";
    _orbat = [_orbat] call FUNC(parseOrbat);
    GVAR(orbat) = _orbat;
};

/* Register old groups */
{
    _group = _x;
    _init = (_group get3DENAttribute "Init") select 0;

    _groupDataString = _init regexFind [";*(\[.*?\][^,]).*?cmf_organization_fnc_groupRegister;*"];
    _groupDataString = (((_groupDataString select 0) select 1) select 0);

    if (!isNil "_groupDataString") then {
        _groupDataString = _groupDataString regexReplace ["this", "grpNull"];
        _groupData = call compile _groupDataString;
        if (!isNil "_groupData") then {
            _groupData set [0, _x];
            _groupData call FUNC(groupRegister);
        };
    };
} forEach (all3DENEntities select 1);

/* Unregister deleted groups */
addMissionEventHandler ["GroupDeleted", {
    params ["_group"];

    if ([_group] call FUNC(groupIsRegistered)) then {
        [_group] call FUNC(groupUnregister);
        call FUNC(groupReorganize);
    };
}];

/* Reorganize groups */
call FUNC(groupReorganize);

waitUntil { !isNil QEGVAR(3den,menu_unit) };

private _path = EGVAR(3den,menu_unit);

/* Unit sizes (fireteam, squad, platoon, Company) */
private _infantryMenu = [_path, LSTRING(infantry_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_inf_ca.paa"] call EFUNC(3den,addMenuItem);
[_path + [_infantryMenu], LSTRING(fireteam_displayName), "FIRETEAM", "ca\ui\data\markers\n_inf.paa"] call FUNC(3denUnitSpawner);
[_path + [_infantryMenu], LSTRING(squad_displayName), "SQUAD", "ca\ui\data\markers\n_inf.paa"] call FUNC(3denUnitSpawner);
[_path + [_infantryMenu], LSTRING(platoon_displayName), "PLATOON", "ca\ui\data\markers\n_inf.paa"] call FUNC(3denUnitSpawner);
[_path + [_infantryMenu], LSTRING(company_displayName), "COMPANY", "ca\ui\data\markers\n_inf.paa"] call FUNC(3denUnitSpawner);

/* Air Elements */
private _airMenu = [_path, LSTRING(air_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_air_ca.paa"] call EFUNC(3den,addMenuItem);
[_path + [_airMenu], LSTRING(light_rotary_cas_trans_displayName), "PHANTOM", "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_airMenu], LSTRING(rotary_cas), "REAPER", "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_airMenu], LSTRING(heavy_rotary_cas_displayName), "UGLY", "CUP\AirVehicles\CUP_AirVehicles_AH1Z\data\ui\icomap_ah1z_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_airMenu], LSTRING(ground_attack_jet_displayName), "HAWG", "CUP\AirVehicles\CUP_AirVehicles_AV8B\data\ui\icomap_av8b_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_airMenu], LSTRING(fighter_bomber_jet_displayName), "PAVEMENT", "CUP\AirVehicles\CUP_AirVehicles_Su25\data\ui\icomap_su25.paa"] call FUNC(3denUnitSpawner);

/* Armor Elements */
private _armorMenu = [_path, LSTRING(armor_elements_displayName), "a3\ui_f\data\gui\cfg\hints\icon_text\b_armor_ca.paa"] call EFUNC(3den,addMenuItem);
[_path + [_armorMenu], LSTRING(apc_displayName), "SIERRA", "CUP\WheeledVehicles\CUP_WheeledVehicles_BRDM2\data\icomap_brdm_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_armorMenu], LSTRING(ifv_displayName), "MIKE", "CUP\TrackedVehicles\CUP_TrackedVehicles_BMP\data\map_ico\icomap_bmp2_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_armorMenu], LSTRING(mbt_displayName), "TANGO", "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa"] call FUNC(3denUnitSpawner);
[_path + [_armorMenu], "ANVIL (SPAAG/AAA)", "ANVIL", "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa"] call FUNC(3denUnitSpawner);

/* Support Elements */
private _supportMenu = [_path, LSTRING(support_elements_displayName), "ca\ui\data\markers\b_support.paa"] call EFUNC(3den,addMenuItem);
[_path + [_supportMenu], LSTRING(mortar_team_displayName), "MORTARS", "ca\ui\data\markers\n_mortar.paa"] call FUNC(3denUnitSpawner);
[_path + [_supportMenu], LSTRING(recon_sniper_team_displayName), "ROMEO", "ca\ui\data\markers\n_recon.paa"] call FUNC(3denUnitSpawner);
[_path + [_supportMenu], LSTRING(logistics_team_displayName), "LOGI", "ca\ui\data\markers\n_support.paa"] call FUNC(3denUnitSpawner);
[_path + [_supportMenu], LSTRING(engineers_team_displayName), "ENGI", "ca\ui\data\markers\n_maint.paa"] call FUNC(3denUnitSpawner);

/* Weapons Elements */
private _weaponsMenu = [_path, LSTRING(weapons_elements_displayName), "ca\ui\data\markers\b_mortar.paa"] call EFUNC(3den,addMenuItem);
[_path + [_weaponsMenu], LSTRING(mmg_team_displayName), "MMG", "ca\ui\data\markers\n_unknown.paa"] call FUNC(3denUnitSpawner);
[_path + [_weaponsMenu], LSTRING(hmg_team_displayName), "HMG", "ca\ui\data\markers\n_unknown.paa"] call FUNC(3denUnitSpawner);
[_path + [_weaponsMenu], LSTRING(mat_team_displayName), "MAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(3denUnitSpawner);
[_path + [_weaponsMenu], LSTRING(hat_team_displayName), "HAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(3denUnitSpawner);
[_path + [_weaponsMenu], "DHAT (Deployed Anti-Tank, Heavy)", "DHAT", "ca\ui\data\markers\n_unknown.paa"] call FUNC(3denUnitSpawner);

/* Special Elements */
private _specialMenu = [_path, LSTRING(special_elements_displayName), "ca\ui\data\markers\b_uav.paa"] call EFUNC(3den,addMenuItem);
[_path + [_specialMenu], LSTRING(rgr_riflesquad_displayName), "RGR_RFL_SQUAD", "ca\ui\data\markers\n_uav.paa"] call FUNC(3denUnitSpawner);
[_path + [_specialMenu], LSTRING(rgr_machinegunsquad_displayName), "RGR_MG_SQUAD", "ca\ui\data\markers\n_uav.paa"] call FUNC(3denUnitSpawner);

/* Custom unit */
[_path, LSTRING(custom_unit_displayName), "UNIT", "a3\ui_f\data\gui\cfg\hints\icon_text\b_unknown_ca.paa"] call FUNC(3denUnitSpawner);

/* Zeus unit */
[_path, LSTRING(zeus_unit_displayName), "ZEUS", "a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa"] call FUNC(3denUnitSpawner);

/* Add Situation to mission overview */
private _warno = call compile preprocessFileLineNumbers "WARNO.sqf";
private _missionSituation = (_warno select 1) splitString toString [10, 13];
private _startIndex = _missionSituation findIf { toUpper "## Description" in toUpper _x };
private _stopIndex = _missionSituation findIf { toUpper "## Situation Overview" in toUpper _x };

_missionSituation = (_missionSituation select [_startIndex + 1, _stopIndex - 1]) joinString toString [10, 13];

/* Cleanup text */
_missionSituation = _missionSituation regexReplace ["<!--[^>]*-->", ""];
_missionSituation = _missionSituation regexReplace ["\*\*([\S\s]*?)\*\*", "$1"];
_missionSituation = _missionSituation regexReplace ["\*([\S\s]*?)\*", "$1"];
_missionSituation = _missionSituation regexReplace ["\n# (.*?)\n", endl + "$1" + endl];
_missionSituation = _missionSituation regexReplace ["\n## (.*?)\n", endl + "$1" + endl];
_missionSituation = _missionSituation regexReplace ["\n### (.*?)\n", endl + "$1" + endl];
_missionSituation = _missionSituation regexReplace ["\n- ", endl + "• "];
_missionSituation = _missionSituation regexReplace ["\\(.)", "$1"];
_missionSituation = _missionSituation regexReplace ["<br>", endl];
_missionSituation = _missionSituation regexReplace ["<br/>", endl];

set3DENMissionAttributes [
    ["Scenario", "OverviewText", _missionSituation],
    ["Scenario", "OverviewTextLocked", _missionSituation],
    ["Scenario", "OnLoadMission", _missionSituation]
];