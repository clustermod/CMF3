/*
 * Author: [Author]
 * [Description]
 *
 * [Modpack Version]
 */
params ["_role", "_unit"];

/* Custom additional condition */
private _condition = true;
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["ACE_Canteen", "ACE_EarPlugs", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = ["uns_mk2gren", "rhs_mine_Mk2_tripwire_mag"];
private _defUniforms = ["UNS_NVA_K"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = ["G_LEN_BCG"];

/* Rifleman */
if (_condition && _role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_kar98k", "CUP_arifle_IMI_Romat"];
	_availableAttachments = [];
	_availableMagazines = ["rhsgref_5Rnd_792x57_kar98k", "CUP_20Rnd_762x51_FNFAL_M"];
	_availableVests = ["V_sns_m58_laat"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["sns_m53_3", "sns_m53", "H_Simc_Hat_Patrol_od7"];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition && _role in ["SL", "FTL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_smg_UZI", "UK3CB_BHP", "Binocular"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_32Rnd_9x19_UZI_M", "UK3CB_BHP_9_13Rnd"];
	_availableVests = ["V_sns_m58_pistal_laat"];
	_availableItems = ["ACRE_PRC77"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_B_Alice_Radio_Backpack"];
	_availableHeadgear = ["sns_m53_3", "sns_m53", "H_Simc_Hat_Patrol_od7"];
	_availableFacewear = [];
};

/* Medic */
if (_condition && _role in ["MED"]) then {
	_unit setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_smg_UZI", "UK3CB_BHP", "Binocular"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_32Rnd_9x19_UZI_M", "UK3CB_BHP_9_13Rnd"];
	_availableVests = ["V_sns_m58_pistal_laat"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_Alice_K"];
	_availableHeadgear = ["sns_m53_3", "sns_m53", "H_Simc_Hat_Patrol_od7"];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition && _role in ["AR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_IMI_Romat", "CUP_lmg_FNMAG"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_30Rnd_TE1_Red_Tracer_762x51_FNFAL_M", "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = ["V_sns_m58_laat"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_Alice_K"];
	_availableHeadgear = ["sns_m53_3", "sns_m53", "H_Simc_Hat_Patrol_od7"];
	_availableFacewear = [];
};

/* Demolitions Expert */
if (_condition && _role in ["DE"]) then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_kar98k", "CUP_arifle_IMI_Romat"];
	_availableAttachments = [];
	_availableMagazines = ["rhsgref_5Rnd_792x57_kar98k", "CUP_20Rnd_762x51_FNFAL_M", "CUP_PipeBomb_M"];
	_availableVests = ["V_sns_m58_laat"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_Alice_K"];
	_availableHeadgear = ["sns_m53_3", "sns_m53", "H_Simc_Hat_Patrol_od7"];
	_availableFacewear = [];
};

/* Demolitions Expert */
if (_condition && _role in ["CRW"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_smg_UZI", "UK3CB_BHP", "Binocular"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_32Rnd_9x19_UZI_M", "UK3CB_BHP_9_13Rnd"];
	_availableVests = ["uns_simc_flak_M69"];
	_availableItems = ["ACRE_PRC77"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_B_Alice_Radio_Backpack"];
	_availableHeadgear = ["H_Simc_CVC_G_low", "H_Simc_CVC_G"];
	_availableFacewear = [];
};

/* Loadout array that's passed back to kosherArsenal */
[
	/* Loadoutfile version */
	"1.3",

	/* Allowed Equipment array */
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
