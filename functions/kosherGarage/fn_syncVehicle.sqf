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
 * [_myVehicle] call emf_kosherGarage_fnc_syncVehicle
 *
 * Public: No
 */
private _veh = _this;

// Remove crew
{ deleteVehicle _x } forEach crew _veh;

// Get all settings and create a global vehicle
private _type = typeOf _veh;
private _textures = getObjectTextures _veh;
private _current_mags = (getPylonMagazines (_veh));
private _pos = getPos _veh;
private _dir = getDir _veh;

// Get the state of vehicle components
private _animationNames = animationNames _veh;
private _animationValues = [];
{
    _animationValues pushBack (_veh animationPhase _x);
} forEach _animationNames;

// Check if vehicle is allowed
private _whitelist = missionNameSpace getVariable ["mpg_garage_whitelistedCategories", ["ALL"]];
private "_allowed";
if ((_whitelist select 0) != "ALL") then {
    private _conversionLUT = [["Car", "WHEELED"], ["Tank", "TRACKED"], ["Ship", "NAVAL"], ["Helicopter", "ROTARYWING"], ["Plane", "FIXEDWING"], ["StaticWeapon", "STATIC"]];
    _allowed = false;
    {
        if (_veh isKindOf (_x select 0)) exitWith { _allowed = true };
    } forEach _conversionLUT;
} else {
    _allowed = true;
};

// Delete the local preview vehicle
deleteVehicle _veh;
waitUntil {!alive _veh};
sleep 0.1;

// Create a new global vehicle and set all the settings
if (_allowed) then {
    private _veh = createvehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
    missionNameSpace setVariable ["BIS_fnc_garage_center", _veh];
    _veh setDir _dir;
    _veh setVariable ["mpg_garage_vehicle", true];

    // Clear vehicle cargo
    clearWeaponCargoGlobal _veh;
    clearMagazineCargoGlobal _veh;

    // Set settings
    { _veh animate [_x,_animationValues select _forEachIndex,true] } forEach _animationNames;
    { _veh setObjectTextureGlobal [_forEachIndex,_x] } forEach _textures;
    { _veh setPylonLoadOut [_forEachIndex+1, _x,true] } forEach _current_mags;

    // Enable Enhanched Vehicles on it
    if (_veh isKindOf "car" || _veh isKindOf "tank") then {
        [_veh] remoteExecCall ["emf_ehv_fnc_init", 0, true];
    };
};
