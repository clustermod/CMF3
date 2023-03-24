/* Get the unit's role */
params ["_role"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = ["rhs_mag_f1", "uns_molotov_mag"];
private _defUniforms = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = [];

/* Rifleman */
if (_role in ["RFL"]) then {
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_TK_Green", "CUP_U_O_TK_MixedCamo"];
	_availableWeapons = ["CUP_arifle_AK47_Early", "CUP_arifle_AKS", "CUP_SKS", "CUP_arifle_FNFAL5060"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_762x39mm_tracer", "CUP_10Rnd_762x39_SKS_M", "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_M"];
	_availableVests = ["CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["rhs_fieldcap_m88_grey", "rhs_fieldcap_m88_grey_back", "rhs_fieldcap_khk", "UNS_Boonie4_VC"];
	_availableFacewear = [];
};

/* Squad Leader */
if (_role in ["SL"]) then {
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_TK_Green", "CUP_U_O_TK_MixedCamo"];
	_availableWeapons = ["CUP_arifle_AK47_Early", "CUP_arifle_AKS", "CUP_SKS", "CUP_arifle_FNFAL5060"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_762x39mm_tracer", "CUP_10Rnd_762x39_SKS_M", "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_M"];
	_availableVests = ["CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["rhs_fieldcap_m88_grey", "rhs_fieldcap_m88_grey_back", "rhs_fieldcap_khk", "UNS_Boonie4_VC"];
	_availableFacewear = [];
};

/* Medic */
if (_role in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_TK_Green", "CUP_U_O_TK_MixedCamo"];
	_availableWeapons = ["CUP_arifle_AK47_Early", "CUP_arifle_AKS", "CUP_SKS", "CUP_arifle_FNFAL5060"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_762x39mm_tracer", "CUP_10Rnd_762x39_SKS_M", "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_M"];
	_availableVests = ["CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_SLA_Medicbag"];
	_availableHeadgear = ["rhs_fieldcap_m88_grey", "rhs_fieldcap_m88_grey_back", "rhs_fieldcap_khk", "UNS_Boonie4_VC"];
	_availableFacewear = [];
};

/* Machinegunner */
if (_role in ["MG"]) then {
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_TK_Green", "CUP_U_O_TK_MixedCamo"];
	_availableWeapons = ["CUP_arifle_RPK74", "rhs_weap_pkm"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_75Rnd_762x39mm_tracer", "rhs_100Rnd_762x54mmR_green"];
	_availableVests = ["CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_CHC_C_B_HIKER"];
	_availableHeadgear = ["rhs_fieldcap_m88_grey", "rhs_fieldcap_m88_grey_back", "rhs_fieldcap_khk", "UNS_Boonie4_VC"];
	_availableFacewear = [];
};

/* Anti-Tank */
if (_role in ["AT"]) then {
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_TK_Green", "CUP_U_O_TK_MixedCamo"];
	_availableWeapons = ["CUP_arifle_AK47_Early", "CUP_arifle_AKS", "CUP_SKS", "CUP_arifle_FNFAL5060", "CUP_launch_RPG7V"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_762x39mm_tracer", "CUP_10Rnd_762x39_SKS_M", "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_M", "CUP_PG7V_M"];
	_availableVests = ["CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["UNS_NVA_RPG"];
	_availableHeadgear = ["rhs_fieldcap_m88_grey", "rhs_fieldcap_m88_grey_back", "rhs_fieldcap_khk", "UNS_Boonie4_VC"];
	_availableFacewear = [];
};

/* Engineer */
if (_role in ["ENG"]) then {
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2", "CUP_U_O_Partisan_TTsKO_Mixed", "CUP_U_O_TK_Green", "CUP_U_O_TK_MixedCamo"];
	_availableWeapons = ["CUP_arifle_AK47_Early", "CUP_arifle_AKS", "CUP_SKS", "CUP_arifle_FNFAL5060"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_762x39mm_tracer", "CUP_10Rnd_762x39_SKS_M", "CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_M"];
	_availableVests = ["CUP_V_OI_TKI_Jacket4_05", "CUP_V_OI_TKI_Jacket4_04", "CUP_V_OI_TKI_Jacket4_02", "CUP_V_OI_TKI_Jacket4_06", "CUP_V_OI_TKI_Jacket4_03", "CUP_V_OI_TKI_Jacket4_01"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["rhs_fieldcap_m88_grey", "rhs_fieldcap_m88_grey_back", "rhs_fieldcap_khk", "UNS_Boonie4_VC"];
	_availableFacewear = [];
};

/* Marksman */
if (_role in ["MAR"]) then {
	_availableUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "CUP_U_O_Partisan_VSR_Mixed2"];
	_availableWeapons = ["CUP_srifle_SVD"];
	_availableAttachments = ["cup_optic_pso_1_1", "cup_svd_camo_g"];
	_availableMagazines = ["rhs_10Rnd_762x54mmR_7N1"];
	_availableVests = ["CUP_V_OI_TKI_Jacket2_01"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["UNS_NVA_RC"];
	_availableHeadgear = ["TRYK_H_Bandana_H", "UK_boonie"];
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
