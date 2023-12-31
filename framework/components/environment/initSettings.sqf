#include "script_component.hpp"

[
    QGVAR(setting_freezeTime),
    "CHECKBOX",
    ["Freeze Time", "Freezes time completly"],
    QUOTE(MODULE_BEAUTIFIED),
    false,
    1
] call EFUNC(common,addSetting);