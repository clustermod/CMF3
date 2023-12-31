#include "script_component.hpp"
/*
 * Author: Eric
 * Compiles a preset into a CBA Hash
 * 
 * Arguments:
 * 0: Preset data <CODE>
 * 
 * Return Value:
 * Compiled Preset data <CBA HASH>
 * 
 * Example:
 * [_myPreset] call cmf_logistics_fnc_presetCompile
 * 
 * Public: No
 */
params ["_preset"];

private _code = toString _preset;
_code = _code + 
"[
	[_available, 0] select (isNil '_available'), 
	[_class, ''] select (isNil '_class'),
	[_weapons, []] select (isNil '_weapons'),
	([_magazines, []] select (isNil '_magazines'))+ 
	([_grenades, []] select (isNil '_grenades')),
	[_items, []] select (isNil '_items'),
	[_cargo, []] select (isNil '_cargo')
]";

call compile _code;