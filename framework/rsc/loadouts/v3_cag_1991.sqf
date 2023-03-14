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
_availableUniforms = []; _availableWeapons = []; _availableMagazines = []; _availableVests = []; _availableItems = []; _availableBackpacks = []; _availableHeadgear = []; _availableFacewear = []; _availableAttachments = []; _availableGrenades = [];

/* Default gear */
private _defItems = ["ACRE_BF888S", "ItemGPS", "ACE_Canteen", "ACE_EarPlugs", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = ["CUP_hgun_Colt1911", "CUP_arifle_Colt727"];
private _defAttachments = ["cup_optic_aimpoint_5000", "rhsusf_acc_wmx_bk"];
private _defMagazines = ["CUP_7Rnd_45ACP_1911", "CUP_30Rnd_556x45_Stanag_Tracer_Red"];
private _defGrenades = ["rhs_mag_an_m8hc", "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_m67"];
private _defUniforms = ["U_Simc_bdu_raid_trop", "U_simc_bdu_raid", "U_Simc_bdu_raid_knee_trop", "U_Simc_bdu_raid_knee", "U_Simc_bdu_raid_knee_nomex", "U_Simc_bdu_raid_knee_nomex_trop", "U_Simc_bdu_raid_nomex"];
private _defVests = ["V_Simc_vest_fauf", "V_Simc_vest_fauf_2", "V_Simc_vest_fauf_rig_2", "V_Simc_vest_fauf_rig_1", "V_Simc_vest_fauf_rig_3", "V_Simc_vest_fauf_rig_4"];
private _defBackpacks = ["CUP_B_AssaultPack_Black"];
private _defHeadgear = ["H_Simc_protec_half", "H_Simc_protec_half_nvo", "H_Simc_protec_hs_nvo", "H_Simc_protec_hs_nvo_ir", "H_Simc_protec_hs_nvo_ir_swdg", "H_Simc_protec_hs_nvo_ir_swdg_low", "H_Simc_protec_hs_nvo_swdg", "H_Simc_protec_hs_nvo_swdg_low", "H_Simc_protec_half_nvo_ir", "H_Simc_protec_half_nvo_ir_swdg", "H_Simc_protec_half_nvo_ir_swdg_low", "H_Simc_protec_half_nvo_swdg", "H_Simc_protec_half_nvo_swdg_low", "H_Simc_protec_half_swdg", "H_Simc_protec_half_swdg_low", "H_Simc_protec_full", "H_Simc_protec_full_nvo", "H_Simc_protec_full_nvo_ir", "H_Simc_protec_full_nvo_ir_swdg", "H_Simc_protec_full_nvo_ir_swdg_low", "H_Simc_protec_full_nvo_swdg_low", "H_Simc_protec_full_nvo_swdg", "H_Simc_protec_full_swdg", "H_Simc_protec_full_swdg_low"];
private _defFacewear = ["CUP_G_Oakleys_Clr", "CUP_G_Oakleys_Drk", "CUP_G_Oakleys_Embr", "G_Shades_Red"];

/* Rifleman */
if (_condition && _role in ["RFL"]) then {
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

/* Squad Leader and Fireteam Leader */
if (_condition && _role in ["SL", "FTL"]) then {
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

/* Medic */
if (_condition && _role in ["MED"]) then {
	_unit setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = [];
	_availableAttachments = [];
	_availableMagazines = [];
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

/* Assistant Autorifleman */
if (_condition && _role in ["AAR"]) then {
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

/* Anti-Tank, Light */
if (_condition && _role in ["LAT"]) then {
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
