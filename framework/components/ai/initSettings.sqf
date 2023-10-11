#include "script_component.hpp"

[
    QGVAR(setting_serverTransfer),
    "CHECKBOX",
    ["Transfer to Server", "Transfers AI ownership to Server"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_preventProne),
    "CHECKBOX",
    ["Prevent Prone", "Stops AI from going prone"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_skill),
    "CHECKBOX",
    ["Force Skill", "Forces AI skill to the CC Default"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_reinforce),
    "CHECKBOX",
    ["Auto Reinforce", "Makes AI automatically move towards reported enemy groups"],
    QUOTE(MODULE_BEAUTIFIED - Reinforce),
    true,
    1
] call EFUNC(common,addSetting);

[
    QGVAR(setting_reinforceRange),
    "SLIDER",
    ["Reinforce Max Distance", "Maximum distance a AI group will move to reinforce"],
    QUOTE(MODULE_BEAUTIFIED - Reinforce),
    [0, 5000, 300, 0, false],
    1
] call EFUNC(common,addSetting);