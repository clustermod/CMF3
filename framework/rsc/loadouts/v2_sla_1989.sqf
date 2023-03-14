/* Get the unit's role */
private _condition = player getVariable ["cmf_common_role", "RFL"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["ACE_Canteen", "ACE_EarPlugs", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = ["rhs_mag_762x25_8", "CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_M", "rhs_VOG25", "CUP_1Rnd_SmokeGreen_GP25_M", "CUP_1Rnd_SmokeRed_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_1Rnd_SmokeYellow_GP25_M", "rhs_VG40OP_green", "rhs_VG40OP_white", "rhs_VG40OP_red"];
private _defGrenades = ["rhs_mag_f1", "rhs_mag_rgd5", "rhs_mag_rdg2_white", "rhs_mag_nspn_red"];
private _defUniforms = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = ["CUP_Beard_Black", "CUP_Beard_Brown", "G_LEN_BCG"];

/* Rifleman */
if (_condition in ["RFL"]) then {
	_availableUniforms = ["CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Urban"];
	_availableWeapons = ["CUP_arifle_AKM_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AKMS_Early", "CUP_arifle_AKS"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["rhs_6b3_AK", "rhs_6b3_AK_2", "rhs_6b3_AK_3"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_rd54_vest"];
	_availableHeadgear = ["UK3CB_ARD_B_H_SSh68", "UK3CB_TKA_I_H_SSh68_Oli", "UK3CB_LSM_B_H_SSh68_OLI"];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition in ["SL", "FTL"]) then {
	_availableUniforms = ["CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Urban"];
	_availableWeapons = ["rhssaf_zrak_rd7j", "rhs_weap_tt33", "CUP_arifle_AKM_GL_Early", "CUP_arifle_AKMS_GL_Early", "CUP_arifle_AK47_GL_Early"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["rhs_6b3_VOG", "rhs_6b3_VOG_2"];
	_availableItems = ["ACRE_SEM52SL", "ACE_Fortify"];
	_availableGrenades = ["rhs_mag_nspn_green", "rhs_mag_nspn_yellow", "rhs_mag_rdg2_black"];
	_availableBackpacks = ["rhs_r148"];
	_availableHeadgear = ["UK3CB_ANA_B_H_Beret_MAR"];
	_availableFacewear = [];
};

/* Medic */
if (_condition in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = ["CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Urban"];
	_availableWeapons = ["CUP_arifle_AKM_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AKMS_Early", "CUP_arifle_AKS"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["rhs_6b3_AK", "rhs_6b3_AK_2", "rhs_6b3_AK_3"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_rd54_vest"];
	_availableHeadgear = ["UK3CB_ARD_B_H_SSh68", "UK3CB_TKA_I_H_SSh68_Oli", "UK3CB_LSM_B_H_SSh68_OLI"];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition in ["AR"]) then {
	_availableUniforms = ["CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Urban"];
	_availableWeapons = ["CUP_arifle_RPK74"];
	_availableAttachments = [];
	_availableMagazines = ["UK3CB_RPK_75rnd_762x39_RT"];
	_availableVests = ["rhs_6b3_RPK"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_rd54_vest"];
	_availableHeadgear = ["UK3CB_ARD_B_H_SSh68", "UK3CB_TKA_I_H_SSh68_Oli", "UK3CB_LSM_B_H_SSh68_OLI"];
	_availableFacewear = [];
};

/* Assistant Autorifleman */
if (_condition in ["AAR"]) then {
	_availableUniforms = ["CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Urban"];
	_availableWeapons = ["CUP_arifle_AKM_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AKMS_Early", "CUP_arifle_AKS"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["rhs_6b3_AK", "rhs_6b3_AK_2", "rhs_6b3_AK_3"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_rd54_vest"];
	_availableHeadgear = ["UK3CB_ARD_B_H_SSh68", "UK3CB_TKA_I_H_SSh68_Oli", "UK3CB_LSM_B_H_SSh68_OLI"];
	_availableFacewear = [];
};

/* Anti-Tank, Light */
if (_condition in ["LAT"]) then {
	_availableUniforms = ["CUP_U_O_SLA_MixedCamo", "CUP_U_O_SLA_Desert", "CUP_U_O_SLA_Urban"];
	_availableWeapons = ["CUP_arifle_AKM_Early", "CUP_arifle_AK47_Early", "CUP_arifle_AKMS_Early", "CUP_arifle_AKS", "rhs_weap_rpg18"];
	_availableAttachments = [];
	_availableMagazines = [];
	_availableVests = ["rhs_6b3_AK", "rhs_6b3_AK_2", "rhs_6b3_AK_3"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_rd54_vest"];
	_availableHeadgear = ["UK3CB_ARD_B_H_SSh68", "UK3CB_TKA_I_H_SSh68_Oli", "UK3CB_LSM_B_H_SSh68_OLI"];
	_availableFacewear = [];
};

/* Crewman */
if (_condition in ["CRW"]) then {
	_availableUniforms = ["CUP_U_O_SLA_Overalls_Tank"];
	_availableWeapons = ["CUP_arifle_AKS74U"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green"];
	_availableVests = ["rhs_6b3"];
	_availableItems = ["ACRE_SEM52SL"];
	_availableGrenades = [];
	_availableBackpacks = ["rhs_r148"];
	_availableHeadgear = ["CUP_H_SLA_TankerHelmet"];
	_availableFacewear = ["G_Aviator"];
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
