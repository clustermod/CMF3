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
 * [] call cmf_init_fnc_hearing
 *
 * Public: No
 */
SCRIPT(hearing);

_this spawn {

	/* Check if it is enabled */
	private _enabled = ( CONFIG_PARAM_3(SETTINGS,hearing,enable) ) isEqualTo 1;
	if !(_enabled) exitWith {};

	/* Code for putting in the earplugs */
	private _codein = {
		player setVariable [QGVAR(hearing_earplugsIn), true];

		/* Raise event */
		[QGVAR(hearing_onEarplugsIn), []] call CBA_fnc_localEvent;
	};

	/* Code for taking out earplugs */
	private _codeout = {
		player setVariable [QGVAR(hearing_earplugsIn), false];

		/* Raise event */
		[QGVAR(hearing_onEarplugsOut), []] call CBA_fnc_localEvent;
	};

	/* Waituntil player is alive */
	waitUntil { alive player && !isNull player };

	/* Add the ace action */
	private _actionIn = [QGVAR(hearing_insertEarplugs), "Insert earplugs", "", _codein, { "ACE_EarPlugs" in (items player) && !(player getVariable [QGVAR(hearing_earplugsIn), false]) }] call ace_interact_menu_fnc_createAction;
	private _actionOut = [QGVAR(hearing_takeOutEarplugs), "Take out earplugs", "", _codeout, { (player getVariable [QGVAR(hearing_earplugsIn), false]) }] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _actionIn] call ace_interact_menu_fnc_addActionToClass;
	[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _actionOut] call ace_interact_menu_fnc_addActionToClass;

	player addEventHandler ["Killed", _codeout];

	/* Calculate the appropriate volume */
	[{
		private _headgearSetting = (CONFIG_PARAM_3(SETTINGS,hearing,attenuateHeadgear)) isEqualTo 1;
		private _earplugVolumeSetting = CONFIG_PARAM_3(SETTINGS,hearing,earplugsVolume);
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
		if (player getVariable [QGVAR(hearing_earplugsIn), false]) then {
			private _attenuation = _earplugVolumeSetting;
			_volumeAttenuation = _volumeAttenuation * (1 - _attenuation);
		};

		private _volume = _volumeAttenuation max 0.05;

		/* Set the final calculated volume */
		0 fadeSound _volume;
		0 fadeRadio _volume;
		if (!isNil "acre_api_fnc_setGlobalVolume") then { [_volume^0.33] call acre_api_fnc_setGlobalVolume };
	}, 0, []] call CBA_fnc_addPerFrameHandler;
};
