/*
 * Author: Eric
 * Defines Cluster community utility functions
 *
 */
scriptName "functions\utilities\XEH_PREP.sqf";
params["_category"];

["TRACE", "Defining functions...", _category, "xeh_prep"] call EMF_DEBUG;

[_category, "countDown", format["%1\fn_countDown.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "enhancedAttachTo", format["%1\fn_enhancedAttachTo.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "nearestPlayer", format["%1\fn_nearestPlayer.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "preventProne", format["%1\fn_preventProne.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "setDate", format["%1\fn_setDate.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "notZeus", format["%1\fn_notZeus.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "slotLimit", format["%1\fn_slotLimit.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "zeusFPS", format["%1\fn_zeusFPS.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "endLoadingScreen", format["%1\fn_endLoadingScreen.sqf", _category], true] call emf_fnc_defineFunction;
[_category, "stripUnit", format["%1\fn_stripUnit.sqf", _category], false] call emf_fnc_defineFunction;
[_category, "enhancedAIConvoy", format["%1\fn_enhancedAIConvoy.sqf", _category], false] call emf_fnc_defineFunction;

["TRACE", "Finished defining functions...", _category, "xeh_prep"] call EMF_DEBUG;
