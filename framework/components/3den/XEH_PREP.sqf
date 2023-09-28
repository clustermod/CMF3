#include "script_component.hpp"
/*
 * This XEH_PREP will also define functions from other parts of CMF (since the CMF state machine won't be called in 3den)
 */

PREP(init);

PREP(addMenuItem);
PREP(inInit);
PREP(addToInit);
PREP(removeFromInit);

PREP(main_iconViewer);
PREP(main_setConfig);
PREP(unit_constructor);
PREP(unit_spawner);

PREP(entity_acre_rack);
PREP(entity_kosherArsenal_ammobox);
PREP(entity_simplify);
PREP(entity_simulation);
PREP(entity_ace_carry);
PREP(entity_ace_drag);
PREP(entity_logistics_supplyCrates);
PREP(entity_ai_preventProne);

/* Localize function */
EFUNC(main,localize) = compile preprocessFileLineNumbers QUOTE(PATHTO_SYS(main,fn_localize));

/* version compare function */
EFUNC(utility,versionCompare) = compile preprocessFileLineNumbers QUOTE(PATHTO_SYS(utility,fn_versionCompare));

/* Add ACE settings in 3den */
[] spawn compile preprocessFileLineNumbers QUOTE(PATHTOF_SYS(main,initAceSettings.sqf));
