#include "script_component.hpp"

[
    QSETTING(freezeTime),
    "CHECKBOX",
    ["Freeze Time", "Freezes time completly"],
    QUOTE(MODULE_BEAUTIFIED),
    false,
    1
] call EFUNC(common,addSetting);