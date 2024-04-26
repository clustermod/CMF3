#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a countdown.
 *
 * Arguments:
 * 0: Time <NUMBER>
 * 1: Text <STRING>
 * 2: Blocking <BOOL>
 *
 * Return Value:
 * <BOOL>
 *
 * Example:
 * [60, "Finished unloading in: ", true] call cmf_common_fnc_countDown
 *
 * public: Yes
*/
params ["_time", "_text", ["_blocking", false]];

private _fnc_CD_CountDown = {
    params["_time", "_text"];

    for "_i" from _time to 0 step -1 do {
        hintSilent (format ["%1 %2", _text, ([_i / 60 + 0.01, "HH:MM"] call BIS_fnc_timetostring)]);
        sleep 1;
    };
    hintSilent "";
};


/* If true will block further execution until timer is done */
if _blocking then {
    [_time, _text] call _fnc_CD_CountDown;
} else {
    [_time, _text] spawn _fnc_CD_CountDown;
};
