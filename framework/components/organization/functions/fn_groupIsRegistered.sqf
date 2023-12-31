#include "script_component.hpp"
/*
 * Author: Eric
 * Returns true if group is registered in the dynamic group system
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 
 * Return Value:
 * isRegistered <BOOLEAN>
 * 
 * Example:
 * [_mtGroup] call cmf_organization_fnc_groupIsRegistered
 * 
 * Public: Yes
 */
params ["_group"];

(([_group] call FUNC(groupGetData)) select 0) > -1