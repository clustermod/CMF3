/*
 * Author: Eric
 * Defines Cluster community gameplay functions
 *
 */
scriptName "functions\gameplay\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "rallyPoint", format["%1\fn_rallypoint.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "repairRearmTrigger", format["%1\fn_repairRearmTrigger.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "restrictedVehicle", format["%1\fn_restrictedVehicle.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "safeStart", format["%1\fn_safeStart.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "slingPrimary", format["%1\fn_slingPrimary.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "tracers", format["%1\fn_tracers.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "unitInvestigate", format["%1\fn_unitInvestigate.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "setRole", format["%1\fn_setRole.sqf", _category], false] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
