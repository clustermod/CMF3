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
 * [] call emf_init_fnc_setSkill
 *
 * public: Yes
*/
scriptName "functions\init\fn_setSkill.sqf";

// Get config setting
private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,forceSkill) ) isEqualTo 1;
if !(_enabled) exitWith {};

// Set skill on all eden spawned AI
{
    if (!isPlayer _x) then {
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
    }
} forEach allUnits;
