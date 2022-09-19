params["_role"];
private["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

// Define default gear
private _defItems = [];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = ["rhs_mag_f1", "uns_molotov_mag", "rhs_mag_rgd5", "ALiVE_Handgrenade_stone"];
private _defUniforms = ["LOP_U_BH_Fatigue_FWDL", "LOP_U_BH_Fatigue_FWDL_CHOCO", "LOP_U_BH_Fatigue_M81_FWDL", "UK3CB_KRG_B_U_CombatUniform_02_DDPM", "UK3CB_KRG_B_U_CombatUniform_01_DDPM", "UK3CB_ADR_B_U_CombatUniform_01_CC", "UK3CB_ADR_B_U_CombatUniform_02_CC", "UK3CB_ADR_B_U_CombatUniform_03_CC"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["LOP_H_Turban", "LOP_H_Turban_mask", "LOP_H_Shemag_BLK", "LOP_H_Shemag_BLU", "LOP_H_Shemag_GRE", "LOP_H_Shemag_OLV", "LOP_H_Shemag_RED1", "LOP_H_Shemag_RED2", "LOP_H_Shemag_TAN"];
private _defFacewear = [];

// Rifleman
if (_role == "RFL") then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akm", "rhs_weap_akms", "rhs_weap_pm63", "CUP_srifle_LeeEnfield", "uns_mas4956"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_10x_303_M", "uns_mas4956mag_T", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = ["rhs_chicom_khk", "UK3CB_V_Chicom_Desert", "UK3CB_V_Chicom_Brown"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akm", "rhs_weap_akms", "rhs_weap_pm63", "CUP_srifle_LeeEnfield", "uns_mas4956"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_10x_303_M", "uns_mas4956mag_T", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = ["rhs_chicom_khk", "UK3CB_V_Chicom_Desert", "UK3CB_V_Chicom_Brown"];
	_availableItems = ["ACRE_BF888S"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akm", "rhs_weap_akms", "rhs_weap_pm63", "CUP_srifle_LeeEnfield", "uns_mas4956"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_10x_303_M", "uns_mas4956mag_T", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = ["rhs_chicom_khk", "UK3CB_V_Chicom_Desert", "UK3CB_V_Chicom_Brown"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_Largepack_Med"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MG
if (_role == "MG") then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_pkm", "CUP_arifle_RPK74"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M", "rhs_100Rnd_762x54mmR_green"];
	_availableVests = ["rhs_belt_RPK"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// AT
if (_role == "AT") then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akm", "rhs_weap_akms", "rhs_weap_pm63", "CUP_srifle_LeeEnfield", "uns_mas4956"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_10x_303_M", "uns_mas4956mag_T", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = ["rhs_chicom_khk", "UK3CB_V_Chicom_Desert", "UK3CB_V_Chicom_Brown"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_RPGPack_Khaki"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Engineer
if (_role == "ENG") then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akm", "rhs_weap_akms", "rhs_weap_pm63", "CUP_srifle_LeeEnfield", "uns_mas4956"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_10x_303_M", "uns_mas4956mag_T", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = ["rhs_chicom_khk", "UK3CB_V_Chicom_Desert", "UK3CB_V_Chicom_Brown"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// sniper
if (_role == "MAR") then {
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
