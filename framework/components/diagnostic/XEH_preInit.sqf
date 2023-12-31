#include "script_component.hpp"

/* Create log collector */
GVAR(logOut) = [];
GVAR(errorOut) = [];

/* Log Script errors */
addMissionEventHandler ["ScriptError", {
    [QGVAR(scriptError), _this] call CBA_fnc_globalEvent;
}];