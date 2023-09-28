#include "script_component.hpp"
/*
 * Author: Eric
 * Shows a hint for all curators but not normal players.
 * 
 * Arguments:
 * 0: Hint <STRING>
 * 1: Silent <BOOL> [Default: false]
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["Reminder"] call cmf_utility_fnc_zeusHint
 * 
 * Public: Yes
 */
params ["_hint", ["_silent", false]];

{
	private _target = getAssignedCuratorUnit _x;

	if (_silent) then {
		[_hint] remoteExec ["hintSilent", _target, false];
	} else {
		[_hint] remoteExec ["hint", _target, false];
	};
} forEach allCurators;