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
private _defItems = ["ACRE_PRC343", "ACE_Canteen", "ACE_EarPlugs", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = ["rhs_mag_an_m8hc", "CUP_HandGrenade_L109A2_HE", "SmokeShellBlue", "SmokeShellPurple", "SmokeShellRed"];
private _defUniforms = ["U_Simc_bdu_erla_blench"];
private _defVests = ["CUP_V_B_BAF_DPM_Osprey_Mk3_Scout"];
private _defBackpacks = ["CUP_B_ACRPara_dpm"];
private _defHeadgear = ["rhsusf_ach_bare_headset_ess", "rhsusf_ach_bare_headset"];
private _defFacewear = ["BWA3_G_Combat_clear", "rhs_ess_black"];

/* Rifleman */
if (_condition && _role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_mk18_black", "rhs_weap_m16a4", "CUP_hgun_Glock17_tan"];
	_availableAttachments = ["rhsusf_acc_compm4", "rhsusf_acc_elcan"];
	_availableMagazines = ["CUP_30Rnd_556x45_PMAG_BLACK", "CUP_17Rnd_9x19_glock17"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition && _role in ["SL", "FTL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_mk18_black", "rhs_weap_m16a4", "CUP_hgun_Glock17_tan"];
	_availableAttachments = ["rhsusf_acc_compm4", "rhsusf_acc_elcan"];
	_availableMagazines = ["CUP_30Rnd_556x45_PMAG_BLACK", "CUP_17Rnd_9x19_glock17"];
	_availableVests = [];
	_availableItems = ["ACRE_PRC117F"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Medic */
if (_condition && _role in ["MED"]) then {
	_unit setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_mk18_black", "rhs_weap_m16a4", "CUP_hgun_Glock17_tan"];
	_availableAttachments = ["rhsusf_acc_compm4", "rhsusf_acc_elcan"];
	_availableMagazines = ["CUP_30Rnd_556x45_PMAG_BLACK", "CUP_17Rnd_9x19_glock17"];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition && _role in ["AR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_minimi_para_railed", "CUP_hgun_Glock17_tan"];
	_availableAttachments = ["rhsusf_acc_compm4", "rhsusf_acc_elcan", "rhsusf_acc_saw_bipod", "rhsusf_acc_grip4_bipod"];
	_availableMagazines = ["CUP_17Rnd_9x19_glock17", "CUP_200Rnd_TE4_Red_Tracer_556x45_M249"];
	_availableVests = [];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Assistant Autorifleman */
if (_condition && _role in ["AAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_mk18_black", "rhs_weap_m16a4", "CUP_hgun_Glock17_tan"];
	_availableAttachments = ["rhsusf_acc_compm4", "rhsusf_acc_elcan"];
	_availableMagazines = ["CUP_30Rnd_556x45_PMAG_BLACK", "CUP_17Rnd_9x19_glock17", "CUP_200Rnd_TE4_Red_Tracer_556x45_M249"];
	_availableVests = [];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Anti-Tank, Light */
if (_condition && _role in ["LAT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_mk18_black", "rhs_weap_m16a4", "CUP_hgun_Glock17_tan", "rhs_weap_m72a7", "CUP_launch_M136"];
	_availableAttachments = ["rhsusf_acc_compm4", "rhsusf_acc_elcan"];
	_availableMagazines = ["CUP_30Rnd_556x45_PMAG_BLACK", "CUP_17Rnd_9x19_glock17"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
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
