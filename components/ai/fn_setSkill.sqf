#include "script_component.hpp"
/*
 * Author: Eric
 * sets AI Skill to be more balanced. Launched postInit, do not call this!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_ai_fnc_setSkill
 *
 * public: Yes
*/
SCRIPT(setSkill);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,ai,forceSkill) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* Set skill on all units */
_this spawn {
    while { !(missionNamespace getVariable [QGVAR(setSkill_disable), false]) } do {
        {
            if (!isPlayer _x && !(_x getVariable [QGVAR(setSkill_initialized), false])) then {
                _x setSkill ["aimingAccuracy", 	0.3 ];
                _x setSkill ["aimingShake", 	0.5 ];
                _x setSkill ["aimingSpeed", 	0.3 ];
                _x setSkill ["spotDistance", 	0.5 ];
                _x setSkill ["spotTime", 	    0.5 ];
                _x setSkill ["courage", 	    0.5 ];
                _x setSkill ["commanding", 	    0.5 ];
                _x setSkill ["general", 	    0.4 ];
                _x setSkill ["reloadSpeed", 	0.5 ];
                _x setSkill ["endurance", 	    0.5 ];

                _x setVariable [QGVAR(setSkill_initialized), true, true];
            }
        } forEach allUnits;

        sleep 1;
    };
};
