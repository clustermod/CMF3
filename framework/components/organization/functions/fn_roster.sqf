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
 * call cmf_gameplay_fnc_roster
 *
 * Public: No
 */

[{ !isNull player && { alive player } }, {
    player createDiarySubject ["cmf_roster", "Player Roster"];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) exitWith {
            { player removeDiaryRecord ["cmf_roster", _x select 8] } forEach (player allDiaryRecords "cmf_roster");
        };

        private _formattedString = "<font size='12'><br/><br/><font face='PuristaBold'>Player Roster</font><br/>";

        {
            if (isPlayer _x) then {
                private _roleDescription = "None";
                if (roleDescription _x != "") then {
                    _roleDescription = (roleDescription _x splitString "@") select 0;
                };

                _formattedString = _formattedString + format ["    <font color='#fcba03'> %1</font>, %2<br/>", name _x, _roleDescription];
            };
        } forEach allPlayers;


        cmf_player createDiaryRecord ["cmf_roster", ["Player Roster", _formattedString]];
    }];
}] call CBA_fnc_waitUntilAndExecute;