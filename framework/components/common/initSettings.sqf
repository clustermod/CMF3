#include "script_component.hpp"

[
    QSETTING(blacklistedAddons),
    "EDITBOX",
    ["Blacklisted Addons", "Kicks players who loads these addons. Sepperated by comma (,)"],
    QUOTE(MODULE_BEAUTIFIED),
    "TF21_ChemlightDrop",
    1
] call FUNC(addSetting);