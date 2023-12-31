#include "script_component.hpp"
/*
 * Author: Eric
 * Makes AI automatically call artillery on shared targets
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_ai_fnc_artillery
 * 
 * Public: No
 */
if (!isServer) exitWith {};

/* Register Artillery */
private _fnc_register = {
    params ["_vehicle"];

    if (_vehicle isKindOf "Man") exitWith { };

    /* Check if the vehicle is a artillery vehicle */
    private _isArtillery = [GVAR(artilleryHash), typeof _vehicle] call CBA_fnc_hashGet;
    if (isNil "_isArtillery") then {
        _isArtillery = (getNumber (configOf _vehicle >> "artilleryScanner")) > 0;
        GVAR(artilleryHash) = [GVAR(artilleryHash), typeof _vehicle, _isArtillery] call CBA_fnc_hashSet;
    };
    if (!_isArtillery) exitWith { };

    [_vehicle] call lambs_wp_fnc_taskArtilleryRegister;
    LOG_1("Registered Artillery: %1", _vehicle);
};

["AllVehicles", "init", _fnc_register, true, [], true] call CBA_fnc_addClassEventHandler;

/* Request artillery */
["lambs_danger_OnInformationShared", {
    params ["", "_shareGroup", "_target"];

    if (!SETTING(reinforceArtillery) || (getPos _target) isEqualTo []) exitWith { };

    /* Check if automatic artillery is allowed for side */
    private _allowedSides = call compile format ["[%1]", SETTING(reinforceArtillerySides)];
    if !((side _shareGroup) in _allowedSides) exitWith {};

    /* Don't do danger close */
    if ( (leader _shareGroup) distance _target < 100 ) exitWith { };

    /* Timeout between fire missions */
    private _timeout = [GVAR(artilleryTimeOut), side _shareGroup, 0] call CBA_fnc_hashGet;
    if (time < _timeout) exitWith { };
    GVAR(artilleryTimeOut) = [GVAR(artilleryTimeOut), side _shareGroup, time + SETTING(reinforceArtilleryTimeout)] call CBA_fnc_hashSet;

    private _mainSalvo = 3 + floor random 14;
    ["lambs_wp_RequestArtillery", [side _shareGroup, getPos _target, leader _shareGroup, _mainSalvo]] call CBA_fnc_serverEvent;

    GVAR(artilleryTargets) pushBack [side _shareGroup, _target, _mainSalvo];

    [{ time < ([GVAR(artilleryTimeOut), side (_this select 0), 0] call CBA_fnc_hashGet) }, {
        GVAR(artilleryTargets) deleteAt (GVAR(artilleryTargets) find (_this select 1));
    }, [_shareGroup, [side _shareGroup, _target, _mainSalvo]]] call CBA_fnc_waitUntilAndExecute;

    LOG_4("Requested Artillery: %1 rounds by %2 at %3 (Grid: %4)", _mainSalvo, _shareGroup, str getPos _target, mapGridPosition _target);
}] call CBA_fnc_addEventHandler;