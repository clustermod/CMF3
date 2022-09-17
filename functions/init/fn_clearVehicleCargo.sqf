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

// Get config setting
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,clearVehicleCargo) ) isEqualTo 1;
if !(_enabled) exitWith {};

if (isServer) then {
    {
        if !(_x getVariable [QGVAR(clearCargo_disable), false]) then {
            clearItemCargoGlobal _x;
            clearMagazineCargoGlobal _x;
            clearWeaponCargoGlobal _x;
            clearBackpackCargoGlobal _x;
        };
    } forEach vehicles;
};

[] spawn {
    if (isDedicated) exitWith {};
    waitUntil{!isnull (getAssignedCuratorLogic player)};
    (getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {
        private _entity = _this select 1;
        if (_entity isKindOf "LandVehicle" || _entity isKindOf "Air" || _entity isKindOf "Ship") then {
            clearItemCargoGlobal _entity;
            clearMagazineCargoGlobal _entity;
            clearWeaponCargoGlobal _entity;
            clearBackpackCargoGlobal _entity;
        };
    }];
};
