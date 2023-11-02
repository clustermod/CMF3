#include "script_component.hpp"
/*
 * Author: Eric
 * Creates sub menus in the ace arsenal for medical and radio equipment
 *
 * Public: No
 */
SCRIPT(initAceSettings);

private _radioEquipment = [
    "ACRE_PRC117F", "ACRE_PRC148", "ACRE_PRC152", "ACRE_PRC343", "ACRE_PRC77", "ACRE_SEM52SL", "ACRE_SEM70", "ACRE_VHF30108SPIKE", "ACRE_VHF30108", "ACRE_VHF30108MAST", "ACRE_BF888S"
];

/* Create radio submenu */
[_radioEquipment, "Radios", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa", 1] call ace_arsenal_fnc_addRightPanelButton;

/* Set map gesture group colors */
if (!is3DEN) then {
    ["CAManBase", "init", {
        params ["_unit"];

        private _group = group _unit;
        if (!isNil { ace_map_gestures_GroupColorCfgMappingNew getVariable [groupID _group, nil] }) exitWith { };

        private _infantryColors = [
            ["ASL", [1,0,0,0.7], [1,0,0,0.95]],
            ["A1", [1,0,0,0.7], [1,0,0,0.95]],
            ["A2", [1,0,0,0.7], [1,0,0,0.95]],
            ["A3", [1,0,0,0.7], [1,0,0,0.95]],
            ["BSL", [0,1,0,0.7], [0,1,0,0.95]],
            ["B1", [0,1,0,0.7], [0,1,0,0.95]],
            ["B2", [0,1,0,0.7], [0,1,0,0.95]],
            ["B3", [0,1,0,0.7], [0,1,0,0.95]],
            ["CSL", [0,0,1,0.7], [0,0,1,0.95]],
            ["C1", [0,0,1,0.7], [0,0,1,0.95]],
            ["C2", [0,0,1,0.7], [0,0,1,0.95]],
            ["C3", [0,0,1,0.7], [0,0,1,0.95]],
            ["DSL", [0.5,0,0,0.7], [0.5,0,0,0.95]],
            ["D1", [0.5,0,0,0.7], [0.5,0,0,0.95]],
            ["D2", [0.5,0,0,0.7], [0.5,0,0,0.95]],
            ["D3", [0.5,0,0,0.7], [0.5,0,0,0.95]],
            ["ESL", [0,0.5,0,0.7], [0,0.5,0,0.95]],
            ["E1", [0,0.5,0,0.7], [0,0.5,0,0.95]],
            ["E2", [0,0.5,0,0.7], [0,0.5,0,0.95]],
            ["E3", [0,0.5,0,0.7], [0,0.5,0,0.95]],
            ["FSL", [0,0.3,0.6,0.7], [0,0.3,0.6,0.95]],
            ["F1", [0,0.3,0.6,0.7], [0,0.3,0.6,0.95]],
            ["F2", [0,0.3,0.6,0.7], [0,0.3,0.6,0.95]],
            ["F3", [0,0.3,0.6,0.7], [0,0.3,0.6,0.95]],
            ["PLT HQ", [1,1,0,0.7], [1,1,0,0.95]],
            ["COY HQ", [0.05,0.05,0.05,0.7], [0.05,0.05,0.05,0.95]],
            ["SIERRA", [0.85,0.4,0,0.7], [0.85,0.4,0,0.95]],
            ["MIKE", [0.85,0.4,0,0.7], [0.85,0.4,0,0.95]],
            ["TANGO", [0.85,0.4,0,0.7], [0.85,0.4,0,0.95]],
            ["ANVIL", [0.85,0.4,0,0.7], [0.85,0.4,0,0.95]],
            ["PHANTOM", [0,0,1,0.7], [0,0,1,0.95]],
            ["REAPER", [0,0,1,0.7], [0,0,1,0.95]],
            ["UGLY", [0,0,1,0.7], [0,0,1,0.95]],
            ["HAWG", [0.85,0.64,0.12,0.7], [0.85,0.64,0.12,0.95]],
            ["PAVEMENT", [0.85,0.64,0.12,0.7], [0.85,0.64,0.12,0.95]]
        ];

        private _index = _infantryColors findIf { (_x select 0) in toUpper (groupID _group) };
        if (_index > -1) then {
            private _groupColors = _infantryColors select _index;
            [groupID _group, _groupColors select 1, _groupColors select 2] call ace_map_gestures_fnc_addGroupColorMapping;
        };
    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

/* Raise event */
[QGVAR(onAddedAceSettings), [[0, "Radios", _radioEquipment]]] call CBA_fnc_localEvent;
