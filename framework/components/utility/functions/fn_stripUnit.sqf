#include "script_component.hpp"
/*
 * Author: Eric
 * Strips supplied unit of all gear (will fail to remove weapon and backpack in multiplayer)
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call cmf_utility_fnc_stripUnit
 *
 * Public: yes
 */
SCRIPT(stripUnit);
params["_unit"];
// @TODO: Move to common
/* Strip the unit of all gear and weapons */
[_unit, (primaryWeapon _unit)] remoteExecCall ["CBA_fnc_removeWeapon", _unit];
[_unit, (handgunWeapon _unit)] remoteExecCall ["CBA_fnc_removeWeapon", _unit];
[_unit, (secondaryWeapon _unit)] remoteExecCall ["CBA_fnc_removeWeapon", _unit];
removeBackpackGlobal _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeHeadgear _unit;
removeGoggles _unit;

/* Raise event */
if (isPlayer _unit) then {
    [QGVAR(stripUnit_onStrip), [], _unit] call CBA_fnc_targetEvent;
};
