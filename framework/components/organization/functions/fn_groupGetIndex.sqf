#include "script_component.hpp"
/*
 * Author: Eric
 * Get's group index on group level
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 1: Type Filter (optional, default: true) <BOOLEAN>
 * 
 * Return Value:
 * Index <NUMBER>
 * 
 * Example:
 * [myGroup] call cmf_organization_fnc_groupGetIndex
 * 
 * Public: Yes
 */
params ["_group", ["_filter", true]];

if !([_group] call FUNC(groupIsRegistered)) exitWith { -1 };

private _groupData = [_group] call FUNC(groupGetData);
_groupData params ["_level", "_type", "_parent"];

/* private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
private _siblings = [_groupsHash, _level, []] call CBA_fnc_hashGet; */

private _parentData = [_parent] call FUNC(groupGetData);
_parentData params ["", "", "", "_siblings"];

_siblings = _siblings select { count units _x > 0 };

if _filter then {
    _siblings = _siblings select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
};

private _index = _siblings find _group;

_index;