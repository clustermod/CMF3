private _time = _this select 0;
private _text = [_this, 1, "Time Left"] call BIS_fnc_param;

[_time, _text] spawn
{
    private _time = _this select 0;
    private _text = _this select 1;

    for [{_i=_time},{_i>=0},{_i=_i-1}] do
    {
        format [_text + "\n%1", [((_i)/60)+.01,"HH:MM"] call BIS_fnc_timetostring] remoteExec ["hintSilent"];
        sleep 1;
    };
    "" remoteExec ["hintSilent"];
};
