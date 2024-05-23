#include "script_component.hpp"

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

private _indexConfig = [
    [_indexMain], 
    "CMF Settings", 
    "a3\3den\data\displays\display3den\entitymenu\findconfig_ca.paa", 
    {
        // @TODO: Figure out how to open it on the page for CMF
        [findDisplay 313] execVM "x\cba\addons\settings\fnc_openSettingsMenu.sqf";
        [findDisplay 151 displayCtrl 9002] execVM "x\cba\addons\settings\fnc_gui_sourceChanged.sqf";
    }
] call FUNC(addMenuItem);

private _indexMission = [
    [_indexMain], 
    "CMF Mission Data",
    "a3\ui_f\data\gui\rsc\rscdisplayarsenal\map_ca.paa", 
    {
        call FUNC(setConfig_missionDataHandler);
    }
] call FUNC(addMenuItem);

[_indexMain] call FUNC(main_setConfig);
private _indexUnits = [[_indexMain], LSTRING(unit_spawner_displayName), "a3\ui_f\data\igui\rscingameui\rscunitinfo\si_stand_ca.paa"] call FUNC(addMenuItem);
private _indexTools = [[_indexMain], LSTRING(tools_displayName), "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_functions_ca.paa"] call FUNC(addMenuItem);

private _indexLobby = [[_indexMain], LSTRING(lobby_manager_displayName), "a3\ui_f\data\gui\rsc\rscdisplaymain\menu_multiplayer_ca.paa", {
    call (uiNamespace getVariable 'CBA_fnc_openLobbyManager');
}] call FUNC(addMenuItem);

private _indexIcons = [[_indexMain], LSTRING(iconviewer_displayName), "a3\3den\data\displays\display3den\panelleft\entitylist_layershow_ca.paa", {
    ["onload"] call FUNC(main_iconViewer);
}] call FUNC(addMenuItem);

private _indexBug = [[_indexMain], LSTRING(report_bug), "a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa", {
    createDialog "cmf_utility_reportBug";
}] call FUNC(addMenuItem);

[
    [_indexMain],
    "Mission Checklist",
    "DBUG\pictures\check.paa",
    { createDialog "CMF_RscMissionChecklist" }
] call FUNC(addMenuItem);

_ctrlMenuStrip menuSetAction [[0, 6, 1], toString { createDialog "CMF_RscMissionChecklist" }];

GVAR(menu_main) = [_indexMain];
GVAR(menu_unit) = [_indexMain, _indexUnits];
GVAR(menu_entity) = [_indexMain, _indexTools];