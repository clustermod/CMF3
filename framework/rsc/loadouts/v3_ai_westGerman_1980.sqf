/*
 * Author: Eric
 * West German loadout for AI
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
private _defGrenades = ["rhs_mag_an_m8hc", "rhs_grenade_mkii_mag"];
private _defUniforms = ["BWA3_Uniform_Helipilot"];
private _defVests = ["V_sns_m58_p37", "V_sns_m58_p37_m43"];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = ["CUP_G_TK_RoundGlasses", "CUP_G_TK_RoundGlasses_blk"];

/* Rifleman */
if (_role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris", "CUP_smg_UZI"];
	_availableAttachments = ["cup_acc_zenit_2ds"];
	_availableMagazines = ["CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "CUP_32Rnd_9x19_UZI_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["sns_m53_scrim_2", "sns_m53_4"];
	_availableFacewear = [];
};

/* Squad Leader */
if (_role in ["SL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris", "CUP_smg_UZI"];
	_availableAttachments = ["cup_acc_zenit_2ds"];
	_availableMagazines = ["CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "CUP_32Rnd_9x19_UZI_M"];
	_availableVests = [];
	_availableItems = ["ACRE_SEM70"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_rajio_empty"];
	_availableHeadgear = ["BWA3_Beret_PzAufkl"];
	_availableFacewear = [];
};

/* Medic */
if (_role in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris", "CUP_smg_UZI"];
	_availableAttachments = ["cup_acc_zenit_2ds"];
	_availableMagazines = ["CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "CUP_32Rnd_9x19_UZI_M"];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_1"];
	_availableHeadgear = ["sns_m53_scrim_2", "sns_m53_4"];
	_availableFacewear = [];
};

/* Machinegunner */
if (_role in ["MG"]) then {
	_availableUniforms = [];
	_availableWeapons = ["BWA3_MG3"];
	_availableAttachments = [];
	_availableMagazines = ["BWA3_120Rnd_762x51_Tracer"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["sns_m53_scrim_2", "sns_m53_4"];
	_availableFacewear = [];
};

/* Anti-Tank */
if (_role in ["AT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris", "CUP_smg_UZI", "BWA3_PzF3_Tandem_Loaded"];
	_availableAttachments = ["cup_acc_zenit_2ds"];
	_availableMagazines = ["CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "CUP_32Rnd_9x19_UZI_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["sns_m53_scrim_2", "sns_m53_4"];
	_availableFacewear = [];
};

/* Engineer */
if (_role in ["ENG"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris", "CUP_smg_UZI"];
	_availableAttachments = ["cup_acc_zenit_2ds"];
	_availableMagazines = ["CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "CUP_32Rnd_9x19_UZI_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["sns_m53_scrim_2", "sns_m53_4"];
	_availableFacewear = [];
};

/* Marksman */
if (_role in ["MAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris", "CUP_smg_UZI"];
	_availableAttachments = ["cup_acc_zenit_2ds"];
	_availableMagazines = ["CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "CUP_32Rnd_9x19_UZI_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["sns_m53_scrim_2", "sns_m53_4"];
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
