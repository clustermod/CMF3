#include "script_component.hpp"
/*
 * Author: Eric
 * Shows a changelog if there is a new version of CMF since last time
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_main_fnc_changelog
 *
 * Public: No
 */

addMissionEventHandler ["Map", {
    params ["_mapIsOpened", "_mapIsForced"];

    private _lastVersion = profileNamespace getVariable [QGVAR(changelog_lastVersion), "0.0.0.0"];
    private _disabled = profileNamespace getVariable [QGVAR(changelog_off), false];
    private _curVersion = GVAR(version);

        /* Show warning if server version is older than the latest CMF version */
    if ([_lastVersion, _curVersion] call EFUNC(utility,versionCompare) isEqualTo -1) then {
        [format ["Version Mismatch! (Machine: %1 (%4) version: %3, serverVersion: %2)", player, _curVersion, _lastVersion, name player], "CMF", [CBA_display_ingame_warnings, true, true]] call CBA_fnc_debug;
    };

    if !(([_lastVersion, _curVersion] call EFUNC(utility,versionCompare)) isEqualTo 1 && _disabled isEqualTo 0) exitWith {};

    if (_mapIsOpened && !isNull ((findDisplay 12) displayCtrl 88800)) then {
        private _display = (findDisplay 12) createDisplay QGVAR(changelogDisplay);

        waitUntil {!isNull _display};
        private _changelog = call compile preprocessFileLineNumbers "components\main\changelog.sqf";
        _changelogLines = _changelog splitString toString [13,10];
        _changelog = _changelogLines joinString "<br/>";

        (_display displayCtrl 100) ctrlSetStructuredText parseText _changelog;
        private _height = (count _changelogLines) * 0.038;

        (_display displayCtrl 100) ctrlSetPositionH _height;
        (_display displayCtrl 100) ctrlCommit 0;
    };

    profileNamespace setVariable [QGVAR(changelog_lastVersion), _curVersion];
    removeMissionEventHandler ["Map", _thisEventHandler];
}];
