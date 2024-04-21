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
PREP(unitConstructor);

PREP(missionDataSet);
PREP(missionDataGet);