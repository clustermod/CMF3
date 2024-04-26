#include "script_component.hpp"

/* Create cmf_player */
cmf_player = player;
["unit", {
    params ["_unit"];

    if !(_unit isKindOf "Man") exitWith {};

    cmf_player = _unit;
}] call CBA_fnc_addPlayerEventHandler;

/* Create CMF Info Diary */
call FUNC(diary);

/* Make sure player doesn't get stuck in loading */
call FUNC(endLoadingScreen);

/* Remove statistics diary */
cmf_player removeDiarySubject "Statistics";

/* Remove team diary */
cmf_player removeDiarySubject "Units";

/* Create sub category for radios */
[call acre_api_fnc_getAllRadios select 0, "Radios", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa", 1] call ace_arsenal_fnc_addRightPanelButton;

/* Remove KP ranks ace interactions */
[{
    playerClass = typeOf player;
    if (isNil { ([(ace_interact_menu_ActSelfNamespace getVariable playerClass), ["ACE_SelfActions","KPR_Admin"]] call ace_interact_menu_fnc_findActionNode) }) exitWith {};

    [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin"]] call ace_interact_menu_fnc_removeActionFromClass;
    [(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", "KPR_Check"]] call ace_interact_menu_fnc_removeActionFromClass;
    [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin", "KPR_UniformManage"]] call ace_interact_menu_fnc_removeActionFromClass;
    [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin", "KPR_PlayerManage"]] call ace_interact_menu_fnc_removeActionFromClass;
}, 10] call CBA_fnc_addPerFrameHandler;

/* Add an fire effect to ace fires */
GVAR(fireSources) = [] call CBA_fnc_hashCreate;
[{
    private _aceKeys = [ace_fire_fireSources] call CBA_fnc_hashKeys;
    private _cmfKeys = [GVAR(fireSources)] call CBA_fnc_hashKeys;
    private _newKeys = _aceKeys select { !(_x in _cmfKeys) };
    private _deletedKeys = _cmfKeys select { !(_x in _aceKeys) };

    {
        private _fireData = [ace_fire_fireSources, _x] call CBA_fnc_hashGet;
        [_x, _fireData] call FUNC(fireEffect);
    } forEach _newKeys;

    {
        { deleteVehicle _x } forEach ([GVAR(fireSources), _x] call CBA_fnc_hashGet);
        GVAR(fireSources) = [GVAR(fireSources), _x] call CBA_fnc_hashRem;
    } forEach _deletedKeys;

}, 1] call CBA_fnc_addPerFrameHandler;

/* Player killed event */
cmf_player addEventHandler ["Killed", {
    params ["_unit"];

    /* Save loadout */
    cmf_player setVariable [QGVAR(player_loadout), getUnitLoadout _unit];
    LOG("Saved respawn loadout");

    /* Save group upon player death */
    cmf_player setVariable [QGVAR(player_group), (group _unit)];

    /* Save team assigned upon player death */
    cmf_player setVariable [QGVAR(player_team), (assignedTeam _unit)];

    /* Save ACRE PTT */
    private _pttAssign = [] call acre_api_fnc_getMultiPushToTalkAssignment;
    cmf_player setVariable [QGVAR(ACREPTT), _pttAssign];
}];

/* Player respawn event */
cmf_player addEventHandler ["Respawn", {
    params ["_unit", ""];

    /* Load loadout */
    if (!isNil { cmf_player getVariable [QGVAR(player_loadout), nil] }) then {
        _unit setUnitLoadout (cmf_player getVariable [QGVAR(player_loadout), nil]);
        LOG("Set Respawn Loadout");

        /* Restore ACRE radio configurations */
        call FUNC(acreRestore);
    };

    /* Only run if players are not spectating */
    if !((cmf_player getVariable[QEGVAR(respawn,respawns), 1]) isEqualTo (cmf_player getVariable [QEGVAR(respawn,deaths), 0])) then {
        /* Join previous group */
        [_unit] joinSilent (cmf_player getVariable [QGVAR(player_group), (group _unit)]);

        /* Assign previous team */
        _unit spawn { _this assignTeam (cmf_player getVariable [QGVAR(player_team), (assignedTeam _this)]) };
    };
}];