#include "script_component.hpp"
/*
 * Author: Eric
 * Enables ACE hearing without ringing or deafness
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_player_fnc_hearing
 *
 * Public: No
 */
SCRIPT(hearing);

/* Check if it is enabled */
if !(GVAR(setting_hearing)) exitWith {};

/* Code for putting in the earplugs */
GVAR(hearing_fnc_codein) = {
    cmf_player setVariable [QGVAR(hearing_earplugsIn), true];

    /* Raise event */
    [QGVAR(hearing_onEarplugsIn), []] call CBA_fnc_localEvent;
};

/* Code for taking out earplugs */
GVAR(hearing_fnc_codeout) = {
    cmf_player setVariable [QGVAR(hearing_earplugsIn), false];

    /* Raise event */
    [QGVAR(hearing_onEarplugsOut), []] call CBA_fnc_localEvent;
};

private _actionIn = [QGVAR(hearing_insertEarplugs), "Insert earplugs", "", GVAR(hearing_fnc_codein), 
    { "ACE_EarPlugs" in (items cmf_player) && { !(cmf_player getVariable [QGVAR(hearing_earplugsIn), false]) } }] call ace_interact_menu_fnc_createAction;

private _actionOut = [QGVAR(hearing_takeOutEarplugs), "Take out earplugs", "", GVAR(hearing_fnc_codeout), 
    { (cmf_player getVariable [QGVAR(hearing_earplugsIn), false]) }] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _actionIn, true] call ace_interact_menu_fnc_addActionToClass;
["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _actionOut, true] call ace_interact_menu_fnc_addActionToClass;

player addEventHandler ["Killed", GVAR(hearing_fnc_codeout)];

/* Calculate the appropriate volume */
[{
    private _volumeAttenuation = 1;

    /* If player dies reset volume */
    if (!alive player) exitWith {
        0 fadeSound 1;
        0 fadeRadio 1;
    };

    /* Get the hearing protection value from headgear */
    if (headgear player != "" && { GVAR(setting_attenuateHeadgear) }) then {
        private _attenuation = getNumber (configFile >> "CfgWeapons" >> headgear player >> "ace_hearing_lowerVolume") min 1;
        _volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
    };

    /* Get the hearing protection value from goggles */
    if (goggles player != "" && { GVAR(setting_attenuateHeadgear) }) then {
        private _attenuation = getNumber (configFile >> "CfgGlasses" >> goggles player >> "ace_hearing_lowerVolume") min 1;
        _volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
    };

    /* Check if earplugs are in */
    if (player getVariable [QGVAR(hearing_earplugsIn), false]) then {
        private _attenuation = GVAR(setting_earplugVolume);
        _volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
    };

    _volumeAttenuation = missionNamespace getVariable [QGVAR(overrideSound), _volumeAttenuation];

    private _volume = _volumeAttenuation max 0.05;

    /* Set the final calculated volume */
    0 fadeSound _volume;
    0 fadeRadio _volume;
}, 0, []] call CBA_fnc_addPerFrameHandler;
