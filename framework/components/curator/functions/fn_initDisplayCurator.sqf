#include "script_component.hpp"
/*
 * Author: Eric
 * Run when display is initialized
 * 
 * Arguments:
 * 0: Display <DISPLAY>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [findDisplay 312] call cmf_zeus_fnc_initDisplayCurator
 * 
 * Public: No
 */
disableSerialization;
params [["_display", findDisplay 312]];

if (!GVAR(zeusInfoShow)) exitWith { };

/* Create controls for displaying useful data for the zeus */
private _groupWidth = 16 * (((safezoneW / safezoneH) min 1.2) / 40);
_ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", 17800];
_ctrlGroup ctrlSetPosition [
    ( safeZoneX + (safeZoneWAbs / 2)) - ((16 * (((safezoneW / safezoneH) min 1.2) / 40)) / 2),
    1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY),
    _groupWidth,
    8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
];
_ctrlGroup ctrlCommit 0;

_ctrlPlayerFPS = _display ctrlCreate ["RscStructuredText", 100, _ctrlGroup];
_ctrlServerFPS = _display ctrlCreate ["RscStructuredText", 101, _ctrlGroup];
_ctrlSpectators = _display ctrlCreate ["RscStructuredText", 102, _ctrlGroup];

_ctrlPlayerFPS ctrlSetText "Players (avg): x FPS";
_ctrlServerFPS ctrlSetText "Server: x FPS";
_ctrlSpectators ctrlSetText "Spectators: x";

_ctrlPlayerFPS ctrlSetPositionY (ctrlTextHeight _ctrlPlayerFPS) * 0.5;
_ctrlServerFPS ctrlSetPositionY (ctrlTextHeight _ctrlPlayerFPS) * 1;
_ctrlSpectators ctrlSetPositionY (ctrlTextHeight _ctrlPlayerFPS) * 1.5;
_ctrlGroup ctrlSetPositionH ((ctrlTextHeight _ctrlPlayerFPS) * 2);

private _maxWidth = (ctrlTextWidth _ctrlPlayerFPS) max (ctrlTextWidth _ctrlServerFPS) max (ctrlTextWidth _ctrlSpectators);
_ctrlGroup ctrlSetPositionX ( safeZoneX + (safeZoneWAbs / 2)) - (_maxWidth / 2);

_ctrlPlayerFPS ctrlCommit 0;
_ctrlServerFPS ctrlCommit 0;
_ctrlSpectators ctrlCommit 0;
_ctrlGroup ctrlCommit 0;

uiNamespace setVariable [QGVAR(ctrlGroup), _ctrlGroup];
[{
    disableSerialization;
    (_this select 0) params ["_ctrlPlayerFPS", "_ctrlServerFPS", "_ctrlSpectators", "_ctrlGroup"];

    private _avgFPS = 0;
    {
        _avgFPS = _avgFPS + (_x getVariable [QEGVAR(diagnostic,fps), 0]);
    } forEach allPlayers;
    _avgFPS = _avgFPS / (count allPlayers) max 1;

    private _serverFPS = missionNamespace getVariable [QEGVAR(diagnostic,serverFPS), 0];
    private _spectators = count (call ace_spectator_fnc_players);

    _ctrlPlayerFPS ctrlSetStructuredText text format ["Players (avg): %1 fps", _avgFPS toFixed 0];
    _ctrlServerFPS ctrlSetStructuredText text format ["Server: %1 fps", _serverFPS toFixed 0];
    _ctrlSpectators ctrlSetStructuredText text format ["Spectators: %1", _spectators];

    private _maxWidth = (ctrlTextWidth _ctrlPlayerFPS) max (ctrlTextWidth _ctrlServerFPS) max (ctrlTextWidth _ctrlSpectators);
    _ctrlGroup ctrlSetPositionX ( safeZoneX + (safeZoneWAbs / 2)) - (_maxWidth / 2);
    _ctrlGroup ctrlSetPositionW _maxWidth;

    _ctrlPlayerFPS ctrlSetPositionX ((_maxWidth / 2) - ((ctrlTextWidth _ctrlPlayerFPS) / 2));
    _ctrlPlayerFPS ctrlSetPositionW ctrlTextWidth _ctrlPlayerFPS;
    _ctrlServerFPS ctrlSetPositionX ((_maxWidth / 2) - ((ctrlTextWidth _ctrlServerFPS) / 2));
    _ctrlServerFPS ctrlSetPositionW ctrlTextWidth _ctrlServerFPS;
    _ctrlSpectators ctrlSetPositionX ((_maxWidth / 2) - ((ctrlTextWidth _ctrlSpectators) / 2));
    _ctrlSpectators ctrlSetPositionW ctrlTextWidth _ctrlSpectators;

    _ctrlPlayerFPS ctrlCommit 0;
    _ctrlServerFPS ctrlCommit 0;
    _ctrlSpectators ctrlCommit 0;
}, 2, [_ctrlPlayerFPS, _ctrlServerFPS, _ctrlSpectators, _ctrlGroup]] call CBA_fnc_addPerFrameHandler;

/* Hide show by event */
[QGVAR(toggleZeusInfo), {
    private _ctrlGroup = uiNamespace getVariable [QGVAR(ctrlGroup), controlNull];
    _ctrlGroup ctrlShow !(ctrlShown _ctrlGroup);
    _ctrlGroup ctrlCommit 0.5;
}] call CBA_fnc_addEventHandler;

/* Hide / Show */
[14, [false, false, false], {
    if (!GVAR(zeusInfoShow)) exitWith {};

    private _ctrlGroup = uiNamespace getVariable [QGVAR(ctrlGroup), controlNull];
    _ctrlGroup ctrlShow !(ctrlShown _ctrlGroup);
    _ctrlGroup ctrlCommit 0.5;
}] call CBA_fnc_addKeyHandler;