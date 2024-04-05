#include "script_component.hpp"

/* Create ACRE2 Babel handler */
["unit", {
    params ["_player"];

    private _languages = _player getVariable [QGVAR(acre_langs), ["en"]];
    _languages call acre_api_fnc_babelSetSpokenLanguages;
}, true] call CBA_fnc_addPlayerEventHandler;

/* Mute ACRE when player is down */
["ace_unconscious", {
    params ["_unit", "_active"];

    if (_unit != player) exitWith { };

    if (_active) then {
        if (!isNil "acre_api_fnc_setGlobalVolume") then {
            private _acreGlobalVolume = [] call acre_api_fnc_getGlobalVolume;
            if (isNil "_acreGlobalVolume") then { _acreGlobalVolume = 1 };
            private _globalVolume = soundVolume;
            cmf_player setVariable [QGVAR(acre_globalVolume), _acreGlobalVolume];
            cmf_player setVariable [QGVAR(globalVolume), _globalVolume];
            [0] call acre_api_fnc_setGlobalVolume;
            0 fadeSound 0.1;
            0 fadeRadio 0.1;
        };
    } else {
        if (!isNil "acre_api_fnc_setGlobalVolume") then {
            private _acreGlobalVolume = player getVariable [QGVAR(acre_globalVolume), 1];
            private _globalVolume = player getVariable [QGVAR(globalVolume), 1];
            [_acreGlobalVolume] call acre_api_fnc_setGlobalVolume;
            0 fadeSound _globalVolume;
            0 fadeRadio _globalVolume;
        };
    };
}] call CBA_fnc_addEventHandler;

if (!isNil "acre_api_fnc_setCustomSignalFunc") then {
    [{
        private _coreSignal = call acre_sys_signal_fnc_getSignalCore;
        _coreSignal params ["_Px", "_maxSignal"];

        if (cmf_player getVariable ["ACE_isUnconscious", false] || missionNamespace getVariable [QGVAR(disableACRERadio), false]) then {
            _Px = 0;
        };

        [_Px, _maxSignal]
    }] call acre_api_fnc_setCustomSignalFunc;
};

/* Disable Shacktac UI groupBar */
STHud_NoSquadBarMode = true;

/* Player respawn event */
cmf_player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];

    /* Make sure player is able to use ACRE */
    cmf_player setVariable [QGVAR(overrideSound), nil];
    GVAR(disableACRERadio) = false;
    cmf_player setVariable ["acre_sys_core_isDisabled", false, true];
    cmf_player setVariable ["acre_sys_core_isDisabledRadio", false, true];
}];