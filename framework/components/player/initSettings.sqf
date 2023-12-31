#include "script_component.hpp"

[
    QGVAR(setting_switchMapTextures),
    "CHECKBOX",
    ["Switch Map Textures", "Defaults map textures to topographic"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    0
] call EFUNC(common,addSetting);

[
    QGVAR(setting_hideRespawnMarkers),
    "CHECKBOX",
    ["Hide Respawn Markers", "Hides respawn markers from the map"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_consistentMarkers),
    "CHECKBOX",
    ["Consistent Marker Size", "Forces a consistent marker size regardless of zoom"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_restrictLauncher),
    "CHECKBOX",
    ["Restrict Launcher Access", "Restricts operation of launchers to those who has a launcher defined in their slot"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_hearing),
    "CHECKBOX",
    ["Hearing", "Allows the use of items to reduce game volume"],
    QUOTE(MODULE_BEAUTIFIED - Hearing),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_attenuateHeadgear),
    "CHECKBOX",
    ["Attenuate Headgear", "Headgear volume statistics will affect game volume"],
    QUOTE(MODULE_BEAUTIFIED - Hearing),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_earplugVolume),
    "SLIDER",
    ["Earplug Volume", "The volume that will be set when earplugs are inserted"],
    QUOTE(MODULE_BEAUTIFIED - Hearing),
    [0.01, 1.00, 0.50, 0, true],
    0
] call EFUNC(common,addSetting);