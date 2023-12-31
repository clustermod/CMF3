#include "script_component.hpp"

/* Add zeus actions */
private _children = {
    params ["_target"];

    private _actions = [];

    _actions pushBack [[_target] call FUNC(bugs), [], _target];
    _actions pushBack [[_target] call FUNC(diagnostics), [], _target];
    _actions pushBack [[_target] call FUNC(safestart), [], _target];

    private _action = ([QGVAR(submitAAR), LSTRING(aar_displayname), "rsc\data\icon_ace_debrief_ca.paa", { _this call EFUNC(aar,submitAAR) }, { true }] call ace_interact_menu_fnc_createAction);
    _actions pushBack [_action, [], _target];

    private _action = ([QGVAR(viewDistance), LSTRING(viewdistance_displayname), "rsc\data\icon_ace_viewDistance_ca.paa", { createDialog QEGVAR(viewdistance,menu); }, { true }] call ACEFUNC(interact_menu,createAction));
    _actions pushBack [_action, [], _target];

    _actions;
};

private _zeusAction = [QGVAR(main), LSTRING(cc_menu_displayname), "rsc\data\icon_ace_settings_ca.paa", {}, { true }, _children] call ACEFUNC(interact_menu,createAction);
[["ACE_ZeusActions"], _zeusAction] call ace_interact_menu_fnc_addActionToZeus;