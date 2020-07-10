params["_obj", "_varName", "_failText"];

EMF_GVAR_RV_restricedVehicleVarName = _varName;
EMF_GVAR_RV_failText = _failText;

_obj addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];

	if (_role == "driver" && !(_unit getVariable [EMF_GVAR_RV_restricedVehicleVarName, false]) || _role == "gunner" && !(_unit getVariable [EMF_GVAR_RV_restricedVehicleVarName, false])) then {
		hint str(EMF_GVAR_RV_restricedVehicleVarName);
		[EMF_GVAR_RV_failText] remoteExec ["hint", _unit];
		_unit action ["getOut", _vehicle];
	};
}];

_obj addEventHandler ["SeatSwitched", {
	params ["_vehicle", "_unit1", "_unit2"];
	_role = (assignedVehicleRole _unit1) select 0;

	if (_role == "driver" && !(_unit1 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false]) || _role == "Turret" && !(_unit1 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false])) then {
		[EMF_GVAR_RV_failText] remoteExec ["hint", _unit1];
		_unit1 action ["getOut", _vehicle];
	};

	if (_role == "driver" && !(_unit2 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false]) || _role == "Turret" && !(_unit2 getVariable [EMF_GVAR_RV_restricedVehicleVarName, false])) then {
		[EMF_GVAR_RV_failText] remoteExec ["hint", _unit2];
		_unit2 action ["getOut", _vehicle];
	};

}];
