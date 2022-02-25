/*
 * Author: Eric
 * Defines Cluster community init functions
 *
 */
scriptName "functions\init\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "blockTextChat", format["%1\fn_blockTextChat.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "mapSwitchTextures", format["%1\fn_mapSwitchTextures.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "resizeMapMarkers", format["%1\fn_resizeMapMarkers.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "setSkill", format["%1\fn_setSkill.sqf", _category], true] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
