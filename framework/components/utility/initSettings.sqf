#include "script_component.hpp"

[
    QGVAR(setting_clearCargo),
    "CHECKBOX",
    ["Empty Vehicle Cargo", "Clears vehicle cargo of all items"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_freezeTime),
    "CHECKBOX",
    ["Freeze Time", "Freezes time completly"],
    QUOTE(MODULE_BEAUTIFIED),
    false,
    1
] call EFUNC(common,addSetting);