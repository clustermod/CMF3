#include "script_component.hpp"
/*
 * Author: Eric
 * Reorganizes all groups in group hash (should be run after all groups are registered for group priority)
 * 
 * Arguments:
 * 0: Side <SIDE>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [west] call cmf_organization_fnc_groupReorganize
 * 
 * Public: Yes
 */
if (!isServer) exitWith {};

/* Make sure all groups are registered before reorganizing */
if (isNil QGVAR(groupRegisterScript)) then {
    GVAR(groupRegisterScript) = scriptNull;
};

if (isNil QGVAR(groupSetupScript)) then {
    GVAR(groupSetupScript) = scriptNull;
};

[{scriptDone GVAR(groupRegisterScript) && { scriptDone GVAR(groupSetupScript) }}, {
    params ["_side"];

    private _allGroups = [];
    private _groupsHash = [GVAR(groups), _side, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    {
        private _level = _x;
        private _levelsHash = [_groupsHash, _level, []] call CBA_fnc_hashGet;

        _levelsHash = [_levelsHash, [], { ([_x] call FUNC(groupGetData)) select 4 }] call BIS_fnc_sortBy;
        _allGroups append _levelsHash;

        _groupsHash = [_groupsHash, _level, _levelsHash] call CBA_fnc_hashSet;
    } forEach ([_groupsHash] call CBA_fnc_hashKeys);
    GVAR(groups) = [GVAR(groups), _side, _groupsHash] call CBA_fnc_hashSet;
    publicVariable QGVAR(groups);

    /* Redo setup on all the groups */
    {
        /* Clear children and parents */
        private _groupData = [_x] call FUNC(groupGetData);
        _groupData set [2, grpNull];
        _groupData set [3, []];
        [_x, _groupData] call FUNC(groupSetData);

        [_x] call FUNC(groupSetup);
    } forEach _allGroups;
}, _this] call CBA_fnc_waitUntilAndExecute;