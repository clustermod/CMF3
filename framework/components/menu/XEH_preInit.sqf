#include "script_component.hpp"

/* Add player self actions */
["ace_interact_menu_newControllableObject", {
    params ["_type"];
    
    if (!(_type isKindOf "Man")) exitWith {};


    private _children = {
        params ["_target"];

        private _actions = [];

        _actions pushBack [[_target] call FUNC(bugs), [], _target];
        _actions pushBack [[_target] call FUNC(diagnostics), [], _target];
        _actions pushBack [[_target] call FUNC(safestart), [], _target];
        _actions pushBack [[_target] call FUNC(hideHUD), [], _target];

        private _action = ([QGVAR(submitAAR), LSTRING(aar_displayname), "rsc\data\icon_ace_debrief_ca.paa", { _this call EFUNC(aar,submitAAR) }, { true }] call ace_interact_menu_fnc_createAction);
        _actions pushBack [_action, [], _target];

        private _action = ([QGVAR(viewDistance), LSTRING(viewdistance_displayname), "rsc\data\icon_ace_viewDistance_ca.paa", { _this call EFUNC(viewdistance,openDialog); }, { true }] call ACEFUNC(interact_menu,createAction));
        _actions pushBack [_action, [], _target];

        _actions;
    };

    private _action = [QGVAR(main), LSTRING(cc_menu_displayname), "rsc\data\icon_ace_settings_ca.paa", {}, { true }, _children] call ACEFUNC(interact_menu,createAction);
    [_type, 1, ["ACE_SelfActions"], _action, true] call ACEFUNC(interact_menu,addActionToClass);
}] call CBAFUNC(addEventHandler);