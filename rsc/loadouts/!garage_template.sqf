params["_condition"];
private _availableVehicles = []; private _availablePylons = []; private _availableCamos = []; private _availableComponents = [];

// Only show pylons compatible with selected vehicle
private _compPylons = true;

// Default Vehicles
private _defVehicles = [];
private _defPylons = []; //  "ALL" for all pylons
private _defCamos = []; //  "ALL" for all camos
private _defComponents = []; //  "ALL" for all components

// APC PLT
if (_condition in ["SIERRA", "ARMOR"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// IFV PLT
if (_condition in ["MIKE", "ARMOR"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// MBT PLT
if (_condition in ["TANGO", "ARMOR"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Rotary Light Trans / cas
if (_condition in ["PHANTOM", "TRANS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Rotary CAS
if (_condition in ["REAPER", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Heavy Rotary CAS
if (_condition in ["UGLY", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Fixed Wing Ground Attack
if (_condition in ["HAWG", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Fixed Wing Air superiority / Bomber
if (_condition in ["PAVEMENT", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Mortar squad
if (_condition in ["MORTARS", "SUPPORT"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Logistics Squad
if (_condition in ["LOGI"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Engineer squad
if (_condition in ["ENGI", "SUPPORT"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

// Return loadout arrays
[
	"1.0", // loadout version
	(_defVehicles + _availableVehicles),
	(_compPylons),
	(_defPylons + _availablePylons),
	(_defCamos + _availableCamos),
	(_defComponents + _availableComponents)
];
