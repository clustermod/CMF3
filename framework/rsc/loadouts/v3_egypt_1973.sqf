/*
 * Author: [Author]
 * [Description]
 *
 * [Modpack Version]
 */

/* Get the unit's role */
params ["_role"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = ["rhs_mag_f1"];
private _defUniforms = ["UK3CB_TKA_I_U_CrewUniform_01_KHK", "UK3CB_TKA_I_U_CrewUniform_02_KHK", "UK3CB_TKA_I_U_CrewUniform_03_KHK"];
private _defVests = ["V_Simc_mk56"];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = ["CUP_G_TK_RoundGlasses_blk", "CUP_Beard_Black", "TRYK_SBeard_BK", "TRYK_SBeard_BW", "TRYK_SBeard_Gr", ""];

/* Rifleman */
if (_role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["uns_ak47"];
	_availableAttachments = ["uns_b_6h3"];
	_availableMagazines = ["uns_ak47mag_NT"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["CUP_H_TK_Helmet"];
	_availableFacewear = [];
};

/* Squad Leader */
if (_role in ["SL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["rhssaf_zrak_rd7j", "uns_ak47"];
	_availableAttachments = ["uns_b_6h3"];
	_availableMagazines = ["uns_ak47mag_NT"];
	_availableVests = [];
	_availableItems = ["ACRE_PRC77"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_B_Alice_Radio_Backpack"];
	_availableHeadgear = ["CUP_H_CZ_Hat01"];
	_availableFacewear = [];
};

/* Medic */
if (_role in ["MED"]) then {
	_availableUniforms = [];
	_availableWeapons = ["uns_ak47"];
	_availableAttachments = ["uns_b_6h3"];
	_availableMagazines = ["uns_ak47mag_NT"];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_Largepack_Med_Des"];
	_availableHeadgear = ["CUP_H_TK_Helmet"];
	_availableFacewear = [];
};

/* Machinegunner */
if (_role in ["MG"]) then {
	_availableUniforms = [];
	_availableWeapons = ["uns_rpd"];
	_availableAttachments = [];
	_availableMagazines = ["uns_rpdmag"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["CUP_H_TK_Helmet"];
	_availableFacewear = [];
};

/* Anti-Tank */
if (_role in ["AT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["uns_ak47", "rhs_weap_rpg7"];
	_availableAttachments = ["uns_b_6h3"];
	_availableMagazines = ["uns_ak47mag_NT", "rhs_rpg7_PG7V_mag"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_RPGPack_Khaki"];
	_availableHeadgear = ["CUP_H_TK_Helmet"];
	_availableFacewear = [];
};

/* Engineer */
if (_role in ["ENG"]) then {
	_availableUniforms = [];
	_availableWeapons = ["uns_ak47"];
	_availableAttachments = ["uns_b_6h3"];
	_availableMagazines = ["uns_ak47mag_NT"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["CUP_H_TK_Helmet"];
	_availableFacewear = [];
};

/* Marksman */
if (_role in ["MAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["uk3cb_enfield_no4t"];
	_availableAttachments = ["uk3cb_optic_no32_distressed"];
	_availableMagazines = ["CUP_10x_303_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["CUP_H_TK_Helmet"];
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
