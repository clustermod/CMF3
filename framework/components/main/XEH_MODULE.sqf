#include "script_component.hpp"
/*
 * Author: Eric
 * Defines CMF function modules and calls the PREP file.
 *
 * Public: No
 */
SCRIPT(XEH_MODULE);

LOG("Initializing components");
missionNamespace setVariable [QGVAR(components_initialized), false];

/* CMF Modules to define */
GVAR(components) = [
    "main",
    "common",
    "viewdistance",
    "menu",
    "gameplay",
    "enhancedVehicles",
    "kosherArsenal",
    "kosherAI",
    "kosherGarage",
    "respawn",
    "utility",
    "zeus",
    "ai",
    "aar",
    "logistics",
    "organization",
    "player"
];

// @TODO cleanup file loading
private _loadPrep = {
    params ["_module"];

    private _path = format ["components\%1\XEH_PREP.sqf", _module];

    if (fileExists _path) then {
        [_module] call compile preprocessFileLineNumbers _path;
    } else {
        WARNING_1("Failed to find module %1", _modulePrepPath);
    };
};

private _loadPreInit = {
    params ["_module"];

    private _path = format ["components\%1\XEH_preInit.sqf", _module];

    if (fileExists _path) then {
        [] call compile preprocessFileLineNumbers _path;
    };
};

private _loadPostInit = {
    params ["_module"];

    private _path = format ["components\%1\XEH_postInit.sqf", _module];

    if (fileExists _path) then {
        [
            { missionNamespace getVariable [QGVAR(components_initialized), false] },
            { [] call compile preprocessFileLineNumbers _this },
            _path
        ] call CBA_fnc_waitUntilAndExecute;
    };
};

private _loadServerInit = {
    params ["_module"];

    if (!isServer) exitWith {};

    private _path = format ["components\%1\XEH_serverInit.sqf", _module];

    if (fileExists _path) then {
        [] call compile preprocessFileLineNumbers _path;
    };
};

private _loadPlayerInit = {
    params ["_module"];
    
    private _path = format ["components\%1\XEH_playerInit.sqf", _module];

    if (fileExists _path) then {
        [
            { (missionNamespace getVariable [QGVAR(server_initialized), false]) && !isNull player },
            {
                [] call compile preprocessFileLineNumbers _this;
            }, 
            _path
        ] call CBA_fnc_waitUntilAndExecute;
    };
};

/* Compile module */
{
    /* Compile modules */
    [_x] call _loadPrep;

    /* Compile xeh events */
    [_x] call _loadPreInit;
    [_x] call _loadPostInit;
    [_x] call _loadServerInit;
    [_x] call _loadPlayerInit;
} forEach GVAR(components);

INFO("Initialized components");
missionNamespace setVariable [QGVAR(components_initialized), true];