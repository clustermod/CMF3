#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes players for CMF (executed when new player connects).
 *
 * Arguments:
 * None
 *
 * Public: No
 */
SCRIPT(playerInit);

if (!hasInterface) exitWith {};

LOG_1("Initializing player %1...", (name player));
missionNamespace setVariable [QGVAR(player_initialized), false];

/* Disable removing grass */
tawvd_disablenone = true;

/* Load ace settings */
call compile preprocessFileLineNumbers "cmf\ace_settings.sqf";

/* Load Shacktack UI changes */
call compile preprocessFileLineNumbers "cmf\stuiMod.sqf";

/* Remove KP ranks ace interactions */
[] spawn {
    while {true} do {
        waitUntil{ !isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","KPR_Admin"]] call ace_interact_menu_fnc_findActionNode)} };
        [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin"]] call ace_interact_menu_fnc_removeActionFromClass;
        [(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", "KPR_Check"]] call ace_interact_menu_fnc_removeActionFromClass;
        [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin", "KPR_UniformManage"]] call ace_interact_menu_fnc_removeActionFromClass;
        [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin", "KPR_PlayerManage"]] call ace_interact_menu_fnc_removeActionFromClass;
        sleep 10;
    };
};

/* Load ace interaction menu */
[] spawn EFUNC(menu,init);

/* Disable Unsung vietnamese voices */
RUG_DSAI_TerminalDistance = -1;

/* Player killed event */
player addEventHandler ["Killed", {
    /* Save loadout */
    player setVariable [QGVAR(player_loadout), getUnitLoadout player];

    /* Save group upon player death */
    player setVariable [QGVAR(player_group), (group player)];

    /* Save team assigned upon player death */
    player setVariable [QGVAR(player_team), (assignedTeam player)];

    /* Call event script */
    _this execVM "events\onPlayerKilled.sqf"
}];

/* Player respawn event */
player addEventHandler ["Respawn", {
     /* Load loadout */
     player setUnitLoadout (player getVariable [QGVAR(player_loadout),[]]);

     /* Only run if players are not spectating */
     if !((player getVariable[QEGVAR(respawn,respawns), 1]) isEqualTo (player getVariable [QEGVAR(respawn,deaths), 0])) then {
         /* Join previous group */
         [player] joinSilent (player getVariable [QGVAR(player_group), (group player)]);

         /* Assign previous team */
         player assignTeam (player getVariable [QGVAR(player_team), (assignedTeam player)]);
     };


     /* Call event script */
     _this execVM "events\onPlayerRespawn.sqf"
}];

/* Raise event */
[QGVAR(player_initialized), []] call CBA_fnc_localEvent;

INFO_1("Player %1 Initialized!", (name player));
missionNamespace setVariable [QGVAR(player_initialized), true];
