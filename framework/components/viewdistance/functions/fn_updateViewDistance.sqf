#include "script_component.hpp"
/*
 * Author: [Authors]
 * [Description]
 * 
 * Arguments:
 * 0: Argument <TYPE>
 * 
 * Return Value:
 * Value <TYPE>
 * 
 * Example:
 * [] call cmf_[module]_fnc_[functionName]
 * 
 * Public: [yes/no]
 */

private _vehicle = missionNamespace getVariable [QGVAR(vehicleType), "INFANTRY"];

/* Update View Distance */
private _updateViewdistance = {
    params ["_values"];

    setViewDistance (_values select 0);
    setObjectViewDistance (_values select 1);
    setPiPViewDistance (_values select 2);
    setShadowDistance (_values select 3);
    setTerrainGrid (_values select 4);
};

switch (_vehicle) do {
    case "INFANTRY": {
        private _infantry = profileNamespace getVariable [QGVAR(infantry), [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
        [_infantry] call _updateViewdistance;
    };
    case "VEHICLE": {
        private _vehicle = profileNamespace getVariable [QGVAR(vehicle), [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
        [_vehicle] call _updateViewdistance;
    };
    case "AIR": {
        private _air = profileNamespace getVariable [QGVAR(air), [viewDistance, (getObjectViewDistance select 0), getPiPViewDistance, getShadowDistance, getTerrainGrid]];
        [_air] call _updateViewdistance;
    };
};