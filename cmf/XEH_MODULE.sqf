#include "script_component.hpp"
/*
 * Author: Eric
 * Defines CMF function modules and calls the PREP file.
 *
 * Public: No
 */
SCRIPT(XEH_MODULE);

/* CMF Modules to define */
private _modules = [
  "common",
  "init",
  "menu",
  "gameplay",
  "enhancedVehicles",
  "kosherArsenal",
  "kosherGarage",
  "respawn",
  "utility",
  "zeus"
];

/* Call the files that compiles and defines the module's functions */
{
    private _modulePrepPath =  FORMAT_1("functions\%1\XEH_PREP.sqf", _x);
    if (FILE_EXISTS(_modulePrepPath)) then {
        [_x] call compile preprocessFileLineNumbers _modulePrepPath;
    };
} forEach _modules;

/* Raise event */
[QGVAR(modules_initialized), []] call CBA_fnc_globalEvent;
