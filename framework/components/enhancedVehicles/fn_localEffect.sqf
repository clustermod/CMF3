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
 * [] call cmf_enhancedVehicles_fnc_localEffect
 *
 * Public: No
 */
SCRIPT(localEffect);

_this spawn {
    private _enableSoundEffects = ( CONFIG_PARAM_3(SETTINGS,enhancedVehicles,soundEffects) ) isEqualTo 1;
    private _enableVisualEffects = ( CONFIG_PARAM_3(SETTINGS,enhancedVehicles,visualEffects) ) isEqualTo 1;

    /* Play sound effects */
    if (_enableSoundEffects) then {
        [] spawn {
            player setVariable ["defaultVolume", soundVolume];
            0 fadeSound 0.2;
            playsound "ACE_Combat_Deafness_Medium_NoRing";
            playsound "ACE_Ring_Backblast";

            sleep 15;
            private _defaultVolume = player getVariable ["defaultVolume", soundVolume];
            60 fadesound _defaultVolume;
        };
    };

    /* Show visual effects */
    if (_enableVisualEffects) then {
        addCamShake [5,2,9];
        private _visualEffect = ppEffectCreate ["RadialBlur", 10000];
        cutText ["", "BLACK OUT", 0.001];
        sleep 1;
        titleCut ["", "BLACK IN", 10];
        _visualEffect ppEffectEnable true;
        _visualEffect ppEffectAdjust[0.1,0,0,0];
        _visualEffect ppEffectCommit 2;
        sleep 2;
        _visualEffect ppEffectAdjust[0,0.1,0,0];
        _visualEffect ppEffectCommit 2;
        sleep 2;
        _visualEffect ppEffectAdjust[0.1,0,0,0];
        _visualEffect ppEffectCommit 2;
        sleep 7;
        _visualEffect ppEffectAdjust[0,0,0,0];
        _visualEffect ppEffectCommit 2;
        sleep 3;
        _visualEffect ppEffectEnable false;
        ppEffectDestroy _visualEffect;
    };
};
