/*
 * Author: Eric
 * Defines Cluster community edhm functions
 *
 */
scriptName "functions\edhm\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "init", format["%1\fn_init.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "handleCameraEffects", format["%1\fn_handleCameraEffects.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "handleEffects", format["%1\fn_handleEffects.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "handleUnitOnFire", format["%1\fn_handleUnitOnFire.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "handleMedical", format["%1\fn_handleMedical.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "armorFire", format["%1\fn_armorFire.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "largeExplosion", format["%1\fn_largeExplosion.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "mediumExplosion", format["%1\fn_mediumExplosion.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "smallExplosion", format["%1\fn_smallExplosion.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "postProcess", format["%1\fn_postProcess.sqf", _category], false] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
