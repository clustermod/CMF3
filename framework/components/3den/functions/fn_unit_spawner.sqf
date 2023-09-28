#include "script_component.hpp"
/*
 * Author: Eric
 * Spawns units that follows Clustercommunity's ORBAT
 *
 * Arguments:
 * 0: Path <ARRAY>
 * 1: Name <STRING>
 * 2: Type <STRING>
 * 3: Icon <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[_myspawnMenu], "Squad", "SQUAD"] call cmf_3DEN_fnc_unitSpawner
 *
 * Public: No
 */
SCRIPT(unitSpawner);

params ["_path", "_name", "_type", [ "_icon", ""]];

private _spawnScript = {_this spawn {
    params ["_type"];

    private _position = screenToWorld [0.5, 0.5];

    private _unitArr = [_type] call FUNC(unit_constructor);

    private _unitPos = (_position select 0);
    private _groupPos = (_position select 1);
    private _spawnedGroups = [];
    private _spawnedUnits = [];
    {
        _x params ["_groupName", "_lobbyName", "_groupType", "_groupSize", "_groupOffset", "_groupUnits"];
        private _groupOffset = _groupPos + _groupOffset;
        private _unitGroup = grpNull;
        {
            _x params["_class", "_roleName", "_role", "_rank", "_isLeader", "_unitOffset", "_unitGroupOffset"];
            private _unitOffset = _unitPos + _unitOffset;
            private _groupOffset = _groupOffset + _unitGroupOffset;

            private _unit = objNull;
            if (_isLeader) then {
                _unit = create3DENEntity ["Object", _class, [_unitOffset, _groupOffset, 0]];
                _unitGroup = group _unit;
            } else {
                _unit = _unitGroup create3DENEntity ["Object", _class, [_unitOffset, _groupOffset, 0]];
            };

            _unit setUnitLoadout [[],[],[],[],[],[],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]];
            save3DENInventory [_unit];
            _unit switchMove "amovpercmstpsnonwnondnon";
            _unit set3DENAttribute ["Init", format["[this, ""%1"", 0] call cmf_organization_fnc_setRole;", _role]];
            _unit set3DENAttribute ["description", format["%1@%2", _roleName, _lobbyName]];
            _unit set3DENAttribute ["ControlMP", true];
            _unit set3DENAttribute ["Rank", _rank];

            // If unit is zeus add zeus module
            if (_type isEqualTo "ZEUS") then {
                _unit set3DENAttribute ["Name", "ms_unit_zeus"];

                // Create Zeus module
                private _zeusLogic = create3DENEntity ["Logic", "ModuleCurator_F", [_unitOffset + 1, _groupOffset, 0]];
                _zeusLogic set3DENAttribute ["ModuleCurator_F_Owner", "ms_unit_zeus"];
                _zeusLogic set3DENAttribute ["ModuleCurator_F_Addons", 3];
                add3DENConnection ["Sync", [_zeusLogic], _unit];
            };

            _spawnedUnits pushBack _unit;

            /* Raise event */
            [QGVAR(onUnitSpawned), [_unitGroup]] call CBA_fnc_localEvent;
        } forEach _groupUnits;

        _unitGroup set3DENAttribute ["groupID", _groupName];
        _unitGroup set3DENAttribute ["Init", format["[this, ""%1"", ""%2"", ""%3""] call cmf_common_fnc_setCallsign;", _lobbyName, _groupType, _groupSize]];

        _spawnedGroups pushBack _unitGroup;

        /* Raise event */
        [QGVAR(onGroupSpawned), [_unitGroup]] call CBA_fnc_localEvent;
    } forEach _unitArr;

    if (count _unitArr != 0) then {
        [format["Spawned %1", _type], 0, 1] call BIS_fnc_3DENNotification;

        /* Raise event */
        [QGVAR(onUnitTemplateSpawned), [_spawnedUnits, _spawnedGroups]] call CBA_fnc_localEvent;
    };
}};

/* Create menu */
[_path, _name, _icon, _spawnScript, [_type]] call cmf_3den_fnc_addMenuItem;
