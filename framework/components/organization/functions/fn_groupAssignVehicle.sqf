#include "script_component.hpp"
/*
 * Author: Eric
 * Assign vehicle to group
 * 
 * Arguments:
 * 0: Group or dynamic group <GROUP or ARRAY>
 *	- 0: side <SIDE>
 *	- 1: Level <NUMBER>
 *	- 2: Index <NUMBER>
 *	- 3: Type (optional, default: "") <STRING>
 *	- 4: children (optional, default: false) <BOOLEAN>
 * 1: Vehicle <OBJECT>
 * 
 * Return Value:
 * nil
 * 
 * Example:
 * [myGroup, myVehicle] call cmf_organization_fnc_groupAssignVehicle
 * 
 * Public: Yes
 */
 if (!isServer) exitWith {};

params ["_group", "_vehicle"];

if (_group isEqualType []) exitWith {
    _group params ["_side", "_level", "_index", "_type", "_children"];

    private _vehiclesHash = [GVAR(groupVehicles), _side, []] call CBA_fnc_hashGet;
    _vehiclesHash pushBack [[_level, _index, _type, _children], _vehicle];
    GVAR(groupVehicles) = [GVAR(groupVehicles), _side, _vehiclesHash] call CBA_fnc_hashSet;
    publicVariable QGVAR(groupVehicles);

    /* Check if group already exists and then assign vehicle */
    private _groupsHash = [GVAR(groups), _side, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
    private _candidates = [_groupsHash, _level, []] call CBA_fnc_hashGet;
    _candidates = _candidates select { (count units _x) > 0 };
    
    if (_type isNotEqualTo "") then {
        _candidates = _candidates select { (([_x] call FUNC(groupGetData)) select 1) isEqualTo _type };
    };

    {
        private _testGroup = _x;
        private _testGroupData = [_testGroup] call FUNC(groupGetData);
        private _testGrouplevel = _testGroupData select 0;
        private _testGroupindex = [_testGroup, false] call FUNC(groupGetIndex);

        if ([_level, _index] isEqualTo [_level, _testGroupindex]) then {

            [_testGroup, _vehicle] call FUNC(groupAssignVehicle);

            if (_children) then {
                {
                    [_x, _vehicle] call FUNC(groupAssignVehicle);
                } forEach (_testGroupData select 3);
            };
        };
    } forEach _candidates;
};

if (!isNull (_group getVariable [QGVAR(vehicle), objNull])) then {
    private _oldVehicle = _group getVariable [QGVAR(vehicle), objNull];
    {
        unassignVehicle _x;
    } forEach units _group;
    _group leaveVehicle _vehicle;
};

{
    if (leader _group isEqualTo _x) then {
        _x assignAsDriver _vehicle;
    } else {
        _x assignAsCargo _vehicle;
    };
} forEach units _group;
_group addVehicle _vehicle;

private _groups = _vehicle getVariable [QGVAR(groups), []];
_groups pushBackUnique _group;

[_vehicle, QGVAR(groups), _groups] call CBA_fnc_setVarNet;
[_group, QGVAR(vehicle), _vehicle] call CBA_fnc_setVarNet;