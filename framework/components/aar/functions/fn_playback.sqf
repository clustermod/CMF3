#include "script_component.hpp"
/*
 * Author: Eric
 * Plays back recorded AAR data
 *
 * Arguments:
 * 0: Data (Optional, Default: cmf_aar_AAR_data) <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_aarData] call cmf_aar_fnc_playback
 *
 * Public: Yes
 */
SCRIPT(playback);

_this spawn {
    params ["_data"];

    /* Get AAR data */
    if (isNil "_data") then {
        _data = profileNamespace getVariable [QGVAR(AAR_data), ["Failed", "Failed", 0, [], []]]
    };

    /* Get objects data */
    private _objects = _data select 3;

    /* Get markers data */
    private _markers = _data select 4;

    /* Get length of recording */
    private _timeSpan = [0, ((_objects select count _objects - 1) select 0) - (_data select 2)];

    /* Loop through data */
    while { true } do {
        private _curTime = missionNameSpace getVariable [QGVAR(playBack_curTime), 0];

        waitUntil { _curTime != missionNameSpace getVariable [QGVAR(playBack_curTime), 0] };
    };

    /* Create time controls */
    [] spawn {
        while { true } do {
            private _oldCurTime = missionNameSpace getVariable [QGVAR(playBack_curTime), 0];
            GVAR(playBack_curTime) = (_oldCurTime + 1);
            publicVariable QGVAR(playBack_curTime);
            sleep 1;
        };
    };
}
