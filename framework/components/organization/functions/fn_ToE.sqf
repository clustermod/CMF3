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
 * [] call cmf_gameplay_fnc_ToE
 *
 * Public: No
 */

[{ !isNull player && alive player }, {
    player createDiarySubject ["cmf_toe", "TO&E"];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) then {
            /* Remove outdated roster */
            {
                player removeDiaryRecord ["cmf_toe", _x select 8]
            } forEach (player allDiaryRecords "cmf_toe");
        } else {
            /* Display nothing if unit isn't a team leader */
            if (player != leader group player) exitWith {};

            /* Get all player groups */
            private _allPlayerGroups = allPlayers apply { group _x };
            _allPlayerGroups = _allPlayerGroups arrayIntersect _allPlayerGroups;
            _allPlayerGroups sort true;

            private _rosterString = "<br/><font size='12'>";
            {
                private _group = _x;
                _rosterString = _rosterString + format ["<font face='PuristaBold'>%1</font><br/>", groupId _group];

                /* Get Group Vehicles */
                private _vehicles = [_group, true] call BIS_fnc_groupVehicles;
                {
                    _rosterString = _rosterString + format ["<font size='13' color='#fcba03'>    %1</font><br/>", [configFile >> "CfgVehicles" >> (typeof _x)] call BIS_fnc_displayName];
                } forEach _vehicles;

                {
                    private _unit = _x;

                    private _roleDescription = "None";
                    if (roleDescription _unit != "") then {
                        _roleDescription = ((roleDescription _unit) splitString "@") select 0;
                    };

                    /* Build equipment string */
                    private _gear = [];

                    /* Get unit's primary */
                    _gear pushBack ([configFile >> "CfgWeapons" >> (primaryWeapon _unit)] call BIS_fnc_displayName);

                    /* Get unit's launcher */
                    _gear pushBack ([configFile >> "CfgWeapons" >> (secondaryWeapon _unit)] call BIS_fnc_displayName);

                    /* Get unit's radios */
                    private _radioGear = [_x] call acre_sys_core_fnc_getGear;
                    _radioGear = _radioGear apply { [_x] call acre_api_fnc_getBaseRadio };
                    _radioGear = _radioGear select { _x != "" };
                    _radioGear = _radioGear apply { [_x + "_ID_1"] call acre_api_fnc_getDisplayName };
                    _gear append _radioGear;

                    _gear = _gear select { _x != "" };
                    _gear = _gear joinString ", ";
                    _rosterString = _rosterString + format ["<font size='13'>    <font color='#fcba03'> %1</font>, %2 - <font color='#888888'>%3</font></font><br/>", name _unit, _roleDescription, _gear];
                } forEach units _group;
            } forEach _allPlayerGroups;

            player createDiaryRecord ["cmf_toe", ["TO&E", _rosterString]]
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;