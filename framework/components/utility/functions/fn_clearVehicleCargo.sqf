#include "script_component.hpp"
/*
 * Author: Eric
 * Clears default vehicle cargo on spawn
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_utility_fnc_clearVehicleCargo
 *
 * Public: No
 */
SCRIPT(clearVehicleCargo);

if (!isServer) exitWith {};

["AllVehicles", "init", {
    params ["_vehicle"];

    if (!GVAR(setting_clearCargo)) exitWith {};

    if (_vehicle isKindOf "CAManBase") exitWith {};

    if (_vehicle getVariable [QGVAR(clearCargo_vehicleDisable), false]) exitWith {};

    // @TODO: whitelist ropes
    clearItemCargoGlobal _x;
    clearMagazineCargoGlobal _x;
    clearWeaponCargoGlobal _x;
    clearBackpackCargoGlobal _x;
    _x setVariable [QGVAR(clearCargo_initialized), true, true];

    /* Raise event */
    [QGVAR(clearCargo_onClearCargo), [_x], _x] call CBA_fnc_targetEvent;
}, true, [], true] call CBA_fnc_addClassEventHandler;