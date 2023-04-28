/*
 * Author: Eric
 * East German AI loadout
 *
 * v3
 */

/* Get the unit's role */
params ["_role"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defWeapons = [];
private _defAttachments = ["rhs_acc_pgo7v"];
private _defMagazines = [];
private _defGrenades = ["CUP_HandGrenade_RGD5", "rhs_mag_rdg2_white"];
private _defUniforms = ["M93_czech_B"];
private _defVests = ["V_sns_m58_p37_m43"];
private _defBackpacks = [];
private _defHeadgear = ["uns_nva_m56"];
private _defFacewear = ["CUP_G_TK_RoundGlasses", "CUP_G_TK_RoundGlasses_blk"];

/* Rifleman */
if (_role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AKM_Early"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Squad Leader */
if (_role in ["SL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AKM_Early"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Medic */
if (_role in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AKM_Early"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_medic_bag"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Machinegunner */
if (_role in ["MG"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_RPK74"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Anti-Tank */
if (_role in ["AT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AKM_Early", "rhs_weap_rpg7"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M", "rhs_rpg7_PG7V_mag"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_rpg_2"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Engineer */
if (_role in ["ENG"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AKM_Early"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M"];
	_availableVests = [];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Marksman */
if (_role in ["MAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_srifle_SVD"];
	_availableAttachments = ["rhs_acc_pso1m2"];
	_availableMagazines = ["ACE_10Rnd_762x54_Tracer_mag"];
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
