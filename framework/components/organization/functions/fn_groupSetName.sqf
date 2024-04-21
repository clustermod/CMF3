#include "script_component.hpp"
/*
 * Author: Eric
 * Set Group name based on orbat function
 * 
 * Arguments:
 * 0: Group <GROUP>
 * 1: Group Data (optional) <ARRAY>
 * 
 * Return Value:
 * Names <ARRAY>
 *	- 0: Base Name <STRING>
 *	- 1: Pretty Name <STRING>
 *	- 2: Group ID <STRING>
 *	- 3: Group Color <ARRAY>
 * 
 * Example:
 * [_myGroup] call cmf_organization_fnc_groupSetName
 * 
 * Public: Yes
 */
params ["_group", ["_groupData", [_this select 0] call FUNC(groupGetData) ]];

private _groupsHash = [GVAR(groups), side _group, [] call CBA_fnc_hashCreate] call CBA_fnc_hashGet;
private _typeOrbat = [GVAR(orbat), (_groupData select 1)] call CBA_fnc_hashGet;
private _levelOrbat = [_typeOrbat select 0, (_groupData select 0)] call CBA_fnc_hashGet;

_groupData params ["_level", "_type", "_parent", "_children"];
_levelOrbat params ["_fnc_generateName"];

/* Get Group Name */
private _names = [_group, _level, _type, _parent, _children] call _fnc_generateName;

/* Set Group Name */
if (!isNil "_names") then {
    _names params ["_cleanName", "_prettyName", "_groupID", ["_colors", [[1, 1, 0.2, 0.7], [1, 1, 0.2, 0.95]]]];

    _group setVariable [QGVAR(groupName), [_cleanName, _prettyName], true];
    _group setGroupIdGlobal [_groupID];
    [[_groupID, _colors select 0, _colors select 1], ace_map_gestures_fnc_addGroupColorMapping] remoteExec ["call", 0, true];

    /* Handle 3DEN */
    if is3DEN then {
        _group set3DENAttribute ["groupID", _names select 2];
        {
            private _roleName = _x get3DENAttribute "description";
            _x set3DENAttribute ["description", format["%1@%2", ((_roleName select 0) splitString "@") select 0, _names select 0]];
        } forEach units _group;
    } else {
        systemchat format ["Registered Group: %1", _names select 2];
    };
};

_names;