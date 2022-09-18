#include "script_component.hpp"
/*
 * Author: Eric
 * Mimics kosherArsenal and allows setting the kosherGarage whitelist based on squad/squad type and garage id
 *
 * Arguments:
 * 0: Loadout ID <STRING>
 * 1: Loadout File <STRING>
 *
 * Return Value:
 * loadoutID <STRING>
 *
 * Example:
 * ["loadoutID", "LoadoutFile"] call emf_kosherGarage_fnc_registerWhitelist
 *
 * Public: Yes
 */
SCRIPT(registerWhitelist);
params["_loadoutid", "_file"];

private _loadout = format["rsc\loadouts\%1.sqf", _file];
if !(FILE_EXISTS(_loadout)) exitWith { ERROR_MSG_1("Loadoutfile %1 does not exist", str _file) };

/* Set the loadout */
private _whitelistsArray = missionNamespace getVariable [QGVAR(whitelists), createHashMap];
_whitelistsArray set [_loadoutid, _loadout];
private _whitelistsArray = missionNamespace setVariable [QGVAR(whitelists), _whitelistsArray, true];

_loadoutid;
