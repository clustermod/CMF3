/*
 * Author: Eric
 * Restricts vehicle operator positions (Driver, gunner and commander) to specific units
 *
 *Arguments:
 * 0: obj <OBJECT>
 * 1: varName <STRING>
 * 2: failText <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, "BMPCREW", "You require a crewman kit to operate this vehicle"] call EMF_fnc_restrictedVehicle
 *
 * public: Yes
*/

params["_obj", "_varName", "_failText"];

// Variables to pass into the event handlers
EMF_GVAR_RV_restricedVehicleVarName = _varName;
EMF_GVAR_RV_failText = _failText;

// Create a event handler for when a unit enters the vehicle
_obj addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_role"];

	// If the unit isn't allowed to enter the given position kick it out
	if (_role == "driver" && !(_unit getVariable [EMF_GVAR_RV_restricedVehicleVarName, false]) || _role == "gunner" && !(_unit getVariable [EMF_GVAR_RV_restricedVehicleVarName, false])) then {
		[EMF_GVAR_RV_failText] remoteExec ["hint", _unit];
		_unit action ["getOut", _vehicle];
	};
}];

// Create a event handler for when a unit switches seats
_obj addEventHandler ["SeatSwitched", {
	params ["_vehicle", "_unit1", "_unit2"];
	private _role = (assignedVehicleRole _unit1) select 0;

	// If unit1 isn't allowed to enter the given position kick it out
	if (_role == "driver" && !(_unit1 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false]) || _role == "Turret" && !(_unit1 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false])) then {
		[EMF_GVAR_RV_failText] remoteExec ["hint", _unit1];
		_unit1 action ["getOut", _vehicle];
	};

	// If unit2 isn't allowed to enter the given position kick it out
	if (_role == "driver" && !(_unit2 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false]) || _role == "Turret" && !(_unit2 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false])) then {
		[EMF_GVAR_RV_failText] remoteExec ["hint", _unit2];
		_unit2 action ["getOut", _vehicle];
	};

}];
