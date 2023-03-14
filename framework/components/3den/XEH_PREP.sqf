#include "script_component.hpp"
/*
 * This XEH_PREP will also define functions from other parts of CMF (since the CMF state machine won't be called in 3den)
 */

IPREP(init);
PREP(addRadioRack);
PREP(assignAmmobox);
PREP(iconViewer);
PREP(addMenuItem);
PREP(setConfig);
PREP(unitConstructor);
PREP(unitSpawner);
PREP(simplifySelectedObject);

/* Localize function */
EFUNC(main,localize) = compile preprocessFileLineNumbers QUOTE(PATHTO_SYS(main,fn_localize));

/* version compare function */
EFUNC(utility,versionCompare) = compile preprocessFileLineNumbers QUOTE(PATHTO_SYS(utility,fn_versionCompare));

/* Add ACE settings in 3den */
0 = [] spawn compile preprocessFileLineNumbers QUOTE(PATHTOF_SYS(main,initAceSettings.sqf));
