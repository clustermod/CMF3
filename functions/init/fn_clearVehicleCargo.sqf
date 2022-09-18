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
 * [] call emf_init_fnc_clearVehicleCargo
 *
 * Public: No
 */
SCRIPT(clearVehicleCargo);

/* Check if the function is enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,clearVehicleCargo) ) isEqualTo 1;
if !(_enabled) exitWith {};

if (isServer) then {
    {
        if !(_x getVariable [QGVAR(clearCargo_vehicleDisable), false]) then {
            clearItemCargoGlobal _x;
            clearMagazineCargoGlobal _x;
            clearWeaponCargoGlobal _x;
            clearBackpackCargoGlobal _x;
        };
    } forEach vehicles;
};

/* Enable on zeus spawned vehicles */
[] spawn {
    if (isDedicated) exitWith {};
    waitUntil{!isnull (getAssignedCuratorLogic player)};
    (getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {
        private _entity = _this select 1;

        /* Check if it has been disabled on the entity */
        if (_entity getVariable [QGVAR(clearCargo_vehicleDisable), false]) exitWith {};

        /* Check if it has been disabled globally */
        if (missionNamespace getVariable [QGVAR(clearCargo_disable), false]) exitWith {};

        if (_entity isKindOf "LandVehicle" || _entity isKindOf "Air" || _entity isKindOf "Ship") then {
            clearItemCargoGlobal _entity;
            clearMagazineCargoGlobal _entity;
            clearWeaponCargoGlobal _entity;
            clearBackpackCargoGlobal _entity;
        };
    }];
};
