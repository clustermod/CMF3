#include "script_component.hpp"
/*
 * Author: Eric
 * allows using kosherArsenal files with ai units
 *
 * Arguments:
 * 0: kosherAI config
 * - side <SIDE>
 * - file <STRING>
 * - Ignored Classes <ARRAY>
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
missionNamespace setVariable [QGVAR(configs), _this];

if (!isServer) exitWith {};

["CAManBase", "init", {
	params ["_unit"];

    if (isPlayer _unit) exitWith { };

    /* Check if unit is to be ignored */
    private _unitClass = typeOf _unit;
    private _unitFaction = faction _unit;
    {
        _x params ["_side", "_loadout", "_ignoreList"];
        systemChat str _ignoreList;
        if (side _unit isEqualTo _side && { !(_unitClass in _ignoreList) && !(_unitFaction in _ignoreList) }) then {

            /* Get unit's role */
            private _role = [_unit] call FUNC(getRole);

            /* Get the loadout file */
            private _whitelist = ([_role] call compile(preprocessFileLineNumbers format["rsc\loadouts\%1.sqf", _loadout])) select 1;

            /* Set the unit's loadout */
            [_unit, _role, _whitelist] spawn FUNC(setLoadout);
        };
    } forEach (missionNamespace getVariable [QGVAR(configs), []]);
}] call CBA_fnc_addClassEventHandler;