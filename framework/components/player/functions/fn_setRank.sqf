#include "script_component.hpp"
/*
 * Author: Eric
 * Sets the unit's rank based on their group
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_player_fnc_setRank
 *
 * Public: No
 */

if (!hasInterface) exitWith { };

[{ !isNull player }, {
    /* If player rank is different from default disregard */
    if ((rank player) != "PRIVATE") exitWith { };

    /* Get group data */
    private _groupData = [group player] call EFUNC(common,getCallsign);
    private _level = _groupData select 2;

    /* Set rank */
    if (isClass (missionConfigFile >> "CMF_ORBAT" >> "SIZES" >> _level)) then {
        private _rank = getText (missionConfigFile >> "CMF_ORBAT" >> "SIZES" >> toUpper _level >> "leadRank");
        if ((player isEqualTo leader group player)) then {
            _rank = getText (missionConfigFile >> "CMF_ORBAT" >> "SIZES" >> toUpper _level >> "leadRank");
        };

        [player, _rank] remoteExec ["setUnitRank", 0, true];
    };
}] call CBA_fnc_waitUntilAndExecute;

