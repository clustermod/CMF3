#include "script_component.hpp"
/*
 * Author: Eric
 * Restrict launchers to only be used by units who has at least one launcher defined in their loadout
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_player_fnc_restrictLauncher
 *
 * Public: No
 */
SCRIPT(restrictLauncher);

if (!hasInterface) exitWith {};

player addEventHandler ["Respawn", {
    params ["_unit"];

    /* Create function to check if user has any launchers in loadout */
    private _allowedLauncher = "
        if !("+QGVAR(setting_restrictLauncher)+") exitWith { false };

        private _ret = true;
        private _loadoutFile = player getVariable ["QEGVAR(kosherArsenal,loadout)", """"];
        private _role = player getVariable ["QEGVAR(common,role)", ""RFL""];

        if (player getVariable ["QGVAR(restrictLauncher_unitDisable)", false]) exitWith { false };
        if (missionNamespace getVariable ["QGVAR(restrictLauncher_disable)", false]) exitWith { false };
        if ((currentWeapon player != secondaryWeapon player) || currentWeapon player isEqualTo """") exitWith { false };

        private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadoutFile);

        private _permittedGear = [];
        if (isNil ""_whitelist"") then {
            _permittedGear = player getVariable [""EMF_KA_permittedGear"", 0];
        } else {
            _permittedGear = (_whitelist select 1);
        };

        {
            if (getNumber (configFile >> ""CfgWeapons"" >> _x >> ""type"") isEqualTo 4) exitWith {
                _ret = false;
            };
        } forEach (_permittedGear select 7);

        _ret;
    ";

    /* Restrict launcher if the above function is true */
    _unit addAction ["", { player sideChat LSTRING(restrictLauncher_message) }, "", 0, false, true, "DefaultAction", _allowedLauncher];
}];
