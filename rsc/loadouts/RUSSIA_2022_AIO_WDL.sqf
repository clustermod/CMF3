params["_role"];
private["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

// Define default gear
private _defItems = ["ACRE_PRC343", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defWeapons = ["rhs_weap_pya"];
private _defAttachments = [];
private _defMagazines = ["rhs_mag_9x19_17"];
private _defGrenades = ["rhs_mag_rgn", "rhs_mag_rgo", "rhs_mag_rdg2_white", "rhs_mag_nspn_green", "rhs_mag_nspn_red", "rhs_mag_nspn_yellow"];
private _defUniforms = ["CUP_U_O_RUS_Ratnik_Summer"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["CUP_H_RUS_6B47_v2_GogglesClosed_Summer", "CUP_H_RUS_6B47_v2_GogglesDown_Summer", "CUP_H_RUS_6B47_v2_GogglesUp_Summer"];
private _defFacewear = ["CUP_G_RUS_Balaclava_Ratnik", "CUP_G_RUS_Balaclava_Ratnik_v2", "CUP_RUS_Balaclava_emr"];

// Rifleman
if (_role == "RFL") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M_GL", "rhsusf_bino_m24"];
	_availableAttachments = ["cup_optic_pechenegscope"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_VOG25", "rhs_VOG25P", "rhs_VG40OP_green", "rhs_VG40OP_red", "rhs_VG40OP_white", "rhs_GRD40_Green", "rhs_GRD40_Red", "rhs_GRD40_White"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117_VOG"];
	_availableItems = ["ACRE_PRC148"];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_US_Medic_Backpack"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Autorifleman
if (_role == "AR") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_RPK74M"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_45Rnd_545X39_AK_Green", "CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medium Machine Gunner
if (_role == "MMG") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_Pecheneg"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_100Rnd_762x54mmR_green"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117_PKP"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Light Anti-tank
if (_role == "LAT") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M", "rhs_weap_rpg26"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medium Anti-tank
if (_role == "MAT") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M", "rhs_weap_rpg7"];
	_availableAttachments = ["rhs_acc_pgo7v3"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_rpg7_PG7VM_mag", "rhs_rpg7_PG7VL_mag", "rhs_rpg7_OG7V_mag"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Heavy Anti-tank
if (_role == "HAT") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M", "rhs_weap_rpg7"];
	_availableAttachments = ["rhs_acc_pgo7v3"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_rpg7_PG7VM_mag", "rhs_rpg7_PG7VL_mag", "rhs_rpg7_OG7V_mag", "rhs_rpg7_PG7VR_mag"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AK74M_GL"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_VOG25", "rhs_VOG25P", "rhs_VG40OP_green", "rhs_VG40OP_red", "rhs_VG40OP_white", "rhs_GRD40_Green", "rhs_GRD40_Red", "rhs_GRD40_White"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117_VOG"];
	_availableItems = ["cup_optic_pechenegscope"];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Driver
if (_role == "DRV") then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_AKS74U"];
	_availableAttachments = [];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK"];
	_availableVests = ["rhs_6b45_light"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Marksman
if (_role == "MAR") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_svdp"];
	_availableAttachments = ["rhs_acc_pso1m21"];
	_availableMagazines = ["rhs_10Rnd_762x54mmR_7N1"];
	_availableVests = ["CUP_Vest_RUS_6B45_Sh117"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_O_RUS_Patrol_bag_Summer", "CUP_O_RUS_Patrol_bag_Summer_Shovel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Return loadout arrays
[
	"1.0", // loadout version
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
