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
 * call emf_utilities_fnc_setDate
 *
 * Public: Yes
*/
scriptName "functions\utilities\fn_setDate.sqf";
private["_scriptHandle"];

_scriptHandle = [] spawn {
	// Get current date and time
	private _initdate = date;
	while {true} do
	{
		setdate _initdate;
		sleep 0.5;
	};
};

missionNamespace setVariable ["emf_utilities_setDate_handle", _scriptHandle];

_scriptHandle;
