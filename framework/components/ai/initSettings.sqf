#include "script_component.hpp"

[
    QSETTING(serverTransfer),
    "CHECKBOX",
    ["Transfer to Server", "Transfers AI ownership to Server"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QSETTING(preventProne),
    "CHECKBOX",
    ["Prevent Prone", "Stops AI from going prone"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QSETTING(skill),
    "CHECKBOX",
    ["Force Skill", "Forces AI skill to the CC Default"],
    QUOTE(MODULE_BEAUTIFIED),
    true,
    1
] call EFUNC(common,addSetting);

[
    QSETTING(reinforce),
    "CHECKBOX",
    ["Auto Reinforce", "Makes AI automatically move towards reported enemy groups"],
    QUOTE(MODULE_BEAUTIFIED - Reinforce),
    false,
    1
] call EFUNC(common,addSetting);

[
    QSETTING(reinforceRange),
    "SLIDER",
    ["Reinforce Max Distance", "Maximum distance a AI group will move to reinforce"],
    QUOTE(MODULE_BEAUTIFIED - Reinforce),
    [0, 5000, 300, 0, false],
    1
] call EFUNC(common,addSetting);

[
    QSETTING(reinforceArtillery),
    "CHECKBOX",
    ["Allow Indirect", "Allow AI units to call for indirect fire on targets"],
    QUOTE(MODULE_BEAUTIFIED - Artillery),
    true,
    1
] call EFUNC(common,addSetting);

[
    QSETTING(reinforceArtillerySides),
    "EDITBOX",
    ["Sides", "Sides that will automatically call artillery (separated by comma)"],
    QUOTE(MODULE_BEAUTIFIED - Artillery),
    "east",
    1
] call EFUNC(common,addSetting);

[
    QSETTING(reinforceArtilleryTimeout),
    "TIME",
    ["Timeout", "Minimum wait time between fire missions"],
    QUOTE(MODULE_BEAUTIFIED - Artillery),
    [0, 3600, 120],
    1
] call EFUNC(common,addSetting);

[
    QSETTING(panicSurrenderChance),
    "SLIDER",
    ["Surrender Chance", "Chance for AI to surrender when they panic"],
    QUOTE(MODULE_BEAUTIFIED - Panic),
    [0, 1, 0.05, 0, true],
    1
] call EFUNC(common,addSetting);

[
    QSETTING(panicRetreatChance),
    "SLIDER",
    ["Retreat Chance", "Chance for AI to retreat when they panic"],
    QUOTE(MODULE_BEAUTIFIED - Panic),
    [0, 1, 0.5, 0, true],
    1
] call EFUNC(common,addSetting);