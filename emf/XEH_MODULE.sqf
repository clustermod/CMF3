#include "script_component.hpp"
/*
 * Author: Eric
 * Defines EMF function modules and calls the PREP file.
 *
 * Public: No
 */
SCRIPT(XEH_MODULE);

/* EMF Modules to define */
private _modules = [
  "common",
  "init",
  "menu",
  "gameplay",
  "enhancedVehicles",
  "afterActionReport",
  "kosherArsenal",
  "kosherGarage",
  "respawn",
  "utility",
  "zeus"
];

/* Call the files that compiles and defines the module's functions */
{
  [_x] call compile(preprocessFileLineNumbers format["functions\%1\XEH_PREP.sqf", _x]);
} forEach _modules;
