#include "script_component.hpp"

LOG_1("Initializing CMF v%1...", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), false, true];

/* Print a warning if mission is run in singleplayer */
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

/* Change ACE carrying / draggin max carry weight */
ACE_maxWeightCarry = 1500;
ACE_maxWeightDrag = 1500;

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
["cmf_onMissionStart_opcfix", "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
["cmf_onMissionStart_opcfix", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

/* Register player */
addMissionEventHandler ["PlayerConnected", {
    private _owner = _this select 4;

    /* Raise event */
    [QGVAR(server_onPlayerConnected), _this] call CBA_fnc_globalEvent;
}];

/* Handle disconnects */
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "", "_uid"];

    /* Save unit loadout, position and direction before disconnect */
    private _disconUnits = missionNameSpace getVariable [QGVAR(disconUnits), createHashMap];
    _disconUnits set [_uid, [[_unit] call EFUNC(common,getRole), group _unit, getDir _unit, getUnitLoadout _unit, [_obj getVariable[QEGVAR(respawn,respawns), -1], _obj getVariable[QEGVAR(respawn,deaths), 0]]]];
    missionNameSpace setVariable [QGVAR(disconUnits), _disconUnits, true];

	false;
}];

/* Share server diagnostic */
[] spawn {
    if (!isServer) exitWith {};
    while { true } do {
        missionNameSpace setVariable [QGVAR(serverFPS), diag_fps, true];
        missionNameSpace setVariable [QGVAR(serverScripts), diag_activeScripts, true];
        sleep 2;
    };
};

/* Report performance when it drops below 15 FPS */
0 spawn {
    while { true } do {
        waitUntil { diag_fps < 15 };

        WARNING_1("Low Server FPS detected: %1", str diag_activeScripts);

        sleep 30;
    };
};

INFO_1("CMF v%1 Initialized!", VERSION_STR);
missionNamespace setVariable [QGVAR(server_initialized), true, true];

/* Raise event */
[QGVAR(server_initialized), _this] call CBA_fnc_globalEvent;
