/*
 * Author: [Author]
 * [Description]
 *
 * [Modpack Version]
 */
params["_unit"];

/* Get the group type */
private _condition = (group _unit) getVariable ["cmf_common_group_type", "INF"];
private _availableVehicles = []; private _availablePylons = []; private _availableCamos = []; private _availableComponents = [];

/* If true will only show pylons compatible with the selected vehicle, if false will show all available pylons */
private _compPylons = true;

/* Default Vehicles */
private _defVehicles = []; // "ALL" for all vehicles
private _defPylons = []; //  "ALL" for all pylons
private _defCamos = []; //  "ALL" for all camos
private _defComponents = []; //  "ALL" for all components

/* SIERRA (APC) */
if (_condition in ["SIERRA", "ARMOR"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* MIKE (IFV) */
if (_condition in ["MIKE", "ARMOR"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* TANGO (MBT) */
if (_condition in ["TANGO", "ARMOR"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* PHANTOM (CAS/TRANS) */
if (_condition in ["PHANTOM", "TRANS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* REAPER (CAS) */
if (_condition in ["REAPER", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* UGLY (HEAVY CAS) */
if (_condition in ["UGLY", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* HAWG (Ground-Attack Jet) */
if (_condition in ["HAWG", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* PAVEMENT (A2A/Bomber Jet) */
if (_condition in ["PAVEMENT", "CAS"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* MORTARS (Mortar squad) */
if (_condition in ["MORTARS", "SUPPORT"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* LOGISTICS (Logistics squad) */
if (_condition in ["LOGI"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* ENGI (Engineers squad) */
if (_condition in ["ENGI", "SUPPORT"]) then {
	_availableVehicles = [];
	_availablePylons = [];
	_availableCamos = [];
	_availableComponents = [];
};

/* Loadout array that's passed back to kosherGarage */
[
	/* Loadoutfile version */
	"1.0",

	/* Loadout data */
	(_defVehicles + _availableVehicles),
	(_compPylons),
	(_defPylons + _availablePylons),
	(_defCamos + _availableCamos),
	(_defComponents + _availableComponents)
];
