#include "script_component.hpp"
/*
 * Author: Eric
 * Creates an ace action to spawn logistical crates
 * 
 * Arguments:
 * 0: Object <OBJECT>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [this] call cmf_logistics_fnc_crateSpawner
 * 
 * Public: Yes
 */
[{ !isNil QGVAR(crateConfig) }, {
    params ["_obj"];

    /* Create Logistics root menu */
    private _action = [QGVAR(root), "Logistics", "", {}, { true }, {
        private _actions = [];

        /* Create crate spawning actions */
        private _config = missionNamespace getVariable [QGVAR(crateConfig), [] call CBA_fnc_hashCreate];
        {
            private _key = _x;
            private _preset = [_config, _key] call CBA_fnc_hashGet;
            private _presetData = [_preset] call FUNC(presetCompile);

            private _action = [
                format [QGVAR(_%1), _key], 
                format ["Create %1 Crate", _key], 
                "", 
                {
                    params ["_target", "_player", "_params"];
                    _params params ["_preset", "_key"];

                    private _crateHash = missionNamespace getVariable [QGVAR(crateHash), [] call CBA_fnc_hashCreate];
                    private _oldAmount = [_crateHash, _key] call CBA_fnc_hashGet;
                    if (_oldAmount >= (_preset select 0)) exitWith {};

                    private _crate = (_preset select 1) createVehicle [0, 0, 0];
                    private _position = [_target, _crate, _player] call ace_common_fnc_findUnloadPosition;
                    _crate setPos _position;
                    [_player, _crate] call ace_cargo_fnc_unloadCarryItem;

                    private _newHash = [_crateHash, _key, _oldAmount + 1] call CBA_fnc_hashSet;
                    GVAR(crateHash) = _newHash;
                    publicVariable QGVAR(crateHash);
                }, 
                { true }, {}, [_presetData, _key], [0, 0, 0], 2, [false, false, false, false, false],
                {
                    params ["_target", "_player", "_params", "_actionData"];
                    _params params ["_preset", "_key"];

                    private _crateHash = missionNamespace getVariable [QGVAR(crateHash), [] call CBA_fnc_hashCreate];
                    private _oldAmount = [_crateHash, _key, 0] call CBA_fnc_hashGet;

                    private _color = ["#888888", "#ffffff"] select (_oldAmount < (_preset select 0));
                    _actionData set [1, format ["<t color='%4'>Create %1 Crate [%2/%3]</t>", _key, _oldAmount, _preset select 0, _color]];
                }
            ] call ace_interact_menu_fnc_createAction;

            _actions pushBack [_action, [], _target];
        } forEach ([_config] call CBA_fnc_hashKeys);

        _actions;
    }] call ace_interact_menu_fnc_createAction;
    [_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
}, _this] call CBA_fnc_waitUntilAndExecute;
