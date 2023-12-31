#include "script_component.hpp"
/*
 * Author: Eric
 * Collects player stats and saves them to the player objects namespace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_aar_fnc_stats
 *
 * Public: No
 */
SCRIPT(stats);

if (!isServer) exitWith { };

addMissionEventHandler ["EntityKilled", {
    /* Track deaths */
    if (isPlayer (_this select 0)) then {
        private _deaths = (_this select 0) getVariable [QGVAR(stats_deaths), -1];
        [_this select 0, QGVAR(stats_deaths), _deaths] call CBA_fnc_setVarNet;
    };

    /* Don't count suicides as kills */
    if ((_this select 1) isEqualTo (_this select 0)) exitWith { };

    /* Track kills */
    if (isPlayer (_this select 1) && { (_this select 0) isKindOf "Man" }) then {
        if (([side (_this select 1), side group (_this select 0)] call BIS_fnc_sideIsEnemy) && { (side group (_this select 0) != civilian) }) exitWith {
            private _kills = (_this select 1) getVariable [QGVAR(stats_E_kills), 0];
            [_this select 1, QGVAR(stats_E_kills), _kills + 1] call CBA_fnc_setVarNet;
        };

        if (([side (_this select 1), side group (_this select 0)] call BIS_fnc_sideIsFriendly) && { (side group (_this select 0) != civilian) }) exitWith {
            private _kills = (_this select 1) getVariable [QGVAR(stats_F_kills), 0];
            [_this select 1, QGVAR(stats_F_kills), _kills + 1] call CBA_fnc_setVarNet;
        };

        if (side group (_this select 0) isEqualTo civilian) exitWith {
            private _kills = (_this select 1) getVariable [QGVAR(stats_C_kills), 0];
            [_this select 1, QGVAR(stats_C_kills), _kills + 1] call CBA_fnc_setVarNet;
        };
    };
}];
