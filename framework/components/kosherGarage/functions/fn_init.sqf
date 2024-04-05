#include "script_component.hpp"
/*
 * Author: Eric
 * Spawns vehicles based on allowed classes
 * 
 * Arguments:
 * 0: SpawnerObject <OBJECT>
 * 1: Spawner Location <OBJECT>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [this, spawnPad] call cmf_kosherGarage_fnc_init
 * 
 * Public: Yes
 */

params ["_obj", "_center", ["_whitelistSelector", "GROUND"]];

if (isNil QGVAR(vehicleHash)) then {
    GVAR(vehicleHash) = [] call CBA_fnc_hashCreate;
};

if (isNil QGVAR(vehiclePresets)) then {
    GVAR(vehiclePresets) = [] call CBA_fnc_hashCreate;
};

/* Create vehicles root menu */
private _action = [QGVAR(root), "Spawn Vehicle", "", { true }, { true }, {
    params ["_target", "_player", "_params"];
    _params params ["_center", "_whitelistSelector"];
    private _actions = [];

    /* Get whitelist */
    private _whitelist = [GVAR(vehiclePresets), _whitelistSelector, []] call CBA_fnc_hashGet;

    /* Create crate spawning actions */
    {
        _x params ["_vehicle", "_amount", ["_condition", { true }]];

        /* Collect data for the condition check */
        private _playerRole = [cmf_player] call EFUNC(organization,getRole);
        private _groupData = [group cmf_player] call EFUNC(organization,groupGetData);

        /* Verify condition */
        _condition = compile (([
            "private _player = cmf_player;",
            QUOTE(private _playerRole = [cmf_player] call EFUNC(organization,getRole);),
            QUOTE(private _groupLevel = ([group cmf_player] call EFUNC(organization,groupGetData)) select 0;),
            QUOTE(private _groupType = ([group cmf_player] call EFUNC(organization,groupGetData)) select 1;),
            "params [""_target"", ""_player"", ""_params""];",
            "_params params [""_vehicle"", ""_center""];",
            "(count (nearestObjects [_center, [""AllVehicles""], 5]) isEqualTo 0) &&"
        ] joinString endl) + (toString _condition));

        private _action = [
            format [QGVAR(%1), _vehicle], 
            format ["Create %1", [configFile >> "CfgVehicles" >> _vehicle] call BIS_fnc_displayName], 
            "", 
            {
                params ["_target", "_player", "_params"];
                _params params ["_vehicleData", "_center"];
                _vehicleData params ["_class", "_amount", "_condition", ["_skin", ""], ["_components", []], ["_pylons", []]];

                private _oldAmount = [GVAR(vehicleHash), _class, 0] call CBA_fnc_hashGet;
                if (_oldAmount >= _amount) exitWith {};

                private _created = _class createVehicle getPos _center;
                _created setPosASL getPosASL _center;
                _created setDir getDir _center;
                
                if (_skin isNotEqualTo "") then {
                    _created setObjectTextureGlobal [0, _skin];
                };

                {
                    _x params [["_anim", ""], ["_state", 1]];
                    _created animateSource [_anim, _state, true];
                } forEach _components;

                {
                    _created setPylonLoadout _x;
                } forEach _pylons;

                GVAR(vehicleHash) = [GVAR(vehicleHash), _class, _oldAmount + 1] call CBA_fnc_hashSet;
                publicVariable QGVAR(vehicleHash);
            }, 
            _condition, {}, [_x, _center], [0, 0, 0], 2, [false, false, false, false, false],
            {
                params ["_target", "_player", "_params", "_actionData"];
                _params params ["_vehicle"];
                _vehicle params ["_class", "_amount"];

                private _oldAmount = [GVAR(vehicleHash), _class, 0] call CBA_fnc_hashGet;

                private _color = ["#888888", "#ffffff"] select (_oldAmount < _amount);
                _actionData set [1, format ["<t color='%4'>Create %1 [%2/%3]</t>", [configFile >> "CfgVehicles" >> _class] call BIS_fnc_displayName, _oldAmount, _amount, _color]];
            }
        ] call ace_interact_menu_fnc_createAction;

        _actions pushBack [_action, [], _target];
    } forEach _whitelist;

    _actions;
}, [_center, _whitelistSelector], [0, 0, 0], 2, [false, false, false, false, false], {
    params ["_target", "_player", "_params", "_actionData"];
    _params params ["_center"];

    private _condition = count (nearestObjects [_center, ["AllVehicles"], 5]) isEqualTo 0;

    private _color = ["#888888", "#ffffff"] select _condition;
    private _warning = [" (Obstruction in spawn location)", ""] select _condition;
    _actionData set [1, format ["<t color='%1'>Spawn Vehicle%2</t>", _color, _warning]];
}] call ace_interact_menu_fnc_createAction;

[_obj, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;