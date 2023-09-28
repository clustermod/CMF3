#include "script_component.hpp"
/*
 * Author: Eric
 * Sets AI Skill to be more balanced.
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
// @TODO replace spawn

["CAManBase", "init", {
    params ["_unit"];

    if (missionNamespace getVariable [QGVAR(setSkill_disable), false]) exitWith {};

    _unit setSkill ["aimingAccuracy", 	0.3 ];
    _unit setSkill ["aimingShake", 	    0.5 ];
    _unit setSkill ["aimingSpeed", 	    0.3 ];
    _unit setSkill ["spotDistance", 	0.5 ];
    _unit setSkill ["spotTime", 	    0.5 ];
    _unit setSkill ["courage", 	        0.5 ];
    _unit setSkill ["commanding", 	    0.5 ];
    _unit setSkill ["general", 	        0.4 ];
    _unit setSkill ["reloadSpeed", 	    0.5 ];
    _unit setSkill ["endurance", 	    0.5 ];
}, true, [], true] call CBA_fnc_addClassEventHandler;