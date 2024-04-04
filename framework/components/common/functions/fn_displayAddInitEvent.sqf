#include "script_component.hpp"
/*
 * Author: Eric
 * Attaches a display / dialog init event
 * 
 * Arguments:
 * 0: IDD <NUMBER>
 * 1: Callback <CODE>
 * 2: Arguments <ANY>
 * 
 * Return Value:
 * CBA PerFramehandler Handle <NUMBER>
 * 
 * Example:
 * [313, { hint str _this }, ["foo", "bar"]] call cmf_common_fnc_displayAddInitEvent
 * 
 * Public: Yes
 */
params ["_idd", "_callback", ["_args", []]];

private _displayInitEvent = {
    params ["_self", "_idd", "_callback", "_args"];

    [findDisplay _idd, _args] call _callback;

    [
        { isNull findDisplay (_this select 1) },
        {
            params ["_self"];

            [
                { !isNull findDisplay (_this select 1) },
                _self,
                _this
            ] call CBA_fnc_waitUntilAndExecute;
        },
        _this
    ] call CBA_fnc_waitUntilAndExecute;
};

[
    { !isNull findDisplay (_this select 1) },
    _displayInitEvent,
    [_displayInitEvent, _idd, _callback, _args]
] call CBA_fnc_waitUntilAndExecute;