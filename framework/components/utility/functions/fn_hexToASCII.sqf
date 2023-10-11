/*
 * Author: Eric
 * Parses string and replaces hex codes with their ASCII equivilant
 *
 * Arguments:
 * 0: String <STRING>
 *
 * Return Value:
 * String <STRING>
 *
 * Example:
 * ["example%20mission"] call cmf_utility_fnc_hexToASCII
 *
 * Public: Yes
 */
params ["_string"];
// @TODO: Move to common
_ifnc_stringReplace = {
    params ["_string", "_substring", "_replaceWith"];

    _pos = _string find _substring;
    if (_pos isEqualTo -1) exitWith { _string };
    [[(_string select [0, _pos]), _replaceWith, _string select [_pos + count _substring,count _string]] joinString "", _substring, _replaceWith] call _ifnc_stringReplace;
};

{
    _string = [_string, _x select 0, _x select 1] call _ifnc_stringReplace;
} forEach [
    ["_"  , " "],
    ["%20", " "],
    ["%21", "!"],
    ["%22", '"'],
    ["%23", "#"],
    ["%24", "$"],
    ["%25", "%"],
    ["%26", "&"],
    ["%27", "'"],
    ["%28", "("],
    ["%29", ")"],
    ["%2a", "*"],
    ["%2b", "+"],
    ["%2c", ","],
    ["%2e", "."],
    ["%2f", "/"],
    ["%3a", ":"],
    ["%3b", ";"],
    ["%3c", "<"],
    ["%3d", "="],
    ["%3e", ">"],
    ["%3f", "?"],
    ["%40", "@"],
    ["%5b", "["],
    ["%5c", "\"],
    ["%5d", "]"],
    ["%5e", "^"],
    ["%5f", "_"],
    ["%60", "`"],
    ["%7e", "~"]
];

_string;
