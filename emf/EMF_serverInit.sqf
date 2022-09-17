#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes Server for EMF (executed preInit).
 *
 * Arguments:
 * None
 *
 * Public: No
 */
SCRIPT(serverInit);

if (!isServer) exitWith {};

LOG_1("Initializing EMF v%1...", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), false, true];

/* Store EMF Version Number in variable */
missionNamespace setVariable [QGVAR(version), VERSION_STR];

/* Disable removing grass */
tawvd_disablenone = true;

/* Disable Shacktac UI groupBar */
STHud_NoSquadBarMode = true;

/* Disable CTAB on ground vehicles */
cTab_vehicleClass_has_FBCB2 = [];

/* Disable Vietnamese voices from Unsung */
RUG_DSAI_TerminalDistance = -1;

/* band aid - remove this once they fix PlayerConnected mission event handler */
// https://forums.bistudio.com/topic/143930-general-discussion-dev-branch/page-942#entry3003074
["emf_onMissionStart_opcfix", "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
["emf_onMissionStart_opcfix", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

/* Register player */
["INFO", "Registering events...", "onMissionStart"] call EMF_DEBUG;
addMissionEventHandler ["PlayerConnected", {
    private _owner = _this select 4;
    [_this, "emf\EMF_playerInit.sqf"] remoteExec ["execVM", _owner];
}];

INFO_1("EMF v%1 Initialized!", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), true, true];
