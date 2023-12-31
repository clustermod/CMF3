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
    QGVAR(setting_enable),
    "CHECKBOX",
    ["Enable", "Enables an enhanced damage model"],
    QUOTE(MODULE_BEAUTIFIED - Enhanced Damage Model),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_visual),
    "CHECKBOX",
    ["Visual Effects", "Show visual effects on vehicle disable"],
    QUOTE(MODULE_BEAUTIFIED - Enhanced Damage Model),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_audiable),
    "CHECKBOX",
    ["Audiable Effects", "Play audiable effects on vehicle disable"],
    QUOTE(MODULE_BEAUTIFIED - Enhanced Damage Model),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_offroadBumps),
    "CHECKBOX",
    ["Bumps", "Going offroad gets bumpy"],
    QUOTE(MODULE_BEAUTIFIED - Offroad),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_offroadDamage),
    "CHECKBOX",
    ["Damage", "Going offroad can damage a vehicle at high speeds"],
    QUOTE(MODULE_BEAUTIFIED - Offroad),
    true,
    1
] call EFUNC(common,addSetting);