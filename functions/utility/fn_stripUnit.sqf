#include "script_component.hpp"
/*
 * Author: Eric
 * Strips supplied unit of everything
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call emf_utility_fnc_stripUnit
 *
 * Public: yes
 */
SCRIPT(stripUnit);
params["_unit"];

/* Strip the unit of all gear and weapons */
[_unit, (primaryWeapon player)] remoteExecCall ["CBA_fnc_removeWeapon", (owner _unit)];
[_unit, (handgunWeapon player)] remoteExecCall ["CBA_fnc_removeWeapon", (owner _unit)];
[_unit, (secondaryWeapon player)] remoteExecCall ["CBA_fnc_removeWeapon", (owner _unit)];
[_unit] remoteExec ["removeBackpackGlobal", (owner _unit)];
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;
removeGoggles _unit;
