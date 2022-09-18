#include "script_component.hpp"
/*
 * Author: Eric
 * Freezes time completly as opposed to setting skipTime 0.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * scriptHandle <HANDLE>
 *
 * Example:
 * call emf_utility_fnc_freezeTime
 *
 * Public: Yes
*/
SCRIPT(freezeTime);

/* Spawn the process so it can be terminated at a later date */
private _scriptHandle = [] spawn {
	/* Get current date and time */
	private _initdate = date;
	while {!(missionNamespace getVariable [QGVAR(freezeTime_disable), false])} do {
		setdate _initdate;
		sleep 0.5;
	};
};

/* Save the script handle to a global variable */
missionNamespace setVariable [QGVAR(freezeTime_handle), _scriptHandle];

_scriptHandle;
