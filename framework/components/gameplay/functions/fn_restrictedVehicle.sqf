#include "script_component.hpp"
/*
 * Author: Eric
 * Restricts vehicle operator positions based on supplied condition. (BROKEN)
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Condition <CODE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myVehicle, { [_this, "CREW"] call cmf_common_fnc_isRole }] call cmf_gameplay_fnc_restrictedVehicle
 *
 * public: Yes
*/
SCRIPT(restrictedVehicle);
params ["_vehicle", "_condition"];

// @TODO: rewrite this to be event based and move to Vehicle Component

[_vehicle, QGVAR(restrictedVehicle_condition), _condition] call CBA_fnc_setVarNet;

/* Check units entering vehicle */
_vehicle addEventHandler ["GetIn", {
    params ["_vehicle", "_role", "_unit", "_role"];

    LOG("Unit entered vehicle");

    //if (!isPlayer _unit) exitWith {};
    private _condition = _unit call (_vehicle getVariable [QGVAR(restrictedVehicle_condition), { true }]);
    private _role = (assignedVehicleRole _unit) select 0;

    /* Check if player is allowed to be in seat */
    if ((_role in ["driver", "Turret"]) && { !_condition }) then {
        ["You do not know how to operate this vehicle"] remoteExec ["hint", _unit];
        _unit action ["getOut", _vehicle];
        LOG_2("Kicked %1 out of vehicle %2", name _unit, typeOf _vehicle);
    };
}];

/* Check units switching seats */
_vehicle addEventHandler ["SeatSwitched", {
    params ["_vehicle", "_unit"];

    if (!isPlayer _unit) exitWith {};
    private _role = (assignedVehicleRole _unit) select 0;
    private _condition = _unit call (_vehicle getVariable [QGVAR(restrictedVehicle_condition), { true }]);

    /* Check if player is allowed to be in seat */
    if ((_role in ["driver", "Turret"]) && { !_condition }) then {
        ["You do not know how to operate this vehicle"] remoteExec ["hint", _unit];
        _unit action ["getOut", _vehicle];
        LOG_2("Kicked %1 out of vehicle %2", name _unit, typeOf _vehicle);
    };
}];
