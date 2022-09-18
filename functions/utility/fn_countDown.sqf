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
 * [60, "Finished unloading in: ", true] call emf_utility_fnc_countDown
 *
 * public: Yes
*/
SCRIPT(countdown);
params["_time", "_text", ["_blocking", false]];

if (!isServer) exitWith {};

private _EMF_fnc_CD_CountDown = {
    params["_time", "_text", "_i"];

    for [{ _i=_time }, { _i >= 0 }, { _i = _i - 1 }] do {
        format [_text + "\n%1", [((_i) / 60) + 0.01, "HH:MM"] call BIS_fnc_timetostring] remoteExec ["hintSilent"];
        sleep 1;
    };
    "" remoteExec ["hintSilent"];
};


/* If true will block further execution until timer is done */
if (_blocking) then {
    [_time, _text] call _EMF_fnc_CD_CountDown;
} else {
    [_time, _text] spawn _EMF_fnc_CD_CountDown;
};
