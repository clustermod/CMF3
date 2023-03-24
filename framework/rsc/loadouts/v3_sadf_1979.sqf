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
private _defGrenades = ["rhs_grenade_mkii_mag", "rhs_mag_an_m8hc"];
private _defUniforms = ["CUP_U_O_RUS_M88_MSV"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["UNS_Boonie_OD"];
private _defFacewear = ["G_LEN_BCG"];

/* Rifleman */
if (_condition && _role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Galil_556_black"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_35Rnd_556x45_Galil_Mag"];
	_availableVests = ["V_Simc_Barbelt_M56_zusp"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_empty"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition && _role in ["SL", "FTL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Galil_556_black", "CUP_hgun_Browning_HP", "rhssaf_zrak_rd7j"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_35Rnd_556x45_Galil_Mag", "CUP_13Rnd_9x19_Browning_HP"];
	_availableVests = ["V_Simc_Barbelt_M56_zusp"];
	_availableItems = ["ACRE_SEM52SL"];
	_availableGrenades = ["rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red"];
	_availableBackpacks = ["B_simc_ARVN_ruck_rajio_empty"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Medic */
if (_condition && _role in ["MED"]) then {
	_unit setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Galil_556_black"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_35Rnd_556x45_Galil_Mag"];
	_availableVests = ["V_Simc_Barbelt_M56_zusp"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_aatKit"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_pack_frem_med5"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition && _role in ["AR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_FNMAG", "CUP_hgun_Browning_HP"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M", "Tier1_250Rnd_762x51_Belt_M62_Tracer", "CUP_13Rnd_9x19_Browning_HP"];
	_availableVests = ["uns_simc_61_60"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_ARVN_ruck_empty"];
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
