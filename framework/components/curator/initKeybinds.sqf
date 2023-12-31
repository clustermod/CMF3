#include "script_component.hpp"

[
    QUOTE(FRAMEWORK: MODULE_BEAUTIFIED),
    QGVAR(toggleInfoShow),
    ["Toggle CMF Info", "Toggles visibility of player info, rallypoints and FPS and spectators view"],
    { [QGVAR(toggleZeusInfo)] call CBA_fnc_localEvent },
    "", 
    [DIK_RCONTROL, [false, false, false]], 
    false
] call EFUNC(common,addKeybind);