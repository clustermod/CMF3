#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a roster of the current players. Get's executed automatically
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_gameplay_fnc_roster
 *
 * Public: No
 */

[{ !isNull player && alive player }, {
    player createDiarySubject ["cmf_roster", "Roster"];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) then {
            /* Remove outdated roster */
            {
                player removeDiaryRecord ["cmf_roster", _x select 8]
            } forEach (player allDiaryRecords "cmf_roster");
        } else {
            /* Get all player groups */
            private _allPlayerGroups = allPlayers apply { group _x };
            _allPlayerGroups = _allPlayerGroups arrayIntersect _allPlayerGroups;
            _allPlayerGroups sort true;

            private _rosterString = "<br/><font size='12'>";
            {
                private _group = _x;
                _rosterString = _rosterString + format ["<font face='PuristaBold'>%1</font><br/>", groupId _group];
                {
                    private _unit = _x;
                    _rosterString = _rosterString + format ["<font size='13'>    <font color='#fcba03'> %1</font></font><br/>", name _unit];
                } forEach units _group;
            } forEach _allPlayerGroups;

            player createDiaryRecord ["cmf_roster", ["Roster", _rosterString]]
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;