/*
 * Author: Eric
 * Ends a players loading screen.
 *
 * Arguments:
 * 0: player/id <OBJECT>/<NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call emf_utilities_fnc_endLoadingScreen
 *
 * Public: Yes
 */
scriptName "functions\utilities\fn_endLoadingScreen.sqf";

[] spawn {
  for "_x" from 1 to 4 do {
    endLoadingScreen;
    sleep 3;
  };
};
