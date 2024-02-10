#include "script_component.hpp"
/*
 * Author: Eric
 * Replaces AI's ammunition with tracer rounds.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_gameplay_fnc_tracers
 *
 * Public: No
 */
SCRIPT(tracers);

if (!isServer) exitWith {};

FUNC(addTracers) = {
    params ["_unit"];

    private _primaryWeapon = primaryWeapon _unit;
    private _supportedMags = [_primaryWeapon] call CBA_fnc_compatibleMagazines;

    private _tracerMags = [];
    {
        if ((getNumber (configfile >> "CfgMagazines" >> _x >> "tracersEvery")) > 0) then {
            _tracerMags pushBack _x;
        };
    } forEach _supportedMags;

    if (count _tracerMags > 0) then {
        private _newMagazine = [];
        if (GVAR(setting_tracersRandomModel)) then {
            _newMagazine pushBack (_tracerMags select (random (count _tracerMags)));
        } else {
            {
                private _curMag = getText (configfile >> "CfgMagazines" >> _x >> "model");
                private _curprimaryMag = getText (configfile >> "CfgMagazines" >> ((primaryWeaponMagazine _unit) select 0) >> "model");
                if (isNil "_curprimaryMag") then {
                    _curprimaryMag = "";
                };

                if (_curMag isEqualTo _curprimaryMag) then {
                    _newMagazine pushBack _x;
                };
            } forEach _tracerMags;

            if ((count _newMagazine) isEqualTo 0) then
            {
                _newMagazine pushBack (_tracerMags select 0);
            };
        };
        _newMagazine = _newMagazine select 0;

        private _magReplace = [];
        private _magCount = 1;
        {
            if (_x in _supportedMags) then {
                _magReplace = _magReplace + [_x];
                _magCount = _magCount + 1;
            };
        } forEach magazines _unit;

        if (!isNil "_newMagazine") then {
            _unit addMagazines [_newMagazine, 1];
            _unit reload [primaryWeapon _unit, _newMagazine];
            {
                [_unit, _x] call CBA_fnc_removeMagazine;
            } forEach _magReplace;

            _unit addMagazines [_newMagazine, _magCount];
        };

        LOG_1("Added tracers for %1", _unit);
        _unit setVariable [QGVAR(tracers_initialized), true, true];
    };

    if (SETTING(tracersFlashlight)) then {
        private _flashLights = [];
        private _compatMods = [_primaryWeapon] call CBA_fnc_compatibleItems;
        {
            if (isClass(configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight")) then {
                if (getNumber(configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight" >> "intensity") != 0) then {
                    _flashLights pushBack _x;
                };
            };
        } forEach _compatMods;
        if (count _flashLights > 0) then {
            _unit addPrimaryWeaponItem (_flashLights select (random (count _flashLights)));
            _unit enableGunLights "ForceOn";
        };

        LOG_1("Added flashlight for: %1", _unit);
    };
};

if (!isServer) exitWith { };
["CAManBase", "init", {
    params ["_unit"];

    if (!SETTING(tracers) || isPlayer _unit) exitWith { };

    [{
        private _sides = call compile format ["[%1]", SETTING(tracersSides)];

        if (side _this in _sides) then {
            [_this] call FUNC(addTracers);
        };
    }, _unit, 0.4] call CBA_fnc_waitAndExecute;
}, true, [], true] call CBA_fnc_addClassEventHandler;