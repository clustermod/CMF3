#include "script_component.hpp"
/*
 * Author: Eric
 * Unregisters group from dynamic group system
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [_myGroup] call cmf_organization_fnc_groupUnregister
 * 
 * Public: Yes
 */
params ["_group"];
    
private _groupData = [_group] call FUNC(groupGetData);

if ((_groupData select 0) isEqualTo -1) exitWith {};

private _groupsHash = [GVAR(groups), side _group] call CBA_fnc_hashGet;
private _levelsHash = [_groupsHash, (_groupData select 0), []] call CBA_fnc_hashGet;
_levelsHash deleteAt (_levelsHash find _group);
_groupsHash = [_groupsHash, (_groupData select 0), _levelsHash] call CBA_fnc_hashSet;
GVAR(groups) = [GVAR(groups), side _group, _groupsHash] call CBA_fnc_hashSet;
publicVariable QGVAR(groups);

/* Unregister children */
{
    private _childData = [_x] call FUNC(groupGetData);

    if (_childData select 0 > -1) then {
        _childData set [2, grpNull];
        _x setVariable [QGVAR(groupData), _childData, true];
    };
} forEach (_groupData select 3);

/* Unregister parents */
private _parentData = [(_groupData select 2)] call FUNC(groupGetData);
if (_parentData select 0 > -1) then {
    (_parentData select 3) deleteAt ((_parentData select 3) find _group);
    [(_groupData select 2), _parentData] call FUNC(groupSetData);
};

_group setVariable [QGVAR(groupData), nil, true];