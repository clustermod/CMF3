#include "script_component.hpp"
/*
 * Author: Eric
 * allows using kosherArsenal files with ai units
 *
 * Arguments:
 * 0: kosherAI config
 * - side <SIDE>
 * - file <STRING>
 * - Classlist <ARRAY> [Default: []]
 * - is whitelist? <BOOLEAN> [Default: true]
 * ...
 *
 * Return Value:
 * None
 *
 * Example:
 * [[east, "exampleLoadout"], [west, "exampleLoadout2", ["myFactionClass", "myUnitClass"]]] call cmf_kosherAI_fnc_init
 *
 * Public: Yes
 */
SCRIPT(kosherAI);

/* Save the configs */
GVAR(configs) = _this;

if (!isServer) exitWith {};

["CAManBase", "init", {
    _this spawn {
        params ["_unit"];

        if (isPlayer _unit) exitWith { };

        if (_unit getVariable [QGVAR(disable), false]) exitWith { };

        sleep 0.3;

        /* Check if unit is to be ignored */
        private _unitClass = typeOf _unit;
        private _unitFaction = faction _unit;
        {
            _x params ["_side", "_loadout", ["_list", []], ["_whitelist", false]];

            if (_whitelist) then {
                if (side _unit isEqualTo _side && { (_unitClass in _list) || (_unitFaction in _list) }) exitWith {
                    private _role = [_unit] call FUNC(getRole);
                    private _whitelist = ([_role] call compile(preprocessFileLineNumbers format["rsc\loadouts\%1.sqf", _loadout])) select 1;

                    /* Set the unit's loadout */
                    [_unit, _role, _whitelist] spawn FUNC(setLoadout);
                };
            } else {
                if (side _unit isEqualTo _side && { !(_unitClass in _list) && { !(_unitFaction in _list) } }) exitWith {
                    private _role = [_unit] call FUNC(getRole);
                    private _whitelist = ([_role] call compile(preprocessFileLineNumbers format["rsc\loadouts\%1.sqf", _loadout])) select 1;

                    /* Set the unit's loadout */
                    [_unit, _role, _whitelist] spawn FUNC(setLoadout);
                };
            };
        } forEach (missionNamespace getVariable [QGVAR(configs), []]);
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;