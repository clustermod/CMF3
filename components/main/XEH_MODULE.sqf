#include "script_component.hpp"
/*
 * Author: Eric
 * Defines CMF function modules and calls the PREP file.
 *
 * Public: No
 */
SCRIPT(XEH_MODULE);

LOG("Initializing components");
missionNamespace setVariable [QGVAR(components_initialized), false, true];

/* CMF Modules to define */
GVAR(components) = [
    "main",
    "common",
    "menu",
    "gameplay",
    "enhancedVehicles",
    "kosherArsenal",
    "kosherGarage",
    "respawn",
    "utility",
    "zeus",
    "ai",
    "player"
];

/* Call the files that compiles and defines the module's functions */
{
    private _modulePrepPath = format["components\%1\XEH_PREP.sqf", _x];
    if (FILE_EXISTS(_modulePrepPath)) then {
        [_x] call compile preprocessFileLineNumbers _modulePrepPath;
    } else {
        WARNING_1("Failed to find module %1", _modulePrepPath);
    };
} forEach GVAR(components);

INFO("Initialized components");
missionNamespace setVariable [QGVAR(components_initialized), true, true];

/* Raise event */
[QGVAR(modules_initialized), []] call CBA_fnc_globalEvent;
