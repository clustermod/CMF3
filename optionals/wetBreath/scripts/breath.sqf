#include "script_component.hpp"
/*
 * Author: Eric
 * Creates breath condensation
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call compile preprocessFileLineNumbers "rsc\scripts\breath.sqf"
 * 
 * Public: Yes
 */

my_breath_func = {
    {
        private _unit = _x;
        if (alive _unit) then {
            private _nextTime = _unit getVariable [QGVAR(myNextBreathTime), -1];
            if (_nextTime isEqualTo -1) then {
                _unit setVariable [QGVAR(myNextBreathTime), diag_tickTime + (1 + random 3)];

                private _source = "logic" createVehicleLocal (getpos _unit);
                _unit setVariable [QGVAR(myBreathingParticleLogic), _source];
                if (_unit isEqualTo cmf_player) then {
                    _source attachto [_unit, [0, 0.1, 0.04], "neck"];
                } else {
                    _source attachto [_unit, [0, 0.05, -0.08], "pilot"];
                };

                _unit setVariable [QGVAR(myBreathingParticleSource), nil];
            };

            _myParticleSource = _unit getVariable [QGVAR(myBreathingParticleSource), nil];
            if (diag_tickTime >= _nextTime || (([_unit] call acre_api_fnc_isSpeaking) && { isNil "_myParticleSource" })) then {
                if (isNil "_myParticleSource") then {
                    _unit setVariable [QGVAR(myNextBreathTime), diag_tickTime + 0.5];

                    private _mylogic = _unit getVariable QGVAR(myBreathingParticleLogic);
                    private _fog = "#particlesource" createVehicleLocal (getpos _mylogic);
                    _fog setParticleParams [
                        ["\Ca\Data\ParticleEffects\Universal\Universal", 16, 12, 13,0],
                        "", 
                        "Billboard", 
                        0.5, 
                        0.5, 
                        [0, 0, 0],
                        [0, 0.0, -0.3], 
                        1, 1.275, 1, 0.2, 
                        [0, 0.2, 0], 
                        [[1, 1, 1, (0.01 + random 0.03)], [1, 1, 1, 0.01], [1, 1, 1, 0]], //Change  (.01+random(.03)) for different effect 0 (less) 1 (more)
                        [1000], 
                        1, 
                        0.04, 
                        "", 
                        "", 
                        _mylogic
                    ];
                    _fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
                    _fog setDropInterval (0.01 - random 0.005); //change drop interval for particle density 0.001 (most dense) -> .999 (least dense)

                    _unit setVariable [QGVAR(myBreathingParticleSource), _fog];
                } else {
                    if (!([_unit] call acre_api_fnc_isSpeaking)) then {
                        _unit setVariable [QGVAR(myNextBreathTime), diag_tickTime + (2 + random 3)];
                        deletevehicle (_unit getVariable QGVAR(myBreathingParticleSource));
                        _unit setVariable [QGVAR(myBreathingParticleSource), nil];
                    };
                };
            };
        } else {
                _unit setVariable [QGVAR(myNextBreathTime), -1]; 
                deletevehicle (_unit getVariable QGVAR(myBreathingParticleLogic));
                deletevehicle (_unit getVariable QGVAR(myBreathingParticleSource));
            };
    } forEach (allUnits select { (_x distance player) < 100 });
};

[my_breath_func, 0.1] call CBA_fnc_addPerFrameHandler;