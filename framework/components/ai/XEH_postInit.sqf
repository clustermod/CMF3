#include "script_component.hpp"

/* Disable Vietnamese voices from Unsung */
RUG_DSAI_TerminalDistance = -1;

/* Artillery config hash */
GVAR(artilleryHash) = [] call CBA_fnc_hashCreate;

/* Artillery Timeout */
GVAR(artilleryTimeOut) = [] call CBA_fnc_hashCreate;

/* Artillery Targets */
GVAR(artilleryTargets) = [];

call FUNC(preventProne);
call FUNC(reinforce);
call FUNC(artillery);
call FUNC(setSkill);
call FUNC(fireEH);
call FUNC(silenceAI);
call FUNC(panic);