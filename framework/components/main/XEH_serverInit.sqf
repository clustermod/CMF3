#include "script_component.hpp"

LOG_1("Initializing CMF v%1...", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), false, true];

/* Print a warning if mission is run in singleplayer */ // @TODO: Move to common
if (is3DENPreview && !is3DENMultiplayer) then {
    "CBA_diagnostic_Error" cutRsc ["CBA_diagnostic_Error", "PLAIN"];
    private _control = uiNamespace getVariable "CBA_diagnostic_Error";

    _control ctrlSetStructuredText composeText [
        lineBreak, parseText "<t align='center' size='1.65'>CMF: Singleplayer<\t>", lineBreak, lineBreak,
        "Certain parts of CMF might not work in a singleplayer enviroment. Any testing should be done in a multiplayer enviroment!"
    ];
};

/* Store CMF Version Number in variable */
missionNamespace setVariable [QGVAR(version), VERSION_STR, true];

/* Change ACE carrying / draggin max carry weight */ // @TODO: Move to common
ACE_maxWeightCarry = 1500;
ACE_maxWeightDrag = 1500;

/* Disable removing grass */ // @TODO: Move to viewdistance
tawvd_disablenone = true;

/* Disable Shacktac UI groupBar */ // @TODO: Move to common together with STUI settings
STHud_NoSquadBarMode = true;

/* Disable CTAB on ground vehicles */ // @TODO: Move to common
cTab_vehicleClass_has_FBCB2 = [];

/* Disable Vietnamese voices from Unsung */ // @TODO: Move to AI
RUG_DSAI_TerminalDistance = -1;

/* band aid - remove this once they fix PlayerConnected mission event handler */
// https://forums.bistudio.com/topic/143930-general-discussion-dev-branch/page-942#entry3003074
["cmf_onMissionStart_opcfix", "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
["cmf_onMissionStart_opcfix", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

/* Register player */
addMissionEventHandler ["PlayerConnected", {
    private _owner = _this select 4;

    /* Raise event */
    [QGVAR(server_onPlayerConnected), _this] call CBA_fnc_globalEvent;
}];

/* Handle disconnects */ // @TODO: Move to common
addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "", "_uid"];

    /* Save unit loadout, position and direction before disconnect */
    private _disconUnits = missionNameSpace getVariable [QGVAR(disconUnits), createHashMap];
    _disconUnits set [_uid, [[_unit] call EFUNC(common,getRole), group _unit, getDir _unit, getUnitLoadout _unit, [_obj getVariable[QEGVAR(respawn,respawns), -1], _obj getVariable[QEGVAR(respawn,deaths), 0]]]];
    missionNameSpace setVariable [QGVAR(disconUnits), _disconUnits, true];

    false;
}];

/* Share server diagnostic */ // @TODO: Move to common
// @TODO: Replace spawn
[] spawn {
    if (!isServer) exitWith {};
    while { true } do {
        missionNameSpace setVariable [QGVAR(serverFPS), diag_fps, true];
        missionNameSpace setVariable [QGVAR(serverScripts), diag_activeScripts, true];
        sleep 2;
    };
};

/* Report performance when it drops below 15 FPS */
0 spawn { // @TODO: Move to common
    while { true } do {
        waitUntil { diag_fps < 15 };

        // @TODO: Show message to admins
        private _activeScripts = diag_activeScripts;
        private _warningMessage = format ["Low Server FPS detected: %1 | Spawn: %2 | ExecVM: %3 | Exec: %4 | execFSM: %5", 
            str diag_fps, str (_activeScripts select 0), str (_activeScripts select 1), str (_activeScripts select 2), str (_activeScripts select 3)];

        WARNING(_warningMessage);

        sleep 30;
    };
};

INFO_1("CMF v%1 Initialized!", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), true, true];

/* Raise event */
[QGVAR(server_initialized), _this] call CBA_fnc_globalEvent;
