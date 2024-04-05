#include "script_component.hpp"

call FUNC(cratePFH);
call FUNC(crateActions);

["ReammoBox_F", "init", {
    params ["_crate"];

    /* hide original ace rename action */
    _crate setVariable ["ace_cargo_noRename", true];
}, true, [], true] call CBA_fnc_addClassEventHandler;