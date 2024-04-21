#include "script_component.hpp"
/*
 * Author: Eric
 * Loads logistics crate defines from given preset
 * 
 * Arguments:
 * 0: Preset name <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myLogistics"] call cmf_logistics_fnc_cratepreset
 * 
 * Public: Yes
 */
params ["_name"];

if (isNil "_name") exitWith { ERROR_MSG("No preset defined") };
private _path = format["rsc\loadouts\%1.sqf", _name];
if !(fileExists _path) exitWith { ERROR_MSG_1("Unable to find preset: %1", _name); };
GVAR(crateConfigFile) = _name;

private _presets = [call compile preprocessFileLineNumbers _path] call CBA_fnc_hashCreate;
GVAR(crateConfig) = _presets;
publicVariable QGVAR(crateConfig);

{
    private _key = _x;
    private _preset = [_presets, _x] call CBA_fnc_hashGet;

    private _presetData = [_preset] call FUNC(presetCompile);

    /* Create amount tracker */
    private _crateHash = missionNamespace getVariable [QGVAR(crateHash), [] call CBA_fnc_hashCreate];
    private _newAmount = [_crateHash, _key, 0] call CBA_fnc_hashSet;
    GVAR(crateHash) = _newAmount;
    publicVariable QGVAR(crateHash);

    /* Using this method won't allow for using the same crate for different crates */
    [(_presetData select 1), "init", compile ("
        params ['_crate'];

        if (_crate getVariable ['ace_cargo_customName', ''] isEqualTo '') then {
            _crate setVariable ['ace_cargo_customName', '" + _key + " Crate | ', true];
        };
        
        private _weight = [] call ace_dragging_fnc_getWeight;
        _weight = (_weight > misionNamespace getVariable [""ACE_maxWeightDrag"", 1E11]);

        private _position = _object getVariable [""ace_dragging_carryPosition"", [0, 1.5, 0]];
        private _direction = _object getVariable [""ace_dragging_carryDirection"", 0];

        [_crate, true, _position, _direction, _weight] call ace_dragging_fnc_setCarryable;

        _position = _object getVariable [""ace_dragging_dragPosition"", [0, 1.5, 0]];
        _direction = _object getVariable [""ace_dragging_dragDirection"", 0];
        [_crate, true, _position, _direction, _weight] call ace_dragging_fnc_setDraggable;


        [_crate, " + str _presetData + "] call cmf_logistics_fnc_fillCrate
    "), true, [], true] call CBA_fnc_addClassEventHandler;
} forEach ([_presets] call CBA_fnc_hashKeys);