#include "script_component.hpp"
/*
 * Author: Eric
 * make garage vehicle global
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myVehicle] call cmf_kosherGarage_fnc_syncVehicle
 *
 * Public: No
 */
SCRIPT(syncVehicle);
private _veh = _this;

/* Get all the vehicle settings and spawn a global vehicle */
private _type = typeOf _veh;
private _textures = getObjectTextures _veh;
private _current_mags = (getPylonMagazines (_veh));
private _pos = getPos _veh;
private _dir = getDir _veh;

/* Get the state of vehicle components */
private _animationNames = animationNames _veh;
private _animationValues = [];
{
    _animationValues pushBack (_veh animationPhase _x);
} forEach _animationNames;

/* Delete the local preview vehicle */
deleteVehicle _veh;
waitUntil {!alive _veh};
sleep 0.1;

/* Create a new global vehicle and set all the settings */
private _veh = createvehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
missionNameSpace setVariable ["BIS_fnc_garage_center", _veh];
_veh setDir _dir;
_veh setVariable [QGVAR(vehicle), true, true];

/* Clear the vehicle cargo */
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;

/* Apply camo, components and pylons */
{ _veh animate [_x,_animationValues select _forEachIndex,true] } forEach _animationNames;
{ _veh setObjectTextureGlobal [_forEachIndex,_x] } forEach _textures;
{ _veh setPylonLoadOut [_forEachIndex+1, _x,true] } forEach _current_mags;
