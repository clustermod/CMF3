#include "script_component.hpp"
/*
 * Author: Eric
 * This function is used to localize strings in CMF, since stringtables can only be defined at mission root i did not consider them to be a viable option
 *
 * Arguments:
 * 0: Stringtable path <STRING>
 * 0: String <STRING>
 *
 * Return Value:
 * Localized string <STRING>
 *
 * Example:
 * ["STR_cmf_3den_spawn"] call cmf_main_fnc_localize
 *
 * Public: Yes
 */
SCRIPT(localize);

params [["_stringtable", ""], ["_string", ""]];

/* Check if stringtable exists */
if !(FILE_EXISTS(_stringtable)) exitWith {
    WARNING_1("Failed to find stringtable %1", _stringtable);
    _string
};

/* Get stringtable */
private _hashStringtable = [(call compile preProcessFileLineNumbers _stringtable)] call CBA_fnc_hashCreate;

/* Get string entry from stringtable */
private _stringHash = [_hashStringtable, _string] call CBA_fnc_hashGet;
_stringHash = [_stringHash] call CBA_fnc_hashCreate;

/* Check if string exists */
if (isNil "_stringHash") exitWith {
    WARNING_1("Failed to localize %1", _string);
    _string
};

/* Get localized string from string entry */
private _lstring = [_stringHash, language] call CBA_fnc_hashGet;

/* Check if localization exists */
if (isNil "_lstring") exitWith {
    WARNING_1("Failed to localize string to %1", language);
    _string
};

/* Return localized string */
_lstring;
