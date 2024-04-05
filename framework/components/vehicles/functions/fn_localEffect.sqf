#include "script_component.hpp"
/*
 * Author: Eric
 * Handles local effects for crew in ehv enabled vehicles
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_vehicles_fnc_localEffect
 *
 * Public: No
 */
SCRIPT(localEffect);

// @TODO: Change hearing here

/* Play sound effects */
if (SETTING(audiable)) then {
        cmf_player setVariable ["defaultVolume", soundVolume];
        0 fadeSound 0.2;
        playsound "ACE_Combat_Deafness_Medium_NoRing";
        playsound "ACE_Ring_Backblast";

        [{
            private _defaultVolume = player getVariable ["defaultVolume", soundVolume];
            60 fadesound _defaultVolume;
        }, 0, 15] call CBA_fnc_waitAndExecute;
};

/* Show visual effects */
if (SETTING(visual)) then {
    addCamShake [5,2,9];
    private _visualEffect = ppEffectCreate ["RadialBlur", 10000];
    cutText ["", "BLACK OUT", 0.001];

    [{
        titleCut ["", "BLACK IN", 10];
        _this ppEffectEnable true;
        _this ppEffectAdjust[0.1,0,0,0];
        _this ppEffectCommit 2;
    }, _visualEffect, 1] call CBA_fnc_waitAndExecute;

    [{
        _this ppEffectAdjust[0,0.1,0,0];
        _this ppEffectCommit 2;
    }, _visualEffect, 3] call CBA_fnc_waitAndExecute;

    [{
        _this ppEffectAdjust[0.1,0,0,0];
        _this ppEffectCommit 2;
    }, _visualEffect, 5] call CBA_fnc_waitAndExecute;

    [{
        _this ppEffectAdjust[0,0,0,0];
        _this ppEffectCommit 2;
    }, _visualEffect, 12] call CBA_fnc_waitAndExecute;

    [{
    _this ppEffectEnable false;
    ppEffectDestroy _this;
    }, _visualEffect, 15] call CBA_fnc_waitAndExecute;
};
