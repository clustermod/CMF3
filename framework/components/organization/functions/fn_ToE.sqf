#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a Table of Organization and Equipment for team leaders. It gets executed automatically.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_gameplay_fnc_ToE
 *
 * Public: No
 */

[{ !isNull player && { alive player } }, {
    player createDiarySubject ["cmf_toe", "TO&E"];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) exitWith {
            { player removeDiaryRecord ["cmf_toe", _x select 8] } forEach (player allDiaryRecords "cmf_toe");
        };

        /* Add Each of the highest level groups */
        private _groupHash = [GVAR(groups), side cmf_player, []] call CBA_fnc_hashGet;
        private _levels = [_groupHash] call CBA_fnc_hashKeys;
        if (count _levels isEqualTo 0) exitWith { cmf_player createDiaryRecord ["cmf_toe", ["No Registered Groups.", ""]] };

        {
            cmf_player removeDiaryRecord ["cmf_toe", _x select 8];
        } forEach (cmf_player allDiaryRecords "cmf_toe");

        _levels sort false;
        private _topLevelGroups = [_groupHash, _levels select 0, []] call CBA_fnc_hashGet;
        reverse _topLevelGroups;

        FUNC(ToE_recursiveCheck) = {
            params ["_group", ["_indent", ""], ["_vehicle", objNull]];

            private _formattedString = "";

            private _formatGroupHeader = { format ["<font face='PuristaBold'>%1</font><br/>", _this] };

            private _groupNames = _group getVariable [QGVAR(groupName), ["UNKNOWN", "UNKNOWN"]];
            private _groupVehicle = _group getVariable [QGVAR(vehicle), objNull];
            private _groupData = [_group] call FUNC(groupGetData);
            private _units = units _group;
            _groupData params ["_level", "_type", "", "_children"];

            if (_type isNotEqualTo "ZEUS") then {                
                if (count _children > 0 || _level isEqualTo 1) then {
                    _formattedString = _formattedString + "<br/>" + _indent + ((_groupNames select 1) call _formatGroupHeader);
                    _indent = _indent + "    ";
                };
    
                if (_type isEqualTo "INF") then {
                    _formattedString = _formattedString + _indent + ((_groupNames select 0) call _formatGroupHeader);
                };
    
                if (_groupVehicle isNotEqualTo _vehicle) then {
                    private _vehicleName = [configFile >> "CfgVehicles" >> typeof _groupVehicle] call BIS_fnc_displayName;
                    _formattedString = _formattedString + _indent + format ["<font size='13' color='#fcba03'>    %1</font><br/>", _vehicleName];
                    _vehicle = _groupVehicle;
                };
                
                if (count units _group isNotEqualTo 0) then {
                    {
                        if (isPlayer _x) then {
                            private _roleDescription = "None";
                            if (roleDescription _x != "") then {
                                _roleDescription = (roleDescription _x splitString "@") select 0;
                            };
    
                            _formattedString = _formattedString + _indent + format ["    <font color='#fcba03'> %1</font>, %2<br/>", name _x, _roleDescription];
                        } else {
                            private _role = [_x] call EFUNC(kosherAI,getRole);
                            private _roleDescription = createHashMapFromArray [
                                ["CRW", "Crewman"],
                                ["RPIL", "Pilot"],
                                ["WPIL", "Pilot"],
                                ["MED", "Medic"],
                                ["ENG", "Engineer"],
                                ["AT", "Anti-Tank"],
                                ["MG", "Machinegunner"],
                                ["MAR", "Marksman"],
                                ["SL", "Leader"]
                            ] getOrDefault [_role, _role];
    
                            _formattedString = _formattedString + _indent + format ["    <font color='#888888'>[AI]</font><font color='#fcba03'> %1</font>, %2<br/>", name _x, _roleDescription];
                        };
                    } forEach units _group;
                } else {
                    _formattedString = _formattedString + _indent + "    <font color='#888888'>Empty</font><br/>";
                };
            };

            /* Sort children */
            _children = [_children, [], {
                private _group = _x;
                _groupData = [_group] call FUNC(groupGetData);
                _groupNames = _group getVariable [QGVAR(groupName), ["UNKNOWN", "UNKNOWN"]];
                _groupData params ["", "_type", "", "_children"];

                private _childrenCount = count _children;
                private _alphabetOrder = GVAR(phoneticAlphabet) findIf { (_x select [0, 1]) isEqualTo (_groupNames select [0, 1]) };

                ([_childrenCount + 1000, _alphabetOrder] select (_type isEqualTo "INF"))
            }, "ASCEND"] call BIS_fnc_sortBy;

            {
                _formattedString = _formattedString + ([_x, _indent, _vehicle] call FUNC(ToE_recursiveCheck));
            } forEach _children;

            _formattedString;
        };


        {
            private _group = _x;

            private _groupNames = _group getVariable [QGVAR(groupName), ["UNKNOWN", "UNKNOWN"]];
            private _formattedString = "<br/><font size='12'>";

            _formattedString = _formattedString + ([_group] call FUNC(ToE_recursiveCheck));

            cmf_player createDiaryRecord ["cmf_toe", [(_groupNames select 1), _formattedString]];
        } forEach _topLevelGroups;
    }];
}] call CBA_fnc_waitUntilAndExecute;