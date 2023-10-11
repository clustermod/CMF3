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

/* Set skill on all units */
["CAManBase", "init", {
    params ["_unit"];

    if (!GVAR(setting_skill)) exitWith {};

    _unit setSkill ["aimingAccuracy",   0.3 ];
    _unit setSkill ["aimingShake",      0.5 ];
    _unit setSkill ["aimingSpeed",      0.3 ];
    _unit setSkill ["spotDistance",     0.5 ];
    _unit setSkill ["spotTime",         0.5 ];
    _unit setSkill ["courage",          0.5 ];
    _unit setSkill ["commanding",       0.5 ];
    _unit setSkill ["general",          0.4 ];
    _unit setSkill ["reloadSpeed",      0.5 ];
    _unit setSkill ["endurance",        0.5 ];
}, true, [], true] call CBA_fnc_addClassEventHandler;