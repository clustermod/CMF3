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
 * call cmf_utility_fnc_clearVehicleCargo
 *
 * Public: No
 */
SCRIPT(clearVehicleCargo);

if (!isServer) exitWith {};

["AllVehicles", "init", {
    params ["_vehicle"];

    if (!SETTING(clearCargo)) exitWith {};

    if (_vehicle isKindOf "CAManBase") exitWith {};

    if (_vehicle getVariable [QGVAR(clearCargo_vehicleDisable), false]) exitWith {};

    clearItemCargoGlobal _vehicle;
    clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
    clearBackpackCargoGlobal _vehicle;

    [{ (itemCargo _this) isNotEqualTo [] }, {}, _vehicle, 2, {
        _this addItemCargoGlobal ["ACE_rope12", 1];
    }] call CBA_fnc_waitUntilAndExecute;

    /* Raise event */
    [QGVAR(clearCargo_onClearCargo), [_vehicle], _vehicle] call CBA_fnc_targetEvent;
}, true, [], true] call CBA_fnc_addClassEventHandler;