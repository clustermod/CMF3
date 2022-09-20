#include "script_component.hpp"
/*
 * Author: Eric
 * Defines CMF function modules and calls the PREP file.
 *
 * Public: No
 */
SCRIPT(XEH_MODULE);

/* CMF Modules to define */
GVAR(components) = [
  "common",
  "menu",
  "gameplay",
  "enhancedVehicles",
  "kosherArsenal",
  "kosherGarage",
  "respawn",
  "utility",
  "zeus",
  "init"
];

/* Call the files that compiles and defines the module's functions */
{
    private _modulePrepPath =  FORMAT_1("functions\%1\XEH_PREP.sqf", _x);
    if (FILE_EXISTS(_modulePrepPath)) then {
        [_x] call compile preprocessFileLineNumbers _modulePrepPath;
    };
} forEach GVAR(components);

/* Raise event */
[QGVAR(modules_initialized), []] call CBA_fnc_globalEvent;

if (count (REQUIRED_MODULES - GVAR(components)) > 0) then {PREP_SYS(var1)} else {FUNC(var1) = {ERROR_2("%1 missing required modules: %2",FUNC(var1),REQUIRED_MODULES-GVAR(components))}};

if (REQUIRED_ADDONS findIf {!isClass(configFile >> "CfgPatches" >> _x)} == -1) then {PREP_MODULE(var1)} else {FUNC(var1) = {ERROR_2("%1 missing a required addon",FUNC(var1))}};
