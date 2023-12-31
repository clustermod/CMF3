#include "script_component.hpp"
/*
 * Defines spawnable units for 3den unit spawner
 */

// @TODO: Complete implementation of this to replace old unitConstructor
[
    ["INFANTRY", [
        "Infantry Elements",
        "a3\ui_f\data\gui\cfg\hints\icon_text\b_inf_ca.paa",
        [
            ["FIRETEAM", {
                _prettyName = "Fireteam";
                _icon = "ca\ui\data\markers\n_inf.paa";
                _level = 0;
                _type = "INF";
                _units = [
                    ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                    ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                    ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                    ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                    ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
                ];
                _subGroups = [];
            }],

            ["SQUAD", {
                _prettyName = "Squad";
                _icon = "ca\ui\data\markers\n_inf.paa";
                _level = 1;
                _type = "INF";
                _units = [
                    ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                    ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
                ];
                _subGroups = [
                    [["INFANTRY", "FIRETEAM"], 2]
                ];
            }],

            ["PLATOON", {
                _prettyName = "Platoon";
                _icon = "ca\ui\data\markers\n_inf.paa";
                _level = 2;
                _type = "INF";
                _units = [
                    ["B_officer_F", "Platoon Leader", "PL", "LIEUTENANT", true, 0, 0],
                    ["B_officer_F", "Platoon Sergeant", "PS", "LIEUTENANT", false, -1, 0],
                    ["B_medic_F", "Platoon Medic", "MED", "LIEUTENANT", false, -2, 0]
                ];
                _subGroups = [
                    [["INFANTRY", "SQUAD"], 3]
                ];
            }],

            ["COMPANY", {
                _prettyName = "Company";
                _icon = "ca\ui\data\markers\n_inf.paa";
                _level = 3;
                _type = "INF";
                _units = [
                    ["B_officer_F", "Platoon Leader", "PL", "LIEUTENANT", true, 0, 0],
                    ["B_officer_F", "Platoon Sergeant", "PS", "LIEUTENANT", false, -1, 0],
                    ["B_medic_F", "Platoon Medic", "MED", "LIEUTENANT", false, -2, 0]
                ];
                _subGroups = [
                    [["INFANTRY", "PLATOON"], 3]
                ];
            }]
        ]
    ]],

    ["AIR", [
        "Air Elements",
        "a3\ui_f\data\gui\cfg\hints\icon_text\b_air_ca.paa",
        [
            ["PHANTOM", {
                _prettyName = "Phantom (Light Rotary CAS/Trans)";
                _icon = "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa";
                _level = 3;
                _type = "TRANS";
                _units = [
                    ["B_Helipilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0],
                    ["B_helicrew_F", "Co-Pilot", "PILOT", "LIEUTENANT", false, -1, 0]
                ];
                _subGroups = [];
            }],

            ["REAPER", {
                _prettyName = "Reaper (Rotary CAS)";
                _icon = "CUP\AirVehicles\CUP_AirVehicles_AH6\data\ui\icon_mh6j_ca.paa";
                _level = 3;
                _type = "LCAS";
                _units = [
                    ["B_Helipilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0],
                    ["B_helicrew_F", "Co-Pilot", "PILOT", "LIEUTENANT", false, -1, 0]
                ];
                _subGroups = [];
            }],

            ["UGLY", {
                _prettyName = "Ugly (Heavy Rotary CAS)";
                _icon = "CUP\AirVehicles\CUP_AirVehicles_AH1Z\data\ui\icomap_ah1z_ca.paa";
                _level = 3;
                _type = "HCAS";
                _units = [
                    ["B_Helipilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0],
                    ["B_helicrew_F", "Co-Pilot", "PILOT", "LIEUTENANT", false, -1, 0]
                ];
                _subGroups = [];
            }],

            ["HAWG", {
                _prettyName = "Hawg (Ground-Attack Jet)";
                _icon = "CUP\AirVehicles\CUP_AirVehicles_AV8B\data\ui\icomap_av8b_ca.paa";
                _level = 3;
                _type = "FWCAS";
                _units = [
                    ["B_Fighter_Pilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0]
                ];
                _subGroups = [];
            }],

            ["PAVEMENT", {
                _prettyName = "Pavement (Fighter / Bomber Jet)";
                _icon = "CUP\AirVehicles\CUP_AirVehicles_Su25\data\ui\icomap_su25.paa";
                _level = 3;
                _type = "BOMBER";
                _units = [
                    ["B_Fighter_Pilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0]
                ];
                _subGroups = [];
            }]
        ]
    ]],

    ["GROUND", [
        "Armor Elements",
        "a3\ui_f\data\gui\cfg\hints\icon_text\b_armor_ca.paa",
        [
            ["SIERRA", {
                _prettyName = "Sierra (APC/MECH)";
                _icon = "CUP\WheeledVehicles\CUP_WheeledVehicles_BRDM2\data\icomap_brdm_ca.paa";
                _level = 2;
                _type = "APC";
                _units = [
                    ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                    ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                    ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["MIKE", {
                _prettyName = "Mike (IFV)";
                _icon = "CUP\TrackedVehicles\CUP_TrackedVehicles_BMP\data\map_ico\icomap_bmp2_ca.paa";
                _level = 2;
                _type = "IFV";
                _units = [
                    ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                    ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                    ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["TANGO", {
                _prettyName = "Tango (MBT)";
                _icon = "CUP\TrackedVehicles\CUP_TrackedVehicles_T90\data\ui\icomap_t90_ca.paa";
                _level = 2;
                _type = "MBT";
                _units = [
                    ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                    ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                    ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["ANVIL", {
                _prettyName = "Anvil (SPAAG/AAA)";
                _icon = "ca\ui\data\markers\n_unknown.paa";
                _level = 2;
                _type = "SPAAG";
                _units = [
                    ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                    ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                    ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
                ];
                _subGroups = [];
            }]
        ]
    ]],

    ["SUPPORT", [
        "Support Elements",
        "ca\ui\data\markers\b_support.paa",
        [
            ["RECON", {
                _prettyName = "Romeo (Recon / Sniper Team)";
                _icon = "ca\ui\data\markers\n_recon.paa";
                _level = 1;
                _type = "RECON";
                _units = [
                    ["B_officer_F", "Spotter", "SPOT", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Sniper", "SNPR", "CORPORAL", false, -1, 0]
                ];
                _subGroups = [];
            }],

            ["ENGINEER", {
                _prettyName = "Engi (Engineers Team)";
                _icon = "ca\ui\data\markers\n_support.paa";
                _level = 1;
                _type = "ENGI";
                _units = [
                    ["B_officer_F", "Engineer Leader", "ENG", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Engineer", "ENG", "CORPORAL", false, -1, 0]
                ];
                _subGroups = [];
            }],

            ["LOGISTICS", {
                _prettyName = "Logi (Logistics Team)";
                _icon = "ca\ui\data\markers\n_maint.paa";
                _level = 1;
                _type = "LOGI";
                _units = [
                    ["B_officer_F", "Logistics Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Logistics Driver", "RFL", "CORPORAL", false, -1, 0]
                ];
                _subGroups = [];
            }]
        ]
    ]],

    ["WEAPONS", [
        "Weapons Elements",
        "ca\ui\data\markers\b_mortar.paa",
        [
            ["MORTAR", {
                _prettyName = "Mortars (Mortar Team)";
                _icon = "ca\ui\data\markers\n_mortar.paa";
                _level = 1;
                _type = "MORTAR";
                _units = [
                    ["B_officer_F", "Gunnery Leader", "MRT", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Gunnery Gunner", "MRT", "CORPORAL", false, -1, 0]
                ];
                _subGroups = [];
            }],

            ["MMG", {
                _prettyName = "MMG (Machinegunner, Medium)";
                _icon = "ca\ui\data\markers\n_unknown.paa";
                _level = 1;
                _type = "MMG";
                _units = [
                    ["B_officer_F", "MMG Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Machinegunner, medium (MMG)", "MMG", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Assistant Machinegunner", "AMMG", "CORPORAL", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["HMG", {
                _prettyName = "HMG (Machinegunner, Heavy)";
                _icon = "ca\ui\data\markers\n_unknown.paa";
                _level = 1;
                _type = "HMG";
                _units = [
                    ["B_officer_F", "HMG Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Machinegunner, heavy (HMG)", "HMG", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Assistant Machinegunner", "AHMG", "CORPORAL", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["MAT", {
                _prettyName = "MAT (Anti-Tank, Medium)";
                _icon = "ca\ui\data\markers\n_unknown.paa";
                _level = 1;
                _type = "MAT";
                _units = [
                    ["B_officer_F", "MAT Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Anti-Tank, medium (MAT)", "MAT", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Anti-Tank, medium (MAT)", "MAT", "CORPORAL", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["HAT", {
                _prettyName = "HAT (Anti-Tank, Heavy)";
                _icon = "ca\ui\data\markers\n_unknown.paa";
                _level = 1;
                _type = "HAT";
                _units = [
                    ["B_officer_F", "HAT Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Anti-Tank, heavy (HAT)", "HAT", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Anti-Tank, heavy (HAT)", "HAT", "CORPORAL", false, -2, 0]
                ];
                _subGroups = [];
            }],

            ["DHAT", {
                _prettyName = "DHAT (Deployed Anti-Tank, Heavy)";
                _icon = "ca\ui\data\markers\n_unknown.paa";
                _level = 1;
                _type = "DHAT";
                _units = [
                    ["B_officer_F", "DHAT Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Gunner", "DHATG", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Assistant Gunner", "DHATAG", "CORPORAL", false, -2, 0]
                ];
                _subGroups = [];
            }]
        ]
    ]],

    ["ZEUS", {
        _prettyName = "Zeus Unit";
        _icon = "a3\ui_f_curator\data\logos\arma3_zeus_icon_ca.paa";
        _category = "";
        _level = -1;
        _type = "ZEUS";
        _units = [
            ["B_Soldier_F", "Zeus", "ZEUS", "MAJOR", true, 0, 0]
        ];
        _subGroups = [];
    }]
];