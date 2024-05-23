#include "script_component.hpp"
/*
 * Author: Eric
 * Finds parents and children for group
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [_myGroup] call cmf_organization_fnc_groupSetup
 * 
 * Public: No
 */
if (!isServer) exitWith {};

/* Queue to not overwrite other groups */
if (isNil QGVAR(groupSetupQueue)) then {
    GVAR(groupSetupQueue) = [];
    GVAR(groupSetupScript) = scriptNull;
};

GVAR(groupSetupQueue) pushBack _this;

if (scriptDone GVAR(groupSetupScript)) then {
    GVAR(groupSetupScript) = 0 spawn {
        private "_selected";

        while {
            _selected = GVAR(groupSetupQueue) deleteAt 0;
            !isNil "_selected"
        } do {
            _selected params ["_group"];

            private _isPlayerGroup = {
                params ["_group"];

                if is3DEN exitWith {
                    units _group findIf { (_x get3DENAttribute "ControlMP") select 0 } > -1
                };

                units _group findIf { isPlayer _x } > -1
            };

            private _groupData = [_group] call FUNC(groupGetData);
            /* private _isEmpty = (count units _group) isEqualTo 0; */
            private _hierArchyOptions = _groupData param [5, [false, false]];

            if ((_groupData select 0) isEqualTo -1 /* || _isEmpty */) then { continue };

            private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
            private _typeOrbat = [GVAR(orbat), (_groupData select 1)] call CBA_fnc_hashGet;
            private _levelOrbat = [_typeOrbat select 0, (_groupData select 0)] call CBA_fnc_hashGet;

            /* Assign children */
            if ([_levelOrbat select 1, _groupData select 1, 0] call CBA_fnc_hashGet > 0) then {
                private _subLevels = [_groupsHash, (_groupData select 0) - 1, []] call CBA_fnc_hashGet;
                
                private _i = 0;
                while { _i < count _subLevels && { [_levelOrbat select 1, _groupData select 1, 0] call CBA_fnc_hashGet > count (_groupData select 3) } } do {
                    private _subGroup = _subLevels select _i;
                    private _subGroupData = [_subGroup] call FUNC(groupGetData);

                    _subGroupHierArchyOptions = _subGroupData param [5, [false, false]];
                    if (
                        !(_hierArchyOptions param [0, false]) && { !(_subGroupHierArchyOptions param [0, false]) } || 
                        (_hierArchyOptions param [0, false] && { [_subGroup] call _isPlayerGroup }) && 
                        { _subGroupHierArchyOptions param [0, false] && { [_group] call _isPlayerGroup } }
                    ) then {
                        if ((_subGroupData select 1) isEqualTo (_groupData select 1) && { isNull (_subGroupData select 2) /* && { (count units _subGroup) > 0 } */ }) then {
                            (_groupData select 3) pushBack _subGroup;
                            _subGroupData set [2, _group];
                            [_subGroup, _subGroupData] call FUNC(groupSetData);
                            [_group, _groupData] call FUNC(groupSetData);
                        };
                    };

                    _i = _i + 1;
                };
            };

            /* Assign Parent */
            private _surLevels = [_groupsHash, (_groupData select 0) + 1, []] call CBA_fnc_hashGet;

            private "_smallestCount";
            {
                private _surGroup = _x;
                private _surGroupData = [_surGroup] call FUNC(groupGetData);
                private _surTypeOrbat = [GVAR(orbat), (_surGroupData select 1)] call CBA_fnc_hashGet;
                private _surLevelOrbat = [_surTypeOrbat select 0, (_surGroupData select 0)] call CBA_fnc_hashGet;
                private _surGroupHierArchyOptions = _surGroupData param [5, [false, false]];

                private _typeAmount = [_surLevelOrbat select 1, _groupData select 1, 0] call CBA_fnc_hashGet;
                private _typeCount = { (([_x] call FUNC(groupGetData)) select 1) isEqualTo (_groupData select 1) } count (_surGroupData select 3);
                
                if (
                    !(_hierArchyOptions param [1, false]) && { !(_surGroupHierArchyOptions param [0, false]) } || 
                    (_hierArchyOptions param [1, false] && { [_surGroup] call _isPlayerGroup }) && 
                    { _surGroupHierArchyOptions param [0, false] && { [_group] call _isPlayerGroup } }
                ) then {
                    if (_typeAmount > _typeCount /* && { (count units _surGroup) > 0 } */) then {
                        (_surGroupData select 3) pushBack _group;
                        _groupData set [2, _surGroup];
                        [_surGroup, _surGroupData] call FUNC(groupSetData);
                        [_group, _groupData] call FUNC(groupSetData);
                    };
                };

                if (!isNull (_groupData select 2)) exitWith {};

                if (isNil "_smallestCount" || { _typeCount < _smallestCount select 0 }) then {
                    _smallestCount = [_typeCount, _surGroup];
                };
            } forEach _surLevels;
            
            /* Select group with least of this group type */
            if (isNull (_groupData select 2) && { !isNil "_smallestCount" }) then {
                private _surGroup = (_smallestCount select 1);
                private _surGroupData = [_surGroup] call FUNC(groupGetData);
                
                if true /* (count units _surGroup) > 0 */ then {
                    (_surGroupData select 3) pushBack _group;
                    _groupData set [2, _surGroup];
                    [_surGroup, _surGroupData] call FUNC(groupSetData);
                    [_group, _groupData] call FUNC(groupSetData);
                };
            };

            [_group, _groupData] call FUNC(groupSetData);

            /* Set Group Name */
            [_group, _groupData] call FUNC(groupSetName);

            /* Set new group names for children */
            {
                [_x] call FUNC(groupSetName);
            } forEach (_groupData select 3);

            LOG_1("Finished Group Setup: %1", _group);

            [QGVAR(groupRegistered), [_group, _groupData]] call CBA_fnc_globalEvent;
        };
    };
};