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

/* Function to check if unit is in a vehicle's operator position */
private _fnc_isOperator = {
    private _unit = _this;

    _unit isEqualTo (commander (vehicle _unit)) || 
    { _unit isEqualTo (driver (vehicle _unit)) || 
    { _unit isEqualTo  (gunner (vehicle _unit)) }};
};

/* Crewman */
if ((vehicle _unit) isKindOf "Tank" && (_unit call _fnc_isOperator)) exitWith {_unit setVariable[QGVAR(kosherai_role), "CRW"]; "CRW"};

/* Rotary Pilot */
if ((vehicle _unit) isKindOf "Helicopter" && (_unit call _fnc_isOperator)) exitWith {_unit setVariable[QGVAR(kosherai_role), "RPIL"]; "RPIL"};

/* Fixed Wing Pilot */
if ((vehicle _unit) isKindOf "Plane" && (_unit call _fnc_isOperator)) exitWith {_unit setVariable[QGVAR(kosherai_role), "WPIL"]; "WPIL"};

/* Medic */
if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant") isEqualTo 1) exitWith {_unit setVariable[QGVAR(kosherai_role), "MED"]; "MED"};

/* Engineer */
if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "engineer") isEqualTo 1) exitWith {_unit setVariable[QGVAR(kosherai_role), "ENG"]; "ENG"};

/* Anti-tank */
if ((secondaryWeapon _unit) != "") exitWith {_unit setVariable[QGVAR(kosherai_role), "AT"]; "AT"};

/* Machinegunner */
if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "MachineGun") exitWith {_unit setVariable[QGVAR(kosherai_role), "MG"]; "MG"};

/* Sniper */
if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "SniperRifle") exitWith {_unit setVariable[QGVAR(kosherai_role), "MAR"]; "MAR"};

/* Squad Leader */
if ((leader _unit) isEqualTo _unit) exitWith {_unit setVariable[QGVAR(kosherai_role), "SL"]; "SL"};

/* Rifleman */
_unit setVariable[QGVAR(kosherai_role), "RFL"]; "RFL"