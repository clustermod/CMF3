/*
 * Author: Eric
 * Creates a global countdown.
 *
 * Arguments:
 * 0: Time <NUMBER>
 * 1: Text <STRING>
 * 2: Blocking <BOOL>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [60, "Finished unloading in: ", true] call EMF_fnc_countDown
 *
 * public: Yes
*/

params["_time", "_text", ["_blocking", false]];

// Check if params are set and is of correct type
if (isNil "_time") exitWith {  ['Time is not set'] call BIS_fnc_error; 'Time is not set' call BIS_fnc_log; false;};
if (typeName _time != "SCALAR") exitWith {  ['Time must be type "SCALAR", type %1 supplied', (typeName _time)] call BIS_fnc_error; ['Time must be type "SCALAR", type %1 supplied', (typeName _time)] call BIS_fnc_log; false;};

if (isNil "_text") exitWith {  ['Text is not set'] call BIS_fnc_error; 'Text is not set' call BIS_fnc_log; false;};
if (typeName _text != "STRING") exitWith {  ['Text must be type "STRING", type %1 supplied', (typeName _text)] call BIS_fnc_error; ['Text must be type "STRING", type %1 supplied', (typeName _text)] call BIS_fnc_log; false;};

private _EMF_fnc_CD_CountDown =
{
    params["_time", "_text"];

    for [{_i=_time},{_i>=0},{_i=_i-1}] do
    {
        format [_text + "\n%1", [((_i)/60)+.01,"HH:MM"] call BIS_fnc_timetostring] remoteExec ["hintSilent"];
        sleep 1;
    };
    "" remoteExec ["hintSilent"];
};


// If true will block further execution until timer is done
if (_blocking) then {
  [_time, _text] call _EMF_fnc_CD_CountDown;
} else {
  [_time, _text] spawn _EMF_fnc_CD_CountDown;
};
true;
