#include "script_component.hpp"

[
    LSTRING(settings_category_displayname),
    QGVAR(open_menu), 
    [LSTRING(settings_open_settings_displayname), "Opens a settings menu where you can configure View Distance"],
    { if (!is3DEN) then { createDialog QGVAR(menu) } },
    "", 
    [DIK_BACKSLASH, [false, true, false]], 
    false
] call EFUNC(common,addKeybind);

[
    LSTRING(settings_category_displayname),
    QGVAR(inc_viewdistance),
    [LSTRING(settings_increase_vd_displayname), "Increments View Distance"],
    { if (!is3DEN) then { [1000] call FUNC(viewdistanceShortcut) } },
    "", 
    [DIK_RBRACKET, [false, true, false]],
    false
] call EFUNC(common,addKeybind);

[
    LSTRING(settings_category_displayname),
    QGVAR(dec_viewdistance),
    [LSTRING(settings_decrease_vd_displayname), "Decrements View Distance"],
    { if (!is3DEN) then { [-1000] call FUNC(viewdistanceShortcut) } },
    "", 
    [DIK_LBRACKET, [false, true, false]],
    false
] call EFUNC(common,addKeybind);