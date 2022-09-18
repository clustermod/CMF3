#include "script_component.hpp"
/*
 * Author: Eric
 * Enables ACE earplugs without ringing or deafness
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_earplugs
 *
 * Public: No
 */
SCRIPT(earplugs);

/* Check if it is enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,hearing) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* Code for putting in the earplugs */
private _codein = {
	player setVariable [QGVAR(earplug_in), true];
};

/* Code for taking out earplugs */
private _codeout = {
	player setVariable [QGVAR(earplug_in), false];
};

/* Add the ace action */
private _actionIn = ["emf_earplug_in", "Insert earplugs", "", _codein, { "ACE_EarPlugs" in (items player) && !(player getVariable [QGVAR(earplug_in), false]) }] call ace_interact_menu_fnc_createAction;
private _actionOut = ["emf_earplug_in", "Take out earplugs", "", _codeout, { (player getVariable [QGVAR(earplug_in), false]) }] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _actionIn] call ace_interact_menu_fnc_addActionToClass;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _actionOut] call ace_interact_menu_fnc_addActionToClass;

player addEventHandler ["Killed", _codeout];

/* Calculate the appropriate volume */
[{
    private _headgearSetting = (CONFIG_PARAM_3(SETTINGS,init,attenuateHeadgear)) isEqualTo 1;
    private _earplugVolumeSetting = CONFIG_PARAM_3(SETTINGS,init,earplugsVolume);
	private _volumeAttenuation = 1;

    /* If player dies reset volume */
	if (!alive player) exitWith {
		0 fadeSound 1;
		0 fadeRadio 1;
		if (!isNil "acre_api_fnc_setGlobalVolume") then { [1^0.33] call acre_api_fnc_setGlobalVolume };
	};

	/* Get the hearing protection value from headgear */
	if (headgear player != "" && _headgearSetting) then {
		private _attenuation = getNumber (configFile >> "CfgWeapons" >> headgear player >> "ace_hearing_lowerVolume") min 1;
		_volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
	};

	/* Get the hearing protection value from goggles */
	if (goggles player != "" && _headgearSetting) then {
		private _attenuation = getNumber (configFile >> "CfgGlasses" >> goggles player >> "ace_hearing_lowerVolume") min 1;
		_volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
	};

    /* Check if earplugs are in */
	if (player getVariable [QGVAR(earplug_in), false]) then {
		private _attenuation = _earplugVolumeSetting;
		_volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
	};

	private _volume = _volumeAttenuation max 0.05;

	/* Set the final calculated volume */
	0 fadeSound _volume;
	0 fadeRadio _volume;
	if (!isNil "acre_api_fnc_setGlobalVolume") then { [_volume^0.33] call acre_api_fnc_setGlobalVolume };
}, 0, []] call CBA_fnc_addPerFrameHandler;
