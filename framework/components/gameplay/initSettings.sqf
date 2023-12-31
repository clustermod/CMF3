#include "script_component.hpp"

[
    QGVAR(setting_flashbang),
    "CHECKBOX",
    ["Override Flashbangs", "Replace default flashbang effects"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_safestart),
    "CHECKBOX",
    ["Safestart", "Dissalow combat at start of mission"],
    QUOTE(MODULE_BEAUTIFIED - Safestart),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_safestartDelay),
    "TIME",
    ["Safestart Delay", "Delay in seconds for safestart to be disabled"],
    QUOTE(MODULE_BEAUTIFIED - Safestart),
    [0, 60, 5],
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_tracers),
    "CHECKBOX",
    ["Tracers", "Replaces AIs ammunition with tracer munitions"],
    QUOTE(MODULE_BEAUTIFIED - Tracers),
    false,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_tracersSides),
    "EDITBOX",
    ["Sides", "Sides to apply function to. sepperated by comma (,)"],
    QUOTE(MODULE_BEAUTIFIED - Tracers),
    "east, independent",
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_tracersFlashlight),
    "CHECKBOX",
    ["Flashlights", "Give AI flashlights (tracers must be enabled)"],
    QUOTE(MODULE_BEAUTIFIED - Tracers),
    false,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_tracersRandomModel),
    "CHECKBOX",
    ["Randomize Magazine Model", "Should magazine model be randomized?"],
    QUOTE(MODULE_BEAUTIFIED - Tracers),
    false,
    1
] call EFUNC(common,addSetting);

