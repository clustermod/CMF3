#include "script_component.hpp"
/*
 * Author: Eric
 * Returns groupdata for a group
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 
 * Return Value:
 * - Level <NUMBER>
 * - Type <STRING>
 * - Parent <GROUP>
 * - Children <ARRAY>
 * - Priority <NUMBER>
 * 
 * Example:
 * [_myGroup] call cmf_organization_fnc_groupGetData
 * 
 * Public: Yes
 */
params ["_group"];
    
_group getVariable [QGVAR(groupData), [-1, "", grpNull, [], 0, [false, false]]];