/*
 * Author: Eric
 * Defines Cluster community menu functions
 *
 */
scriptName "functions\aceMenu\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "menuinit", format["%1\fn_menuinit.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "endLoadingScreen", format["%1\fn_endLoadingScreen.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "createEndLoadingAction", format["%1\fn_createEndLoadingAction.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "createMapsFixAction", format["%1\fn_createMapsFixAction.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "createDisplayRolesAction", format["%1\fn_createDisplayRolesAction.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "createStartGameAction", format["%1\fn_createStartGameAction.sqf", _category], false] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
