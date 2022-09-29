/*
 * Author: Eric
 * Defines Cluster community zeus functions
 *
 */
scriptName "functions\zeus\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "setLivesModule", format["%1\fn_setLivesModule.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "forceArsenalModule", format["%1\fn_forceArsenalModule.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "ammoboxModule", format["%1\fn_ammoboxModule.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "resetKosherRoleModule", format["%1\fn_resetKosherRoleModule.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "kosherForceCloseModule", format["%1\fn_kosherForceCloseModule.sqf", _category], true] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
