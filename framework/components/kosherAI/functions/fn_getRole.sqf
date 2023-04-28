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