/*
 * Author: Eric
 * Restricts vehicle operator positions (Driver, gunner and commander) to specific units
 *
 * Arguments:
 * 0: obj <OBJECT>
 * 1: varName <STRING>
 * 2: failText <STRING>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [this, "BMPCREW", "You require a crewman kit to operate this vehicle"] call EMF_fnc_restrictedVehicle
 *
 * public: Yes
*/

params["_obj", "_varName", ["_failText", "You require a crewmankit to operate this position"]];

// Check if params are set and is of correct type
if (isNil "_obj") exitWith {  ['Object is not set'] call BIS_fnc_error; 'Object is not set' call BIS_fnc_log; false;};
if (typeName _obj != "OBJECT") exitWith {  ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_error; ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_log; false;};

if (isNil "_varName") exitWith {  ['varName is not set'] call BIS_fnc_error; 'varName is not set' call BIS_fnc_log; false;};
if (typeName _varName != "STRING") exitWith {  ['varName must be type "STRING", type %1 supplied', (typeName _varName)] call BIS_fnc_error; ['varName must be type "STRING", type %1 supplied', (typeName _varName)] call BIS_fnc_log; false;};

if (typeName _failText != "STRING") exitWith {  ['failText must be type "STRING", type %1 supplied', (typeName _failText)] call BIS_fnc_error; ['failText must be type "STRING", type %1 supplied', (typeName _failText)] call BIS_fnc_log; false;};

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

true;
