#include "script_component.hpp"
/*
 * Author: Eric
 * Adds camera shake when firing a gun
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * this spawn cmf_enhancedVehicles_fnc_gunEffectEH;
 *
 * Public: Yes
 */

private _fnc_initEH = {
    params ["_veh"];

    _veh addEventHandler ["Fired", { 
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

        if (_gunner isEqualTo player) then {
            addCamShake [2, 0.2, 25];
        };
    }];
};

["Car", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;
["Tank", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;
["Ship", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;
["StaticWeapon", "init", _fnc_initEH, true, [], true] call CBA_fnc_addClassEventHandler;