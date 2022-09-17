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
 * ["SQUAD"] call emf_3den_fnc_unitConstructor
 *
 * Public: No
 */

// unit array
// [group1, group2]

// group array
// ["name", "type", "size", "groupOffset", "subUnitArray"]

// sub unit array:
// ["classname", "role", "isleader", "unitOffset", "unitGrpOffset"]

GVAR(fnc_unitConstructor) = {
    params ["_unitID"];

    // Finds a valid platoon number
    private _fnc_findPlatoon = {
        params [["_searchName", "%1 PLT HQ"]];

        private _sqds = (all3DENEntities select 1) apply {(str _x) select [2, count (str _x) - 1]};
        private _pltID = 1;
        for "_id" from 1 to 100 step 1 do {
            if !((format[_searchName, _id]) in _sqds) exitWith {
                _pltID = _id;
            };
        };

        _pltID;
    };

    // Finds a valid squadname
    private _fnc_findSquad = {
        params [["_possibleSquadNames", ["%1 - ASL", "%1 - BSL", "%1 - CSL"]]];

        private _sqds = (all3DENEntities select 1) apply {(str _x) select [2, count (str _x) - 1]};

        private _sqdName = "? - ?SL";
        for "_id" from 1 to 100 step 1 do {
            {
                if !((format[_x, _id]) in _sqds) exitWith {
                    _sqdName = format[_x, _id];
                };
            } forEach _possibleSquadNames;
            if (_sqdName != "? - ?SL") exitWith {};
        };

        _sqdName;
    };

    // Finds a valid squadname
    private _fnc_findSquadAndFireteam = {
        private _possibleNames = [["%1 - ASL", ["%1 - A1", "%1 - A2"]], ["%1 - BSL", ["%1 - B1", "%1 - B2"]], ["%1 - CSL", ["%1 - C1", "%1 - C2"]]];

        private _sqds = (all3DENEntities select 1) apply {(str _x) select [2, count (str _x) - 1]};

        private _sqdName = ["? - ?SL", "? - ?1", "? - ?2"];
        for "_id" from 1 to 100 step 1 do {
            {
                private _squad = _x;

                if !((format[(_squad select 0), _id]) in _sqds) then {
                    private _valid = 0;
                    {
                        private _fireteam = _x;

                        if !((format[_fireteam, _id]) in _sqds) then {
                            _valid = _valid + 1;
                        }
                    } forEach (_squad select 1);

                    if (_valid isEqualTo 2) exitWith {
                        _sqdName = [format[(_squad select 0), _id], format[((_squad select 1) select 0), _id], format[((_squad select 1) select 1), _id]];
                    };
                };
            } forEach _possibleNames;
            if !(_sqdName isEqualTo ["? - ?SL", "? - ?1", "? - ?2"]) exitWith {};
        };

        _sqdName;
    };

    // Finds a valid fireteam name
    private _fnc_findFireteam = {
        params [["_possibleFireteamNames", ["%1 - A1", "%1 - A2", "%1 - B1", "%1 - B2", "%1 - C1", "%1 - C2"]]];

        private _sqds = (all3DENEntities select 1) apply {(str _x) select [2, count (str _x) - 1]};

        private _fireteamName = "? - ?1";
        for "_id" from 1 to 100 step 1 do {
            {
                if !((format[_x, _id]) in _sqds) exitWith {
                    _fireteamName = format[_x, _id];
                };
            } forEach _possibleFireteamNames;
            if (_fireteamName != "? - ?1") exitWith {};
        };

        _fireteamName;
    };

    private _fnc_customUnitControl = {
        private _display3DEN = uiNamespace getVariable "Display3DEN";
        private _display = _display3DEN createDisplay "emf_3den_customUnitMenu";

        /* Collect button controls */
        private _spawnCtrl = _display displayCtrl 1;
        //private _cancelCtrl = _display displayCtrl 2;

        private _grpTypeCtrl = _display displayCtrl 103;
        private _grpSizeCtrl = _display displayCtrl 104;

        /* Fill comboboxes with data */
        {
            _grpTypeCtrl lbAdd (configName _x);
        } forEach ("true" configClasses (missionConfigFile >> "EMF_ORBAT" >> "TYPES"));
        _grpTypeCtrl lbSetSelected [1, true];

        {
            _grpSizeCtrl lbAdd (configName _x);
        } forEach ("true" configClasses (missionConfigFile >> "EMF_ORBAT" >> "SIZES"));
        _grpSizeCtrl lbSetSelected [1, true];

        /* Handle unit spawn */
        _spawnCtrl ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrl"];

            private _display = ctrlParent  _ctrl;

            private _paramsArray = [];
            {
                _paramsArray pushBack (ctrlText (_display displayCtrl _x));
            } forEach [100, 101, 102];

            {
                _paramsArray pushBack ((_display displayCtrl _x) lbText (lbCurSel (_display displayCtrl _x)));
            } forEach [103, 104];

            {
                if (_x isEqualTo "") exitWith {
                    _paramsArray = ["failed"]
                };
            } forEach _paramsArray;

            GVAR(unitConstructor_customMenuReturn) = _paramsArray;
            //_display spawn {ctrlDelete _this};
        }];
    };

    private _unitArr = [];
    switch (_unitID) do {
        case ("COMPANY"): {
            _unitArr = [
                [ // COY HQ
                    ("COY HQ"), "INF", "COY", 0, [
                        ["B_officer_F", "Company Commander", "CO", true, 0, 0],
                        ["B_officer_F", "Company Executive Officer", "CEO", false, 0, 0],
                        ["B_medic_F", "Company Medic", "MED", false, 1, 0],
                        ["B_officer_F", "Forward Air Controller (FAC)", "FAC", false, 0, 0]
                    ]
                ],
                [ // 1 PLT HQ
                    ("1 PLT HQ"), "INF", "PLT", -1, [
                        ["B_officer_F", "Platoon Leader", "PL", true, 0, 0],
                        ["B_officer_F", "Platoon Sergeant", "PS", false, -1, 0],
                        ["B_medic_F", "Platoon Medic", "MED", false, -2, 0]
                    ]
                ],
                [ // ASL
                    "1 - ASL", "INF", "SQD", -2, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // A1
                    "1 - A1", "INF", "FT", -3, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // A2
                    "1 - A2", "INF", "FT", -3, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // BSL
                    "1 - BSL", "INF", "SQD", -4, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // B1
                    "1 - B1", "INF", "FT", -5, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // B2
                    "1 - B2", "INF", "FT", -5, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // CSL
                    "1 - CSL", "INF", "SQD", -6, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // C1
                    "1 - C1", "INF", "FT", -7, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // C2
                    "1 - C2", "INF", "FT", -7, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // 2 PLT HQ
                    ("2 PLT HQ"), "INF", "PLT", -8, [
                        ["B_officer_F", "Platoon Leader", "PL", true, 0, 0],
                        ["B_officer_F", "Platoon Sergeant", "PS", false, -1, 0],
                        ["B_medic_F", "Platoon Medic", "MED", false, -2, 0]
                    ]
                ],
                [ // ASL
                    "2 - ASL", "INF", "SQD", -9, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // A1
                    "2 - A1", "INF", "FT", -10, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // A2
                    "2 - A2", "INF", "FT", -10, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // BSL
                    "2 - BSL", "INF", "SQD", -11, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // B1
                    "2 - B1", "INF", "FT", -12, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // B2
                    "2 - B2", "INF", "FT", -12, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // CSL
                    "2 - CSL", "INF", "SQD", -13, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // C1
                    "2 - C1", "INF", "FT", -14, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // C2
                    "2 - C2", "INF", "FT", -14, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ]
            ];
        };

        case ("PLATOON"): {
            private _pltID = [] call _fnc_findPlatoon;

            _unitArr = [
                [ // PLT HQ
                    (str _pltID + " PLT HQ"), "INF", "PLT", 0, [
                        ["B_officer_F", "Platoon Leader", "PL", true, 0, 0],
                        ["B_officer_F", "Platoon Sergeant", "PS", false, 1, 0],
                        ["B_medic_F", "Platoon Medic", "MED", false, 2, 0]
                    ]
                ],
                [ // ASL
                    (str _pltID + " - ASL"), "INF", "SQD", -1, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // A1
                    (str _pltID + " - A1"), "INF", "FT", -2, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // A2
                    (str _pltID + " - A2"), "INF", "FT", -2, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // BSL
                    (str _pltID + " - BSL"), "INF", "SQD", -3, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // B1
                    (str _pltID + " - B1"), "INF", "FT", -4, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // B2
                    (str _pltID + " - B2"), "INF", "FT", -4, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ],
                [ // CSL
                    (str _pltID + " - CSL"), "INF", "SQD", -5, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ // C1
                    (str _pltID + " - C1"), "INF", "FT", -6, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ // C2
                    (str _pltID + " - C2"), "INF", "FT", -6, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ]
            ];
        };

        case ("SQUAD"): {
            private _squadID = [] call _fnc_findSquadAndFireteam;
            _unitArr = [
                [ // Squadleader
                    (_squadID select 0), "INF", "SQD", 0, [
                        ["B_officer_F", "Squad Leader", "SL", true, 0, 0],
                        ["B_medic_F", "Squad Medic", "MED", false, 1, 0]
                    ]
                ],
                [ //Fireteam 1
                    (_squadID select 1), "INF", "FT", -1, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ],
                [ //Fireteam 2
                    (_squadID select 2), "INF", "FT", -1, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, 2, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, 3, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, 4, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, 5, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, 6, -4]
                    ]
                ]
            ];
        };

        case ("FIRETEAM"): {
            private _ftID = [] call _fnc_findFireteam;

            _unitArr = [
                [
                    _ftID, "INF", "FT", -1, [
                        ["B_officer_F", "Fireteam Leader", "FTL", true, -1, 0],
                        ["B_soldier_AR_F", "Autorifleman", "AR", false, -2, -1],
                        ["B_soldier_AAR_F", "Assistant Autorifleman", "AAR", false, -3, -2],
                        ["B_soldier_LAT2_F", "Light Anti-Tank (LAT)", "LAT", false, -4, -3],
                        ["B_Soldier_F", "Rifleman", "RFL", false, -5, -4]
                    ]
                ]
            ];
        };

        case ("UNIT"): {
            // Call for custom unit control [_role, _lobbyRole, _grpName, _grpType, _grpSize]
            GVAR(unitConstructor_customMenuReturn) = [];
            [] spawn _fnc_customUnitControl;

            waitUntil {(count GVAR(unitConstructor_customMenuReturn)) > 0};
            private _params = GVAR(unitConstructor_customMenuReturn);

            if ((_params select 0) isEqualTo "failed") exitWith {
                ["Missing parameters", 1, 1] call BIS_fnc_3DENNotification;
                _unitArr = [];
            };

            if ((_params select 0) isEqualTo "exited") exitWith {
                _unitArr = [];
            };

            _unitArr = [
                [
                    (_params select 2), (_params select 3), (_params select 4), 0, [
                        ["B_Soldier_F", (_params select 1), (_params select 0), true, 0, 0]
                    ]
                ]
            ];
        };

        case ("ZEUS"): {
            _unitArr = [
                [
                    "Off Game", "INF", "BAT", 0, [
                        ["B_Soldier_F", "Zeus", "ZEUS", true, 0, 0]
                    ]
                ]
            ];
        };

        case ("PHANTOM"): {
            private _uID = ["PHANTOM %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("PHANTOM " + str _uID), "TRANS", "PLT", 0, [
                        ["B_Helipilot_F", "Pilot", "PILOT", true, 0, 0],
                        ["B_helicrew_F", "Co-Pilot", "PILOT", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("REAPER"): {
            private _uID = ["REAPER %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("REAPER " + str _uID), "CAS", "PLT", 0, [
                        ["B_Helipilot_F", "Pilot", "PILOT", true, 0, 0],
                        ["B_helicrew_F", "Co-Pilot", "PILOT", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("UGLY"): {
            private _uID = ["UGLY %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("UGLY " + str _uID), "CAS", "PLT", 0, [
                        ["B_Helipilot_F", "Pilot", "PILOT", true, 0, 0],
                        ["B_helicrew_F", "Gunner", "PILOT", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("HAWG"): {
            private _uID = ["HAWG %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("HAWG " + str _uID), "CAS", "PLT", 0, [
                        ["B_Fighter_Pilot_F", "Pilot", "PILOT", true, 0, 0]
                    ]
                ]
            ];
        };

        case ("PAVEMENT"): {
            private _uID = ["PAVEMENT %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("PAVEMENT " + str _uID), "CAS", "PLT", 0, [
                        ["B_Fighter_Pilot_F", "Pilot", "PILOT", true, 0, 0]
                    ]
                ]
            ];
        };

        case ("SIERRA"): {
            private _uID = ["SIERRA %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("SIERRA " + str _uID), "ARMOR", "PLT", 0, [
                        ["B_crew_F", "Commander", "CRW", true, 0, 0],
                        ["B_crew_F", "Gunner", "CRW", false, -1, 0],
                        ["B_crew_F", "Driver", "CRW", false, -2, 0]
                    ]
                ]
            ];
        };

        case ("MIKE"): {
            private _uID = ["MIKE %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("MIKE " + str _uID), "ARMOR", "PLT", 0, [
                        ["B_crew_F", "Commander", "CRW", true, 0, 0],
                        ["B_crew_F", "Gunner", "CRW", false, -1, 0],
                        ["B_crew_F", "Driver", "CRW", false, -2, 0]
                    ]
                ]
            ];
        };

        case ("TANGO"): {
            private _uID = ["TANGO %1"] call _fnc_findPlatoon;

            _unitArr = [
                [
                    ("TANGO " + str _uID), "ARMOR", "PLT", 0, [
                        ["B_crew_F", "Commander", "CRW", true, 0, 0],
                        ["B_crew_F", "Gunner", "CRW", false, -1, 0],
                        ["B_crew_F", "Driver", "CRW", false, -2, 0]
                    ]
                ]
            ];
        };

        case ("MORTARS"): {
            private _uID = [["%1 - MORTARS"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "SUPPORT", "SQD", 0, [
                        ["B_officer_F", "Gunnery Leader", "CRW", true, 0, 0],
                        ["B_Soldier_F", "Gunnery Gunner", "CRW", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("ROMEO"): {
            private _uID = [["%1 - ROMEO"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "SUPPORT", "SQD", 0, [
                        ["B_officer_F", "Spotter", "SPOT", true, 0, 0],
                        ["B_Soldier_F", "Sniper", "SNPR", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("ENGI"): {
            private _uID = [["%1 - ENGI"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "SUPPORT", "SQD", 0, [
                        ["B_officer_F", "Engineer Leader", "ENG", true, 0, 0],
                        ["B_Soldier_F", "Engineer", "ENG", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("LOGI"): {
            private _uID = [["%1 - LOGI"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "SUPPORT", "SQD", 0, [
                        ["B_officer_F", "Logistics Leader", "FTL", true, 0, 0],
                        ["B_Soldier_F", "Logistics Driver", "RFL", false, -1, 0]
                    ]
                ]
            ];
        };

        case ("MMG"): {
            private _uID = [["%1 - MMG"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "WEAPONS", "SQD", 0, [
                        ["B_officer_F", "MMG Leader", "FTL", true, 0, 0],
                        ["B_Soldier_F", "Machinegunner, medium (MMG)", "MMG", false, -1, 0],
                        ["B_Soldier_F", "Assistant Machinegunner", "AMMG", false, -2, 0]
                    ]
                ]
            ];
        };

        case ("HMG"): {
            private _uID = [["%1 - HMG"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "WEAPONS", "SQD", 0, [
                        ["B_officer_F", "HMG Leader", "FTL", true, 0, 0],
                        ["B_Soldier_F", "Machinegunner, heavy (HMG)", "HMG", false, -1, 0],
                        ["B_Soldier_F", "Assistant Machinegunner", "AHMG", false, -2, 0]
                    ]
                ]
            ];
        };

        case ("MAT"): {
            private _uID = [["%1 - MAT"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "WEAPONS", "SQD", 0, [
                        ["B_officer_F", "MAT Leader", "FTL", true, 0, 0],
                        ["B_Soldier_F", "Anti-Tank, medium (MAT)", "MAT", false, -1, 0],
                        ["B_Soldier_F", "Anti-Tank, medium (MAT)", "MAT", false, -2, 0]
                    ]
                ]
            ];
        };

        case ("HAT"): {
            private _uID = [["%1 - HAT"]] call _fnc_findSquad;

            _unitArr = [
                [
                    _uID, "WEAPONS", "SQD", 0, [
                        ["B_officer_F", "HAT Leader", "FTL", true, 0, 0],
                        ["B_Soldier_F", "Anti-Tank, heavy (HAT)", "HAT", false, -1, 0],
                        ["B_Soldier_F", "Anti-Tank, heavy (HAT)", "HAT", false, -2, 0]
                    ]
                ]
            ];
        };

        default {
            [format["unit type: %1 is not configured yet!", str _unitID], 1, 1] call BIS_fnc_3DENNotification;
        };
    };

    _unitArr;
};
