#include "script_component.hpp";

params["_unitID", "_unit", ["_captureFiring", true]];
private _timeStart = time;
private _timeCur = 0;
private _capturedData = [];
private _inputFPS = 10;

systemChat "[EMF] [afteraction] Started Capture";

// Capture firing data (replace with custom version)
if (_captureFiring) then {
    [_unitID, _unit] spawn {
        params["_unitID", "_unit"];
        private _timeStart = time;
        private _timeCur = time - _timeStart;

        GVAR(EndCapture) = false;
        _unit setVariable [QGVAR(Capture_Fired), false];
        _unit setVariable [QGVAR(Capture_FiredClass), ""];
        private _unitTarget = objNull;
        private _capturedFireData = [];
        private _frameTime = 0;

        _unit addEventHandler ["Fired", {_unit setVariable [QGVAR(Capture_Fired), true]; _unit setVariable [QGVAR(Capture_FiredClass), (_this select 1)];}];
        _unit addEventHandler ["Killed", {(_this select 0) enablesimulation false;}];
        {_x addEventHandler ["HandleDamage", {0}];} forEach (crew _unit);

        while { ((alive _unit) && !(GVAR(EndCapture))) } do {
            if (_unit getVariable [QGVAR(Capture_Fired), false]) then {
                _unit setVariable [QGVAR(Capture_Fired), false];
                _unitTarget = assignedTarget _unit;
                _timeCur = time - _timeStart;

                if (str _unitTarget != "<NULL-object>") then {
                    _capturedFireData = _capturedFireData + [[_timeCur, _unit getVariable [QGVAR(Capture_FiredClass), ""], _unitTarget]];
                } else {
                    _capturedFireData = _capturedFireData + [[_timeCur, _unit getVariable [QGVAR(Capture_FiredClass), ""]]];
                };
            };
            _frameTime = time;
            waitUntil {_frameTime < time};
        };
        (GVAR(allCaptureData) select _unitID) set [5, _capturedFireData];
    };
};

private _sleepTime = 1 / _inputFPS;

// Tracker variables
GVAR(EndCapture) = false;

private _FPS = 0;
private _sleepDeficit = 0;
private _sleepDeficitCheckLast = time;

// Capture fired event
_unit addEventHandler ["Killed", {(_this select 0) enablesimulation false;}];
{_x addEventHandler ["HandleDamage", {0}];} forEach (crew _unit);

while { ((alive _unit) && !(GVAR(EndCapture))) } do {
    if (_FPS > 0) then {
        _sleepDeficit = (time - _sleepDeficitCheckLast) - (_sleepTime);        //<_sleepDeficit == <time from last check> - _sleepTime
        _sleepDeficitCheckLast = time;
        if (_sleepDeficit < 0) then {
            _sleepDeficit = 0;        //< difference between _sleepTime (based on hardcoded FPS) and time from last run.
        }
    };

    _timeCur = time - _timeStart;    //< Time from the begining of this script (start of the script is 0)

    _capturedData = _capturedData + [[_timeCur, (getPosASL _unit), vectorDir _unit, vectorUp _unit, velocity _unit]]; //This line is saving captured data to some string variable
    sleep (_sleepTime - _sleepDeficit);    //< This sleep is trying to sleep script until next frame apears (WRONG!! Cannot be calculated based on hardcoded FPS value)

    _FPS = _FPS + 1;        //< Just counter how many frames was captured
};
(GVAR(allCaptureData) select _unitID) set [4, _capturedData];
