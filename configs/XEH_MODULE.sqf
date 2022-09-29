/*
 * Author: Eric
 * Defines function modules
 *
 * Public: No
 */
scriptName "configs\XEH_MODULE.sqf";
private["_modules"];

// Define modules (use directory names)
_modules = [
  "aceMenu",
  "edhm",
  "gameplay",
  "init",
  "kosherArsenal",
  "limitedRespawns",
  "utilities",
  "zeus"
];

// Call the XEH_PREP scripts (contains the function definitions)
{
  [_x] call compile(preprocessFileLineNumbers format["functions\%1\XEH_PREP.sqf", _x]);
  ["INFO", format["Loaded module: %1", _x], "xeh_module"] call EMF_DEBUG;
} forEach _modules;
