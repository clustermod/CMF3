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

if isServer then { 
    addMissionEventHandler ["EntityKilled", {
        /* Track deaths */
        if (isPlayer (_this select 0)) then {
            private _deaths = (_this select 0) getVariable [QGVAR(stats_deaths), -1];
            (_this select 0) setVariable [QGVAR(stats_deaths), _deaths + 1, true];
        };

        /* Don't count suicides as kills */
        if ((_this select 1) isEqualTo (_this select 0)) exitWith { };

        /* Track kills */
        if (isPlayer (_this select 1) && (_this select 0) isKindOf "Man") then {
            switch true do {
                case ([side (_this select 1), side group (_this select 0)] call BIS_fnc_sideIsEnemy && { side group (_this select 0) != civilian }): {
                    private _kills = (_this select 1) getVariable [QGVAR(stats_E_kills), 0];
                    (_this select 1) setVariable [QGVAR(stats_E_kills), _kills + 1, true];
                };

                case ([side (_this select 1), side group (_this select 0)] call BIS_fnc_sideIsFriendly && { side group (_this select 0) != civilian }): {
                    private _kills = (_this select 1) getVariable [QGVAR(stats_F_kills), 0];
                    (_this select 1) setVariable [QGVAR(stats_F_kills), _kills + 1, true];
                };

                case (side group (_this select 0) == civilian): {
                    private _kills = (_this select 1) getVariable [QGVAR(stats_C_kills), 0];
                    (_this select 1) setVariable [QGVAR(stats_C_kills), _kills + 1, true];
                };
            };
        };
    }];
} else {
    player addEventHandler ["Fired", {
        private _shots = player getVariable [QGVAR(stats_shots_fired), 0];
        player setVariable [QGVAR(stats_shots_fired), _shots + 1, true];
    }];
};