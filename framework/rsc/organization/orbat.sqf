#include "script_component.hpp"
/*
 * ORBAT explenation will be added to wiki later. For now if you want to change the orbat, ask eric for help
 */

/* Function for naming fireteams */
_fireteamNaming = {
    params ["_group", "_level", "_type", "_parent", "_children"];

    private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;

    private "_index";
    if (!isNull _parent) then {
        private _parentData = [_parent] call FUNC(groupGetData);
        private _siblings = (_parentData select 3);
        _index = _siblings find _group;
    } else {
        private _siblings = ([_groupsHash, _level, []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
        _index = _siblings find _group;
    };


    private _parentIDs = [];
    while { !isNull _parent } do {
        private _parentData = [_parent] call FUNC(groupGetData);

        private _typeOrbat = [GVAR(orbat), (_parentData select 1), [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
        private _levelOrbat = [_typeOrbat select 0, (_parentData select 0), [{}, []]] call CBA_fnc_hashGet;
        private _names = [_parent, _parentData select 0, _parentData select 1, _parentData select 2, _parentData select 3] call (_levelOrbat select 0);

        if (isNil "_names") then {
            private _siblings = ([_groupsHash, (_parentData select 0), []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo (_parentData select 1) };
            private _index = _siblings find _parent;

            if ((_parentData select 0) isEqualTo _level + 1) then {
                private _name = [GVAR(phoneticAlphabet) select _index, "ZULU"] select count GVAR(phoneticAlphabet) < _index;
                _names = [_name select [0, 1], _name];
            } else {
                _names = [_index, _index];
            };

        };

        if ((_parentData select 0) isEqualTo _level + 1) then {
            _parentIDs pushBack (_names select 1);
        } else {
            _parentIDs pushBack ((_names select 0) select [0, 1]);
        };
        _parent = _parentData select 2;
    };

    reverse _parentIDs;
    private _squadName = _parentIDs deleteAt count _parentIDs - 1;
    if (isNil "_squadName") then {
        _squadName = "";
    };

    private _parentIndex = GVAR(phoneticAlphabet) findIf { toUpper (_squadName select [0, 1]) isEqualTo toUpper (_x select [0, 1]) };

    private _color = [
        [[1,0,0,0.7], [1,0,0,0.95]], 
        [[0,1,0,0.7], [0,1,0,0.95]], 
        [[0,0,1,0.7], [0,0,1,0.95]], 
        [[0.5,0,0,0.7], [0.5,0,0,0.95]], 
        [[0,0.5,0,0.7], [0,0.5,0,0.95]], 
        [[0,0.3,0.6,0.7], [0,0.3,0.6,0.95]]
    ] param [_parentIndex, [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]];

    private _groupId = [(_parentIDs joinString "/"), format ["%1%2", _squadName select [0, 1], _index + 1]] joinString " - ";
    [format ["%1%2", _squadName select [0, 1], _index + 1], format ["%1 %2", _squadName, _index + 1], _groupId, _color];
};

/* Function for naming squads */
private _squadNaming = {
    params ["_group", "_level", "_type", "_parent", "_children"];

    private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    private _siblings = ([_groupsHash, _level, []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type }; // @TODO: Try to get siblings from parent first
    private _index = _siblings find _group;
    private _name = [GVAR(phoneticAlphabet) select _index, "ZULU"] select (count GVAR(phoneticAlphabet) < _index);

    private _parentIDs = [];
    while { !isNull _parent } do {
        private _parentData = [_parent] call FUNC(groupGetData);

        private _typeOrbat = [GVAR(orbat), (_parentData select 1), [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
        private _levelOrbat = [_typeOrbat select 0, (_parentData select 0), [{}, []]] call CBA_fnc_hashGet;
        private _names = [_parent, _parentData select 0, _parentData select 1, _parentData select 2, _parentData select 3] call (_levelOrbat select 0);

        if (isNil "_names") then {
            private _siblings = ([_groupsHash, (_parentData select 0), []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo (_parentData select 1) };
            private _index = _siblings find _parent;
            _names = [_index];
        };

        _parentIDs pushBack ((_names select 0) select [0, 1]);
        _parent = _parentData select 2;
    };

    private _color = [
        [[1,0,0,0.7], [1,0,0,0.95]], 
        [[0,1,0,0.7], [0,1,0,0.95]], 
        [[0,0,1,0.7], [0,0,1,0.95]], 
        [[0.5,0,0,0.7], [0.5,0,0,0.95]], 
        [[0,0.5,0,0.7], [0,0.5,0,0.95]], 
        [[0,0.3,0.6,0.7], [0,0.3,0.6,0.95]]
    ] param [_index, [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]];

    reverse _parentIDs;
    private _groupId = [(_parentIDs joinString "/"), format ["%1SL", _name select [0, 1]]] joinString " - ";
    [format ["%1SL", _name select [0, 1]], _name, _groupId, _color];
};

/* Function for naming platoons */
private _platoonNaming = {
    params ["_group", "_level", "_type", "_parent", "_children"];

    private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    private _siblings = ([_groupsHash, _level, []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
    private _index = _siblings find _group;

    private _parentIDs = [];
    while { !isNull _parent } do {
        private _parentData = [_parent] call FUNC(groupGetData);

        private _typeOrbat = [GVAR(orbat), (_parentData select 1), [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
        private _levelOrbat = [_typeOrbat select 0, (_parentData select 0), [{}, []]] call CBA_fnc_hashGet;
        private _names = [_parent, _parentData select 0, _parentData select 1, _parentData select 2, _parentData select 3] call (_levelOrbat select 0);

        if (isNil "_names") then {
            private _siblings = ([_groupsHash, (_parentData select 0), []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo (_parentData select 1) };
            private _index = _siblings find _parent;
            _names = [_index];
        };

        _parentIDs pushBack ((_names select 0) select [0, 1]);
        _parent = _parentData select 2;
    };
    _parentIDs pushBack _index + 1;
    // reverse _parentIDs;

    private _subFix = ["", "st", "nd", "rd"] param [_index + 1, "th"];

    [format ["%1 - PLT HQ", (_index + 1)], format ["%1%2 Platoon", _index + 1, _subFix], format ["%1 - PLT HQ", _parentIDs joinString "/"], [[1,1,0,0.7], [1,1,0,0.95]]];
};

/* Function for naming companies */
private _companyNaming = {
    params ["_group", "_level", "_type", "_parent", "_children"];

    private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    private _siblings = ([_groupsHash, _level, []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
    private _index = _siblings find _group;
    private _name = [GVAR(phoneticAlphabet) select _index, "ZULU"] select (count GVAR(phoneticAlphabet) < _index);

    private _parentIDs = [];
    while { !isNull _parent } do {
        private _parentData = [_parent] call FUNC(groupGetData);

        private _typeOrbat = [GVAR(orbat), (_parentData select 1), [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
        private _levelOrbat = [_typeOrbat select 0, (_parentData select 0), [{}, []]] call CBA_fnc_hashGet;
        private _names = [_parent, _parentData select 0, _parentData select 1, _parentData select 2, _parentData select 3] call (_levelOrbat select 0);

        if (isNil "_names") then {
            private _siblings = ([_groupsHash, (_parentData select 0), []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo (_parentData select 1) };
            private _index = _siblings find _parent;
            _names = [_index];
        };

        _parentIDs pushBack ((_names select 0) select [0, 1]);
        _parent = _parentData select 2;
    };

    reverse _parentIDs;
    [format ["%1 COY", _name select [0, 1]], format ["%1 Company", _name], format ["%1 - %2 COY", _parentIDs joinString "/", _name select [0, 1]], [[0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]]];
};

/* Function for naming squad vehicles */
_vehicleSquadNaming = {
    params ["_group", "_level", "_type", "_parent", "_children"];

    private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;

    private "_index";
    if (!isNull _parent) then {
        private _parentData = [_parent] call FUNC(groupGetData);
        private _siblings = (_parentData select 3);
        _index = _siblings find _group;
    } else {
        private _siblings = ([_groupsHash, _level, []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
        _index = _siblings find _group;
    };


    private _parentIDs = [];
    while { !isNull _parent } do {
        private _parentData = [_parent] call FUNC(groupGetData);

        private _typeOrbat = [GVAR(orbat), (_parentData select 1), [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
        private _levelOrbat = [_typeOrbat select 0, (_parentData select 0), [{}, []]] call CBA_fnc_hashGet;
        private _names = [_parent, _parentData select 0, _parentData select 1, _parentData select 2, _parentData select 3] call (_levelOrbat select 0);

        if (isNil "_names") then {
            private _siblings = ([_groupsHash, (_parentData select 0), []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo (_parentData select 1) };
            private _index = _siblings find _parent;

            if ((_parentData select 0) isEqualTo _level + 1) then {
                private _name = [GVAR(phoneticAlphabet) select _index, "ZULU"] select (count GVAR(phoneticAlphabet) < _index);
                _names = [_name select [0, 1], _name];
            } else {
                _names = [_index, _index];
            };

        };

        if ((_parentData select 0) isEqualTo _level + 1) then {
            _parentIDs pushBack (_names select 1);
        } else {
            _parentIDs pushBack ((_names select 0) select [0, 1]);
        };
        _parent = _parentData select 2;
    };

    reverse _parentIDs;
    private _squadName = _parentIDs deleteAt count _parentIDs - 1;
    if (isNil "_squadName") then {
        _squadName = "";
    };

    private _parentIndex = GVAR(phoneticAlphabet) findIf { toUpper (_squadName select [0, 1]) isEqualTo toUpper (_x select [0, 1]) };

    private _color = [
        [[1,0,0,0.7], [1,0,0,0.95]], 
        [[0,1,0,0.7], [0,1,0,0.95]], 
        [[0,0,1,0.7], [0,0,1,0.95]], 
        [[0.5,0,0,0.7], [0.5,0,0,0.95]], 
        [[0,0.5,0,0.7], [0,0.5,0,0.95]], 
        [[0,0.3,0.6,0.7], [0,0.3,0.6,0.95]]
    ] param [_parentIndex, nil];

    [format ["%1V%2", _squadName select [0, 1], _index + 1], format ["%1 Vehicle %2", _squadName, _index + 1], format ["%1 - %2V%3", _parentIDs joinString "/", _squadName select [0, 1], _index + 1], _color];
};

/* Function for naming vehicles */
private _specialNaming = {
    params ["_group", "_level", "_type", "_parent", "_children"];

    if (_level isEqualTo 0) exitWith {};

    private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    private _siblings = ([_groupsHash, _level, []] call CBA_fnc_hashGet) select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
    private _index = _siblings find _group;

    private _parentIDs = [];
    while { !isNull _parent } do {
        private _parentData = [_parent] call FUNC(groupGetData);

        private _typeOrbat = [GVAR(orbat), (_parentData select 1), [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
        private _levelOrbat = [_typeOrbat select 0, (_parentData select 0), [{}, []]] call CBA_fnc_hashGet;
        private _names = [_parent, _parentData select 0, _parentData select 1, _parentData select 2, _parentData select 3] call (_levelOrbat select 0);

        if (isNil "_names") then {
            private _siblings = [_groupsHash, (_parentData select 0), []] call CBA_fnc_hashGet;
            private _index = _siblings find _parent;
            _names = [_index];
        };

        _parentIDs pushBack ((_names select 0) select [0, 1]);
        _parent = _parentData select 2;
    };

    /* Get name and color */
    private _special = switch _type do {
        case "RECON": { ["ROMEO", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "MORTAR": { ["MORTAR", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "LOGI": { ["LOGI", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "ENGI": { ["ENGI", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "MMG": { ["MMG", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "HMG": { ["HMG", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "MAT": { ["MAT", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "HAT": { ["HAT", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "DHAT": { ["DHAT", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]] };
        case "APC": { ["SIERRA", [[0.85, 0.4, 0, 0.7], [0.85, 0.4, 0, 0.95]]] };
        case "IFV": { ["MIKE", [[0.85, 0.4, 0, 0.7], [0.85, 0.4, 0, 0.95]]] };
        case "MBT": { ["TANGO", [[0.85, 0.4, 0, 0.7], [0.85, 0.4, 0, 0.95]]] };
        case "SPAAG": { ["ANVIL", [[0.85, 0.4, 0, 0.7], [0.85, 0.4, 0, 0.95]]] };
        case "TRANS": { ["PHANTOM", [[0, 0, 1, 0.7], [0, 0, 1, 0.95]]] };
        case "LCAS": { ["REAPER", [[0, 0, 1, 0.7], [0, 0, 1, 0.95]]] };
        case "HCAS": { ["UGLY", [[0, 0, 1, 0.7], [0, 0, 1, 0.95]]] };
        case "FWCAS": { ["HAWG", [[0.85, 0.64, 0.12, 0.7], [0.85, 0.64, 0.12, 0.95]]] };
        case "BOMBER": { ["PAVEMENT", [[0.85, 0.64, 0.12, 0.7], [0.85, 0.64, 0.12, 0.95]]] };
        default { [_type] };
    };

    reverse _parentIDs;
    [format ["%1 %2", _special select 0, _index + 1], format ["%1 %2", _special select 0, _index + 1], format ["%1 - %2 %3", _parentIDs joinString "/", _special select 0, _index + 1], _special param [1, nil]];
};

[
    ["INF", [[
        [0, [_fireteamNaming, []]],
        [1, [_squadNaming, [
            ["INF", 2],
            ["APC", 1],
            ["IFV", 1],
            ["MBT", 1],
            ["SPAAG", 1]
        ]]],
        [2, [_platoonNaming, [
            ["INF", 3],
            ["MMG", 1],
            ["HMG", 1],
            ["MAT", 1],
            ["HAT", 1],
            ["DHAT", 1],
            ["MORTAR", 1],
            ["RECON", 1],
            ["LOGI", 1],
            ["ENGI", 1]
        ]]],
        [3, [_companyNaming, [
            ["INF", 3],
            ["APC", 1],
            ["IFV", 1],
            ["MBT", 1],
            ["SPAAG", 1]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_inf.paa"]],
    ["MMG", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["MMG", 2]
        ]]],
        [2, [_specialNaming, [
            ["MMG", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_support.paa"]],
    ["HMG", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["HMG", 2]
        ]]],
        [2, [_specialNaming, [
            ["HMG", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_support.paa"]],
    ["MAT", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["MAT", 2]
        ]]],
        [2, [_specialNaming, [
            ["MAT", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_support.paa"]],
    ["HAT", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["HAT", 2]
        ]]],
        [2, [_specialNaming, [
            ["HAT", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_support.paa"]],
    ["DHAT", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["DHAT", 2]
        ]]],
        [2, [{}, [
            ["DHAT", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_support.paa"]],
    ["MORTAR", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["MORTAR", 2]
        ]]],
        [2, [_specialNaming, [
            ["MORTAR", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_mortar.paa"]],
    ["RECON", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["RECON", 2]
        ]]],
        [2, [_specialNaming, [
            ["RECON", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_recon.paa"]],
    ["LOGI", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["LOGI", 2]
        ]]],
        [2, [_specialNaming, [
            ["LOGI", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_support.paa"]],
    ["ENGI", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, [
            ["ENGI", 2]
        ]]],
        [2, [_specialNaming, [
            ["ENGI", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_maint.paa"]],
    ["APC", [[
        [0, [_vehicleSquadNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, [
            ["APC", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_motor_inf.paa	"]],
    ["IFV", [[
        [0, [_vehicleSquadNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, [
            ["IFV", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_mech_inf.paa"]],
    ["MBT", [[
        [0, [_vehicleSquadNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, [
            ["MBT", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_armor.paa"]],
    ["SPAAG", [[
        [0, [_vehicleSquadNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, [
            ["SPAAG", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_antiair.paa"]],
    ["TRANS", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, []]],
        [3, [_specialNaming, [
            ["TRANS", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_air.paa"]],
    ["LCAS", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, []]],
        [3, [_specialNaming, [
            ["LCAS", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_air.paa"]],
    ["HCAS", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, []]],
        [3, [_specialNaming, [
            ["HCAS", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_air.paa"]],
    ["FWCAS", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, []]],
        [3, [_specialNaming, [
            ["FWCAS", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_plane.paa"]],
    ["BOMBER", [[
        [0, [_specialNaming, []]],
        [1, [_specialNaming, []]],
        [2, [_specialNaming, []]],
        [3, [_specialNaming, [
            ["BOMBER", 2]
        ]]]
    ], "\A3\ui_f\data\map\markers\nato\b_plane.paa"]],
    ["ZEUS", [[
        [-1, [{["Off Game", "Off Game", "Off Game", [[0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]]]}, []]],
        [0, [{["Off Game", "Off Game", "Off Game", [[0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]]]}, []]],
        [1, [{["Off Game", "Off Game", "Off Game", [[0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]]]}, []]],
        [2, [{["Off Game", "Off Game", "Off Game", [[0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]]]}, []]],
        [3, [{["Off Game", "Off Game", "Off Game", [[0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]]]}, []]]
    ], "\A3\ui_f\data\map\markers\nato\b_unknown.paa"]]
]