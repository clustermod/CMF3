#include "script_component.hpp"
/*
 * Author: Eric
 * Sets Group data on group
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 1: Data <ARRAY>
 *  - Level <NUMBER>
 *  - Type <STRING>
 *  - Parent <GROUP>
 *  - Children <ARRAY>
 *  - Priority <NUMBER>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [_myGroup, _groupData] call cmf_organization_fnc_groupSetData
 * 
 * Public: No
 */
params ["_group", "_data"];
_data params [["_level", 0], ["_type", "INF"], ["_parent", grpNull], ["_children", []], ["_priority", 0], ["_hierarchyOptions", [false, false]]];

_group setVariable [QGVAR(groupData), [_level, _type, _parent, _children, _priority, _hierarchyOptions], true];