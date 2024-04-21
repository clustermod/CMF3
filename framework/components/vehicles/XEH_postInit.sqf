#include "script_component.hpp"

/* Projectile cache */
GVAR(projectileCache) = [] call CBA_fnc_hashCreate;

/* Vehicle cache */
GVAR(vehicleCache) = [] call CBA_fnc_hashCreate;

GVAR(offroad_bump_delay) = 0;
GVAR(offroad_damage_delay) = 0;

[FUNC(offroadPFH), 0.1] call CBA_fnc_addPerFrameHandler;

/* Clear vehicle cargo */
call FUNC(clearVehicleCargo);

/* Add the eventhandler */
private _fnc_initEH = {
    params ["_vehicle"];

    /* Exit if enhancedVehicles is disabled on vehicle or globally */
    if (!SETTING(enable)) exitWith {};
    if (_vehicle getVariable [QGVAR(disable), false]) exitWith {};

    _vehicle setVariable ["ace_cookoff_enable", false, true];
    _vehicle addEventHandler ["HandleDamage", FUNC(damageEH)];

    // Disable engine when damage is 0.8
    _vehicle addEventHandler ["Engine", {
        params ["_vehicle", "_engineState"];
        if (!_engineState || _vehicle gethit "engine" < 0.8) exitWith {};
        _vehicle engineOn false;
    }];

    /* Fual leak */
    _vehicle spawn FUNC(fuelLeakEH);

    LOG_1("Enabled EnhancedVehicles on %1", typeOf _vehicle);
};

["Car", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;
["Tank", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;

call FUNC(gunEffectEH);

/* Add Fuel canisters to vehicle cargo */
if isServer then {
    ["AllVehicles", "init", {
        params ["_vehicle"];

        if (_vehicle isKindOf "Man") exitWith {};

        ["Land_CanisterFuel_F", _vehicle] call ace_cargo_fnc_loadItem;

        private _canisterSize = ["Land_CanisterFuel_F"] call ace_cargo_fnc_getSizeItem;
        private _oldSpace = (_vehicle getVariable ["ace_cargo_space", getNumber (configOf _vehicle >> "ace_cargo_space")]) max 0;
        [_vehicle, _oldSpace + _canisterSize] call ace_cargo_fnc_setSpace;
    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

/* Add vehicle naming */
private _action = [QGVAR(other), "Other", "", {}, { true }, {
    private _actions = [];
    private _action = [QGVAR(renameObject), "Rename", "a3\3den\data\displays\display3den\panelright\customcomposition_edit_ca.paa", {
        ace_cargo_interactionVehicle = _target;
        createDialog "ace_cargo_renameMenu";
    }, {
        ace_cargo_enable &&
        { ace_cargo_enableRename } &&
        { alive _target } &&
        { [_player, _target, ["isNotSwimming"]] call ace_common_fnc_canInteractWith }
    }] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];

    _actions;
}] call ACE_interact_menu_fnc_createAction;

["Car", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;
["Tank", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;
["Ship", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;
["Air", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;