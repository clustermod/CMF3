/*
 * Author: Eric
 * The training loadout used for team leader training
 *
 * CC Core v1
 */

/* Get the unit's role */
private _condition = player getVariable ["cmf_common_role", "RFL"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["ACRE_SEM52SL", "ACE_Canteen", "ACE_EarPlugs", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = ["CUP_20Rnd_762x51_FNFAL_M", "UK3CB_BHP_9_13Rnd", "rhsusf_100Rnd_762x51_m62_tracer"];
private _defGrenades = ["rhs_mag_an_m8hc", "rhs_mag_m67", "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_m18_yellow", "rhs_mag_mk84", "rhs_mag_an_m14_th3", "Chemlight_blue", "Chemlight_green", "Chemlight_red"];
private _defUniforms = ["U_Simc_regenkot", "U_Simc_regenkot_og107"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["H_Simc_SVN_M1_ifak_Cl", "H_Simc_SVN_M1_net_ben", "H_Simc_SVN_M1_net_Op", "H_Simc_SVN_M1_ifak_Op", "H_Simc_SVN_M1_ifak"];
private _defFacewear = ["CUP_G_TK_RoundGlasses_blk", "G_LEN_BCG", "CUP_Beard_Black", "CUP_Beard_Brown"];

/* Rifleman */
if (_condition in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_FNFAL5061_wooden"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["V_sns_m58_p37", "V_sns_m58_p37_bare", "V_sns_m58_p37_m43", "V_Simc_SF_BAR_3", "V_Simc_SF_BAR_2", "V_Simc_SF_BAR_1"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_2"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition in ["SL", "FTL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_FNFAL5061_wooden", "rhssaf_zrak_rd7j", "UK3CB_BHP"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["V_sns_m58_p37", "V_sns_m58_p37_bare", "V_sns_m58_p37_m43", "V_Simc_SF_BAR_3", "V_Simc_SF_BAR_2", "V_Simc_SF_BAR_1"];
	_availableItems = ["ACRE_PRC77"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_rajio_empty", "B_simc_ARVN_ruck_rajio"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Medic */
if (_condition in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_FNFAL5061_wooden"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["V_sns_m58_p37", "V_sns_m58_p37_bare", "V_sns_m58_p37_m43", "V_Simc_SF_BAR_3", "V_Simc_SF_BAR_2", "V_Simc_SF_BAR_1"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_2"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition in ["AR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_FNMAG"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["V_Simc_56_60_doppel"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_2"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Assistant Autorifleman */
if (_condition in ["AAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_FNFAL5061_wooden"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["V_sns_m58_p37", "V_sns_m58_p37_bare", "V_sns_m58_p37_m43", "V_Simc_SF_BAR_3", "V_Simc_SF_BAR_2", "V_Simc_SF_BAR_1"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_2"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Anti-Tank, Light */
if (_condition in ["LAT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_FNFAL5061_wooden", "CUP_launch_M72A6", "CUP_launch_M72A6_Special"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["V_sns_m58_p37", "V_sns_m58_p37_bare", "V_sns_m58_p37_m43", "V_Simc_SF_BAR_3", "V_Simc_SF_BAR_2", "V_Simc_SF_BAR_1"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_2"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Loadout array that's passed back to kosherArsenal */
[
	/* Loadoutfile version */
	"1.2",

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
