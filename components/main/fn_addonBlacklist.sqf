#include "script_component.hpp"
/*
 * Author: Eric
 * Blacklist Addons
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_main_fnc_addonBlacklist
 *
 * Public: No
 */
SCRIPT(addonBlacklist);

if (!isServer) exitWith {};

/* Save server addons to a variable */
private _serverAddons = ("true" configClasses (configFile >> "CfgPatches")) apply { configname _x };
missionNamespace setVariable [QGVAR(serverAddons), _serverAddons, true];

addMissionEventHandler ["PlayerConnected", {
    private _owner = _this select 4;

    /* Verify for new players */
    [_this, {
        /* Save client addons to a variable */
        private _clientAddons = ("true" configClasses (configFile >> "CfgPatches")) apply { configname _x };
        missionNamespace setVariable [QGVAR(clientAddons), _clientAddons];

        /* Get the variable difference */
        private _serverAddons = missionNamespace getVariable [QGVAR(serverAddons), []];
        private _addonDifference = _clientAddons - _serverAddons;
        missionNamespace setVariable [QGVAR(addonDifference), _addonDifference];

        /* Check if any addons are blacklisted */
        private _addonBlacklist = CONFIG_PARAM_2(SETTINGS,blacklistedAddons);
        if (_clientAddons findIf {_x in _addonBlacklist} != -1) then {
            QGVAR(blacklistedAddon) call BIS_fnc_endMission;
        };
    }] remoteExec ["call", _owner];
}];
