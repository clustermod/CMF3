#include "script_component.hpp"
/*
 * Author: Eric
 * Blacklist Addons on a per user basis
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
        player setVariable [QGVAR(addonDifference), _addonDifference, true];

        /* Check if any addons are blacklisted */
        private _addonBlacklist = CONFIG_PARAM_2(SETTINGS,blacklistedAddons);
        private _illegalAddons = _clientAddons select { _x in _addonBlacklist };
        if (_clientAddons findIf { _x in _addonBlacklist } != -1) then {
            [format ["%1 has been blacklisted! Please remove it from your modset to join the server", (_illegalAddons joinString ", ")], "Blacklisted Addon", true, false] call BIS_fnc_guiMessage;
            QGVAR(blacklistedAddon) call BIS_fnc_endMission;
        };
    }] remoteExec ["spawn", _owner];
}];
