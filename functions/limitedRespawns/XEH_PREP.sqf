/*
 * Author: Eric
 * Defines Cluster community limitedRespawns functions
 *
 */
scriptName "functions\limitedRespawns\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "init", format["%1\fn_init.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "setLives", format["%1\fn_setLives.sqf", _category], false] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
