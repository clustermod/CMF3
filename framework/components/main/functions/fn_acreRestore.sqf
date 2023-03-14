#include "script_component.hpp"
/*
 * Author: MildlyInterested, Eric
 * This will restore unit's radio config on respawn. It gets called from fn_playerInit automatically.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_main_fnc_acreRestore
 *
 * Public: No
 */
params ["_newUnit", "_oldUnit"];

private _oldPTT = [] call acre_api_fnc_getMultiPushToTalkAssignment;
private _oldRadios = ([_oldUnit] call acre_sys_core_fnc_getGear) select { ([_x] call acre_api_fnc_getBaseRadio) != "" };
private _newRadios = ([_newUnit] call acre_sys_core_fnc_getGear) select { ([_x] call acre_api_fnc_getBaseRadio) != "" };

/* If old unit had no radios exit this script */
if (count _oldRadios isEqualTo 0) exitWith { };

/* Get radio config for old radios */
{
	private _radio = _x;
	private _index = _forEachIndex;

	private _baseClass = [_radio] call acre_api_fnc_getBaseRadio;
	private _channel = [_radio] call acre_api_fnc_getRadioChannel;
	private _volume = [_radio] call acre_api_fnc_getRadioVolume;
	private _spatial = [_radio] call acre_api_fnc_getRadioSpatial;
	private _ptt = _oldPTT find _radio;

	/* Set config on new radios */
	private _newRadio = _newRadios select { [_x, _baseClass] call acre_api_fnc_isKindOf } select 0;
	[_newRadio, _channel] call acre_api_fnc_setRadioChannel;
	[_newRadio, _volume] call acre_api_fnc_setRadioVolume;
	[_newRadio, _spatial] call acre_api_fnc_setRadioSpatial;

	if (_ptt != -1) then {
	    private _newPTT = [] call acre_api_fnc_getMultiPushToTalkAssignment;
		_newPTT set [_ptt, _newRadio];
		[_newPTT] call acre_api_fnc_setMultiPushToTalkAssignment;
	};

	/* Remove radio from array to avoid duplicates */
	_newRadios deleteAt (_arr find _newRadio);

} forEach _oldRadios;
