#include "script_component.hpp"
/*
 * Author: Eric
 * Estimates the AI unit's role and assigns a kosher ai role.
 * 
 * Arguments:
 * 0: Unit <OBJECT>
 * 
 * Return Value:
 * Role <STRING>
 * 
 * Example:
 * [_myUnit] call cmf_kosherAI_fnc_getRole
 * 
 * Public: No
 */

params["_unit"];

/* Check if unit already has a assigned role */
if (!isNil { _unit getVariable QGVAR(role) }) exitWith {
    _unit getVariable QGVAR(role);
};

/* Function to check if unit is in a vehicle's operator position */
private _fnc_isOperator = {
    private _unit = _this;

    _unit isEqualTo (commander (vehicle _unit)) || 
    { _unit isEqualTo (driver (vehicle _unit)) || 
    { _unit isEqualTo  (gunner (vehicle _unit)) }};
};

/* Crewman */
if ((vehicle _unit) isKindOf "Tank" && { (_unit call _fnc_isOperator) }) exitWith {_unit setVariable [QGVAR(role), "CRW"]; "CRW"};

/* Rotary Pilot */
if ((vehicle _unit) isKindOf "Helicopter" && { (_unit call _fnc_isOperator) }) exitWith {_unit setVariable [QGVAR(role), "RPIL"]; "RPIL"};

/* Fixed Wing Pilot */
if ((vehicle _unit) isKindOf "Plane" && { (_unit call _fnc_isOperator) }) exitWith {_unit setVariable [QGVAR(role), "WPIL"]; "WPIL"};

/* Medic */
if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant") isEqualTo 1) exitWith {_unit setVariable [QGVAR(role), "MED"]; "MED"};

/* Engineer */
if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "engineer") isEqualTo 1) exitWith {_unit setVariable [QGVAR(role), "ENG"]; "ENG"};

/* Anti-tank */
if ((secondaryWeapon _unit) != "") exitWith {_unit setVariable [QGVAR(role), "AT"]; "AT"};

/* Machinegunner */
if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 isEqualTo "MachineGun") exitWith {_unit setVariable [QGVAR(role), "MG"]; "MG"};

/* Sniper */
if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 isEqualTo "SniperRifle") exitWith {_unit setVariable [QGVAR(role), "MAR"]; "MAR"};

/* Squad Leader */
if ((leader _unit) isEqualTo _unit) exitWith {_unit setVariable [QGVAR(role), "SL"]; "SL"};

/* Rifleman */
_unit setVariable [QGVAR(role), "RFL"]; "RFL"