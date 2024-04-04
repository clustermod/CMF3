#include "script_component.hpp"

[
    QSETTING(switchMapTextures),
    "CHECKBOX",
    ["Switch Map Textures", "Defaults map textures to topographic"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    0
] call EFUNC(common,addSetting);

[
    QSETTING(hideRespawnMarkers),
    "CHECKBOX",
    ["Hide Respawn Markers", "Hides respawn markers from the map"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QSETTING(consistentMarkers),
    "CHECKBOX",
    ["Consistent Marker Size", "Forces a consistent marker size regardless of zoom"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);