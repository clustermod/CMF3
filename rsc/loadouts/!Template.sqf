params["_role", "_unit", ["_rand", false]];
private["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

// Define default gear
private _defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = [];
private _defUniforms = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = [];

// Rifleman
if (_role == "RFL") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// LAT
if (_role == "LAT") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// HAT
if (_role == "HAT") then {
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Engineer
if (_role == "ENG") then {
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Return loadout arrays
[
	"1.0", // loadout version
	[
		(_availableBackpacks + _defBackpacks),
		(_availableVests + _defVests),
		(_availableUniforms + _defUniforms),
		(_availableFacewear + _defFacewear),
		(_defHeadgear + _availableHeadgear),
		(_defAttachments + _availableAttachments),
		(_availableMagazines + _defGrenades + _defMagazines + _availableGrenades),
		(_availableWeapons + _defWeapons),
		(_availableItems + _defItems)
	]
];
