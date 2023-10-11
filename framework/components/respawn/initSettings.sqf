#include "script_component.hpp"

[
    QGVAR(setting_unconciousTimer),
    "TIME",
    ["Unconcious Timer", "How long before respawning is possible"],
    QUOTE(MODULE_BEAUTIFIED),
    [0, 3600, 300],
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_rallypointCooldown),
    "TIME",
    ["Cooldown", "Delay between placing rallypoints"],
    QUOTE(MODULE_BEAUTIFIED - Rallypoints),
    [0, 3600, 300],
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_rallypointKillRadius),
    "SLIDER",
    ["Enemy Kill Radius", "Radius from rallypoint an enemy has to be for the rallypoint to dissapear"],
    QUOTE(MODULE_BEAUTIFIED - Rallypoints),
    [0, 100, 10, 0, false],
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_rallypointObject),
    "EDITBOX",
    ["Rallypoint Object Class", "Classname of rallypoint object"],
    QUOTE(MODULE_BEAUTIFIED - Rallypoints),
    "Misc_backpackheap_EP1",
    1
] call EFUNC(common,addSetting);