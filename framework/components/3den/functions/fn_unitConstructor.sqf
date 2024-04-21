#include "script_component.hpp"
/*
 * Author: Eric
 * Constructs unit arrays to be used with the units spawner
 *
 * Arguments:
 * 0: unitIdentifier <STRING>
 *
 * Return Value:
 * UnitArray <Array>
 *
 * Example:
 * ["SQUAD"] call cmf_3den_fnc_unitConstructor
 *
 * Public: No
 */
SCRIPT(unitConstructor);

params ["_unitID"];

private _fnc_customUnitControl = {
    [
        "Edit: Custom Unit",
        [
            ["EDIT", ["Role", "The unit's assigned kosherArsenal role, e.g. RFL"], ["RFL"]],
            ["EDIT", ["Role Pretty Name", "Role Prettyname e.g. Rifleman"], ["Rifleman"]],
            ["LIST", ["Rank", "Rank of unit"], [
                ["PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"],
                ["Private", "Corporal", "Sergeant", "Lieutenant", "Captain", "Major", "Colonel"],
                0
            ]],
            ["EDIT", ["Group Level", "The unit's group's level"], ["0"]],
            ["EDIT", ["Group Type", "The unit's group's type"], ["INF"]]
        ],
        {
            GVAR(unitConstructor_customMenuReturn) = (_this select 0);
        }
    ] call zen_dialog_fnc_create;
};

private _unitArr = [];
switch _unitID do {
    case "COMPANY": {
        _unitArr = [
        [ // COY HQ
            3, "INF", 0, [
                ["B_officer_F", "Company Commander", "CO", "CAPTAIN", true, 0, 0],
                ["B_officer_F", "Company Executive Officer", "CAPTAIN", "CEO", false, 0, 0],
                ["B_medic_F", "Company Medic", "MED", "CAPTAIN", false, 1, 0],
                ["B_officer_F", "Forward Air Controller (FAC)", "CAPTAIN", "FAC", false, 0, 0]
            ]
        ],
            [ // 1 PLT HQ
            2, "INF", -1, [
                ["B_officer_F", "Platoon Leader", "PL", "LIEUTENANT", true, 0, 0],
                ["B_officer_F", "Platoon Sergeant", "PS", "LIEUTENANT", false, -1, 0],
                ["B_medic_F", "Platoon Medic", "MED", "LIEUTENANT", false, -2, 0]
            ]
        ],
        [ // ASL
            1, "INF", -2, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // A1
            0, "INF", -3, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // A2
            0, "INF", -3, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
        [ // BSL
            1, "INF", -4, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // B1
            0, "INF", -5, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // B2
            0, "INF", -5, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
        [ // CSL
            1, "INF", -6, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // C1
            0, "INF", -7, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // C2
            0, "INF", -7, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
            [ // 2 PLT HQ
            2, "INF", -8, [
                ["B_officer_F", "Platoon Leader", "PL", "LIEUTENANT", true, 0, 0],
                ["B_officer_F", "Platoon Sergeant", "PS", "LIEUTENANT", false, -1, 0],
                ["B_medic_F", "Platoon Medic", "MED", "LIEUTENANT", false, -2, 0]
            ]
        ],
            [ // ASL
            1, "INF", -9, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // A1
            0, "INF", -10, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // A2
            0, "INF", -10, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
        [ // BSL
            1, "INF", -11, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // B1
            0, "INF", -12, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // B2
            0, "INF", -12, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
        [ // CSL
            1, "INF", -13, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // C1
            0, "INF", -14, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // C2
            0, "INF", -14, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ]
        ];
    };

    case "PLATOON": {
        _unitArr = [
        [ // PLT HQ
            2, "INF", 0, [
                ["B_officer_F", "Platoon Leader", "PL", "LIEUTENANT", true, 1.5, 0],
                ["B_officer_F", "Platoon Sergeant", "PS", "LIEUTENANT", false, 0.5, 0],
                ["B_medic_F", "Platoon Medic", "MED", "LIEUTENANT", false, -0.5, 0]
            ]
        ],
            [ // ASL
            1, "INF", -1, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // A1
            0, "INF", -2, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
        [ // A2
            0, "INF", -2, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // BSL
            1, "INF", -3, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // B1
            0, "INF", -4, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // B2
            0, "INF", -4, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ],
        [ // CSL
            1, "INF", -5, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ // C1
            0, "INF", -6, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ // C2
            0, "INF", -6, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ]
        ];
    };

    case "SQUAD": {
        _unitArr = [
        [ // Squadleader
            1, "INF", 0, [
                ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
            ]
        ],
        [ //Fireteam 1
            0, "INF", -1, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, -3, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
            ]
        ],
        [ //Fireteam 2
            0, "INF", -1, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ]
        ];
    };

    case "FIRETEAM": {
        _unitArr = [
        [
            0, "INF", -1, [
                ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, 2, 0],
                ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, 3, -1],
                ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", "PRIVATE", false, 4, -2],
                ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, 5, -3],
                ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, 6, -4]
            ]
        ]
        ];
    };

    case "UNIT": {
        GVAR(unitConstructor_customMenuReturn) = [];
        [] spawn _fnc_customUnitControl;

        waitUntil {count GVAR(unitConstructor_customMenuReturn) > 0};
        GVAR(unitConstructor_customMenuReturn) params ["_role", "_prettyRole", "_rank", "_level", "_type"];

        _unitArr = [[
            _level, _type, -1, [
                ["B_Soldier_F", _prettyRole, _role, _rank, true, 0, 0]
            ]
        ]];

        GVAR(unitConstructor_customMenuReturn) = [];
    };

    case "ZEUS": {
        _unitArr = [
        [
            0, "ZEUS", 0, [
                ["B_Soldier_F", "Zeus", "ZEUS", "MAJOR", true, 0, 0]
            ]
        ]
        ];
    };

    case "PHANTOM": {
        _unitArr = [
        [
            3, "TRANS", 0, [
                ["B_Helipilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0],
                ["B_helicrew_F", "Co-Pilot", "PILOT", "LIEUTENANT", false, -1, 0]
            ]
        ]
        ];
    };

    case "REAPER": {
        _unitArr = [
        [
            3, "LCAS", 0, [
                ["B_Helipilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0],
                ["B_helicrew_F", "Co-Pilot", "PILOT", "LIEUTENANT", false, -1, 0]
            ]
        ]
        ];
    };

    case "UGLY": {
        _unitArr = [
        [
            3, "HCAS", 0, [
                ["B_Helipilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0],
                ["B_helicrew_F", "Gunner", "PILOT", "LIEUTENANT", false, -1, 0]
            ]
        ]
        ];
    };

    case "HAWG": {
        _unitArr = [
        [
            3, "FWCAS", 0, [
                ["B_Fighter_Pilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0]
            ]
        ]
        ];
    };

    case "PAVEMENT": {
        _unitArr = [
        [
            3, "BOMBER", 0, [
                ["B_Fighter_Pilot_F", "Pilot", "PILOT", "LIEUTENANT", true, 0, 0]
            ]
        ]
        ];
    };

    case "SIERRA": {
        _unitArr = [
        [
            2, "APC", 0, [
                ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
            ]
        ]
        ];
    };

    case "MIKE": {
        _unitArr = [
        [
            2, "IFV", 0, [
                ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
            ]
        ]
        ];
    };

    case "TANGO": {
        _unitArr = [
        [
            2, "MBT", 0, [
                ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
            ]
        ]
        ];
    };

    case "ANVIL": {
        _unitArr = [
        [
            2, "SPAAG", 0, [
                ["B_crew_F", "Commander", "CRW", "LIEUTENANT", true, 0, 0],
                ["B_crew_F", "Gunner", "CRW", "LIEUTENANT", false, -1, 0],
                ["B_crew_F", "Driver", "CRW", "LIEUTENANT", false, -2, 0]
            ]
        ]
        ];
    };

    case "MORTARS": {
        _unitArr = [
        [
            1, "MORTAR", 0, [
                ["B_officer_F", "Gunnery Leader", "CRW", "SERGEANT", true, 0, 0],
                ["B_Soldier_F", "Gunnery Gunner", "CRW", "CORPORAL", false, -1, 0]
            ]
        ]
        ];
    };

    case "ROMEO": {
        _unitArr = [
        [
            1, "RECON", 0, [
                ["B_officer_F", "Spotter", "SPOT", "SERGEANT", true, 0, 0],
                ["B_Soldier_F", "Sniper", "SNPR", "CORPORAL", false, -1, 0]
            ]
        ]
        ];
    };

    case "ENGI": {
        _unitArr = [
        [
            1, "ENGI", 0, [
                ["B_officer_F", "Engineer Leader", "ENG", "SERGEANT", true, 0, 0],
                ["B_Soldier_F", "Engineer", "ENG", "CORPORAL", false, -1, 0]
            ]
        ]
        ];
    };

    case "LOGI": {
        _unitArr = [
            [
                1, "LOGI", 0, [
                    ["B_officer_F", "Logistics Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Logistics Driver", "RFL", "CORPORAL", false, -1, 0]
                ]
            ]
        ];
    };

    case "MMG": {
        _unitArr = [
            [
                1, "MMG", 0, [
                    ["B_officer_F", "MMG Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Machinegunner, medium (MMG)", "MMG", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Assistant Machinegunner", "AMMG", "CORPORAL", false, -2, 0]
                ]
            ]
        ];
    };

    case "HMG": {
        _unitArr = [
            [
                1, "HMG", 0, [
                    ["B_officer_F", "HMG Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Machinegunner, heavy (HMG)", "HMG", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Assistant Machinegunner", "AHMG", "CORPORAL", false, -2, 0]
                ]
            ]
        ];
    };

    case "MAT": {
        _unitArr = [
            [
                1, "MAT", 0, [
                    ["B_officer_F", "MAT Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Anti-Tank, medium (MAT)", "MAT", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Anti-Tank, medium (MAT)", "MAT", "CORPORAL", false, -2, 0]
                ]
            ]
        ];
    };

    case "HAT": {
        _unitArr = [
            [
                1, "HAT", 0, [
                    ["B_officer_F", "HAT Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Anti-Tank, heavy (HAT)", "HAT", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Anti-Tank, heavy (HAT)", "HAT", "CORPORAL", false, -2, 0]
                ]
            ]
        ];
    };

    case "DHAT": {
        _unitArr = [
            [
                1, "DHAT", 0, [
                    ["B_officer_F", "DHAT Leader", "FTL", "SERGEANT", true, 0, 0],
                    ["B_Soldier_F", "Gunner", "DHATG", "CORPORAL", false, -1, 0],
                    ["B_Soldier_F", "Assistant Gunner", "DHATAG", "CORPORAL", false, -2, 0]
                ]
            ]
        ];
    };

    case "RGR_RFL_SQUAD": {
        _unitArr = [
            [ // Squadleader
                1, "RECON", 0, [
                    ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                    ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
                ]
            ],
            [ //Fireteam 1
                0, "RECON", -1, [
                    ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                    ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                    ["B_Soldier_GL_F", "Grenadier", "GRD", "PRIVATE", false, -3, -2],
                    ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                    ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
                ]
            ],
            [ //Fireteam 2
                0, "RECON", -1, [
                    ["B_officer_F", "Fireteam Leader", "FTL", "CORPORAL", true, -1, 0],
                    ["B_soldier_AR_F", "Autorifleman", "AR", "PRIVATE", false, -2, -1],
                    ["B_Soldier_GL_F", "Grenadier", "GRD", "PRIVATE", false, -3, -2],
                    ["B_soldier_LAT2_F", "Anti-Tank, Light (LAT)", "LAT", "PRIVATE", false, -4, -3],
                    ["B_Soldier_F", "Rifleman", "RFL", "PRIVATE", false, -5, -4]
                ]
            ]
        ];
    };

    case "RGR_MG_SQUAD": {
        _unitArr = [
            [ // Squadleader
                1, "RECON", 0, [
                    ["B_officer_F", "Squad Leader", "SL", "SERGEANT", true, 0, 0],
                    ["B_medic_F", "Squad Medic", "MED", "CORPORAL", false, 1, 0]
                ]
            ],
            [ //Fireteam 1
                0, "RECON", -1, [
                    ["B_officer_F", "Gun Team Leader", "FTL", "CORPORAL", true, -1, 0],
                    ["B_soldier_AR_F", "Machinegunner, Medium", "MMG", "PRIVATE", false, -2, -1]
                ]
            ],
            [ //Fireteam 2
                0, "RECON", -1, [
                    ["B_officer_F", "Gun Team Leader", "FTL", "CORPORAL", true, 2, 0],
                    ["B_soldier_AR_F", "Machinegunner, Medium", "MMG", "PRIVATE", false, -2, -1]
                ]
            ],
            [ //Fireteam 3
                0, "RECON", -1, [
                    ["B_officer_F", "Gun Team Leader", "FTL", "CORPORAL", true, 2, 0],
                    ["B_soldier_AR_F", "Machinegunner, Medium", "MMG", "PRIVATE", false, -2, -1]
                ]
            ]
        ];
    };

    default {
        [format["unit type: %1 is not configured yet!", str _unitID], 1, 1] call BIS_fnc_3DENNotification;
    };
};

_unitArr;
