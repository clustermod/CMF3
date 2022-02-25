/*
 * Author: Eric
 * Defines Cluster community kosher arsenal functions
 *
 */
scriptName "functions\kosherArsenal\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "init", format["%1\fn_init.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "ammobox", format["%1\fn_ammobox.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "forceArsenal", format["%1\fn_forceArsenal.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "aiInit", format["%1\fn_aiInit.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "aiArsenal", format["%1\fn_aiArsenal.sqf", _category], false] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
