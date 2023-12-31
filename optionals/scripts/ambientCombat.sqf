#include "script_component.hpp"
/*
 * Author: Eric
 * Plays simulated combat sounds and light flashes from explosions
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call compile preprocessFileLineNumbers "rsc\scripts\ambientCombat"
 * 
 * Public: Yes
 */
if (!isServer) exitWith {};

if (isNil QGVAR(ambientCombat)) then {
    GVAR(ambientCombat) = true;
};

for '_i' from 0 to 2 do {
    _i spawn {
        private _explosions = ["BattlefieldExplosions1_3D", "BattlefieldExplosions2_3D", "BattlefieldExplosions5_3D"];
        private _fireFights = ["BattlefieldFirefight1_3D", "BattlefieldFirefight2_3D"];

        private _flashFunction = {
            private _light = "#lightpoint" createVehicle [0, 0, 0];
            _light setPos _this;
            _light setLightBrightness 0.2;
            _light setLightAttenuation [2, 4, 4.31918e-005, 0];
            _light setLightAmbient [0.95, 0.95, 0.70];
            _light setLightColor [0.95, 0.95, 0.70];

            [{
                deleteVehicle _this;
            }, _light, 0.1] call CBA_fnc_waitAndExecute;
        };

        while { GVAR(ambientCombat) } do {
            sleep (1 + random 59);
            private _sound = selectRandom [_explosions call BIS_fnc_selectRandom, _fireFights call BIS_fnc_selectRandom];

            [_sound, {
                playSound _this;
                playSound _this;
                playSound _this;
                playSound _this;
            }] remoteExec ["call", 0, false];

            if (_sound in _explosions) then {
                private _flashPos = [worldSize / 2, worldsize / 2, 0] getPos [worldsize * 1.2, random 360];
                [_flashPos, _flashFunction] remoteExec ["call", 0, false];
            };
        };
    };
};
