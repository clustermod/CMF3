/*
 * Author: Eric
 * Ends loadnig screen (fixes stuck in loading bug)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_aceMenu_fnc_endLoadingScreen
 *
 * Public: yes
 */
scriptName "functions\aceMenu\fn_endLoadingScreen.sqf";

for "_x" from 1 to 4 do {
	endLoadingScreen;
	sleep 3;
};
