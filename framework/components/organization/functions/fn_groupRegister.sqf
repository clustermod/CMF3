#include "script_component.hpp"
/*
 * Author: Eric
 * Registers a group into the dynamic group system
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 1: Level (Optional, defualt: 0) <NUMBER>
 * 2: Type (Optional, defualt: "INF") <STRING>
 * 3: Hierarchy Options <ARRAY>
    - 0: Children groups must be player group <BOOLEAN>
    - 1: Parent group must be player group <BOOLEAN>
 * 4: Priority (Optional, defualt: 0) <NUMBER>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [_myGroup, 1, "MBT"] call cmf_organization_fnc_groupRegister
 * 
 * Public: Yes
 */

if (!isServer) exitWith {};

/* Queue to not overwrite other groups */
if (isNil QGVAR(groupRegisterQueue)) then {
    GVAR(groupRegisterQueue) = [];
    GVAR(groupRegisterScript) = scriptNull;
};

GVAR(groupRegisterQueue) pushBack _this;

if (scriptDone GVAR(groupRegisterScript)) then {
    GVAR(groupRegisterScript) = 0 spawn {
        private "_selected";

        waitUntil { !isNil QGVAR(groups) };

        while {
            _selected = GVAR(groupRegisterQueue) deleteAt 0;
            !isNil "_selected"
        } do {
            _selected params ["_group", ["_level", 0], ["_type", "INF"], ["_hierarchyOptions", []], ["_priority", 0]];
            _hierarchyOptions params [["_childrenPlayerGroups", false], ["_parentPlayerGroup", false]];

            [_group, [_level, _type, grpNull, [], _priority, _hierarchyOptions]] call FUNC(groupSetData);

            private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
            private _levelsHash = [_groupsHash, _level, []] call CBA_fnc_hashGet;
            _levelsHash pushBackUnique _group;
            _groupsHash = [_groupsHash, _level, _levelsHash] call CBA_fnc_hashSet;
            GVAR(groups) = [GVAR(groups), side _group, _groupsHash] call CBA_fnc_hashSet;
            publicVariable QGVAR(groups);

            LOG_1("Registered Group: %1", _group);
            
            [_group] call FUNC(groupSetup);
        };
    };
};