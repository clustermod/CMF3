params["_time", "_text", ["_blocking", false]];

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

if (_blocking) then {
    uisleep _time+3;
};
