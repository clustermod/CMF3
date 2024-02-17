#include "script_component.hpp"

call FUNC(cratePFH);
call FUNC(crateActions); // Temporarily disabled as it breaks the ace actions on the crate

["ReammoBox_F", "init", {
    params ["_crate"];

    /* hide original ace rename action */
    _crate setVariable ["ace_cargo_noRename", true];
}, true, [], true] call CBA_fnc_addClassEventHandler;