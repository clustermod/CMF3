#include "script_component.hpp"
/*
 * Author: Eric
 * Validate a loadout and check for script errors.
 *
 * Arguments:
 * 0: Loadout Name <STRING>
 * 1: Role <STRING>
 *
 * Return Value:
 * valid <BOOLEAN>
 *
 * Example:
 * ["example_loadout"] call cmf_kosherArsenal_fnc_validateLoadout
 *
 * Public: Yes
 */
params ["_loadoutName", ["_role", "RFL"]];

private _loadout = format["rsc\loadouts\%1.sqf", _loadoutName];
private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

if (isNil "_whitelist") exitWith { false };
true;