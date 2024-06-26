#include "script_component.hpp"
/*
 * Author: Eric
 * Defines CMF function modules and calls the PREP file.
 *
 * Public: No
 */
SCRIPT(XEH_MODULE);

LOG("Initializing components");
GVAR(components_initialized) = false;

/* CMF Modules to define */
GVAR(components) = [
    "main",
    "common",
    "diagnostic",
    "3den",
    "viewdistance",
    "environment",
    "menu",
    "map",
    "gameplay",
    "vehicles",
    "kosherArsenal",
    "kosherGarage",
    "kosherAI",
    "respawn",
    "curator",
    "ai",
    "aar",
    "logistics",
    "organization",
    "player"
];

// @TODO: cleanup file loading (Create function that takes path/name, and condition)
private _loadPrep = {
    params ["_module"];

    private _path = format ["components\%1\XEH_PREP.sqf", _module];

    if (fileExists _path) then {
        call compile preprocessFileLineNumbers _path;
    } else {
        WARNING_1("Failed to find module %1", _path);
    };
};

private _loadSettings = {
    params ["_module"];

    private _path = format ["components\%1\initSettings.sqf", _module];

    if (fileExists _path) then {
        waitUntil { !isNil "CBA_fnc_addSetting" };
        [compile preprocessFileLineNumbers _path] call CBA_fnc_directCall; // Make sure it's run unscheduled
    };
};

private _loadKeybinds = {
    params ["_module"];

    private _path = format ["components\%1\initKeybinds.sqf", _module];

    if (fileExists _path) then {
        waitUntil { !isNil "CBA_fnc_addKeybind" };
        [compile preprocessFileLineNumbers _path] call CBA_fnc_directCall; // Make sure it's run unscheduled
    };
};

private _loadPreInit = {
    if is3DEN exitWith {};
    params ["_module"];

    private _path = format ["components\%1\XEH_preInit.sqf", _module];

    if (fileExists _path) then {
        call compile preprocessFileLineNumbers _path;
    };
};

private _loadPostInit = {
    if is3DEN exitWith {};
    params ["_module"];

    private _path = format ["components\%1\XEH_postInit.sqf", _module];

    if (fileExists _path) then {
        [
            { missionNamespace getVariable [QGVAR(components_initialized), false] },
            { call compile preprocessFileLineNumbers _this },
            _path
        ] call CBA_fnc_waitUntilAndExecute;
    };
};

private _loadServerInit = {
    if is3DEN exitWith {};
    params ["_module"];

    if (!isServer) exitWith {};

    private _path = format ["components\%1\XEH_serverInit.sqf", _module];

    if (fileExists _path) then {
        call compile preprocessFileLineNumbers _path;
    };
};

private _loadPlayerInit = {
    if is3DEN exitWith {};
    params ["_module"];
    
    private _path = format ["components\%1\XEH_playerInit.sqf", _module];

    if (fileExists _path) then {
        [
            { missionNamespace getVariable [QGVAR(server_initialized), false] && { !isNull player } },
            {
                call compile preprocessFileLineNumbers _this;
            }, 
            _path
        ] call CBA_fnc_waitUntilAndExecute;
    };
};

private _load3denInit = {
    if (!is3DEN) exitWith {};
    params ["_module"];

    private _path = format ["components\%1\XEH_3denInit.sqf", _module];

    if (fileExists _path) then {
        waitUntil { missionNamespace getVariable [QGVAR(components_initialized), false] };
        0 spawn compile preprocessFileLineNumbers _path;
    };
};

/* Compile module */
{
    /* Compile modules */
    [_x] call _loadPrep;

    /* Compile settings */
    [_x] spawn _loadSettings;

    /* Compile Keybinds */
    [_x] spawn _loadKeybinds;

    /* Compile xeh events */
    [_x] call _loadPreInit;
    [_x] call _loadPostInit;
    [_x] call _loadServerInit;
    [_x] call _loadPlayerInit;
    [_x] spawn _load3denInit;
} forEach GVAR(components);

INFO("Initialized components");
GVAR(components_initialized) = true;