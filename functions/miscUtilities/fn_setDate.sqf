/*
 * Author: Eric
 * Freezes time completly as opposed to setting skipTime 0.
 *
 *Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call EMF_fnc_setDate
 *
 * Public: Yes
*/

[] spawn {
	// Get current date and time
	private _initdate = date;
	while {true} do
	{
		setdate _initdate;
		sleep 0.5;
	};
};
