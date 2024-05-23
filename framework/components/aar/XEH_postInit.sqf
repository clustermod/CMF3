#include "script_component.hpp"

call FUNC(stats);
call FUNC(endMission);

/* curator displayInit */
["ace_spectator_displayLoaded", FUNC(initDisplaySpectator)] call CBA_fnc_addEventHandler;