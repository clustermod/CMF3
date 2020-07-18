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
 * None
 *
 * Example:
 * [60, "Finished unloading in: ", true] call EMF_fnc_countDown
 *
 * public: Yes
*/

params["_time", "_text", ["_blocking", false]];

// Check if params are set and is of correct type
if (isNil "_time") exitWith {  ['Time is not set'] call BIS_fnc_error; 'Time is not set' call BIS_fnc_log;};
if (typeName _time != "SCALAR") exitWith {  ['Time must be type "SCALAR", type %1 supplied', (typeName _time)] call BIS_fnc_error; ['Time must be type "SCALAR", type %1 supplied', (typeName _time)] call BIS_fnc_log;};

if (isNil "_text") exitWith {  ['Text is not set'] call BIS_fnc_error; 'Text is not set' call BIS_fnc_log;};
if (typeName _text != "STRING") exitWith {  ['Text must be type "STRING", type %1 supplied', (typeName _text)] call BIS_fnc_error; ['Text must be type "STRING", type %1 supplied', (typeName _text)] call BIS_fnc_log;};

[_time, _text] spawn
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
    uisleep _time + 5;
};
