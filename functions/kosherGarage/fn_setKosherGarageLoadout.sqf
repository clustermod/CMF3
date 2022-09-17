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
 * ["loadoutID", "LoadoutFile"] call emf_kosherGarage_fnc_setKosherGarageLoadout
 *
 * Public: Yes
 */
params["_loadoutid", "_file"];

private _loadout = format["rsc\loadouts\%1.sqf", _file];
if !(FILE_EXISTS(_loadout)) exitWith { ["ERR", format["Unable to find loadoutfile: %1", _loadout], "init", "kosherArsenal"] call EMF_DEBUG };
missionNamespace setVariable ["emf_kosherGarage_loadouts_" + _loadoutid, _loadout, true];

_loadoutid;
