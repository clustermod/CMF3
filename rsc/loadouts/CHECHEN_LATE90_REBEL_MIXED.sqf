params["_role", "_obj", "_rearmOnly"];
_availableUniforms = []; _availableWeapons = []; _availableMagazines = []; _availableVests = []; _availableItems = []; _availableBackpacks = []; _availableHeadgear = []; _availableFacewear = [];

// Define default gear (common for all roles)
_defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
_defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
_defGrenades = ["rhs_mag_rdg2_black", "rhs_mag_rdg2_white", "rhs_mag_rgd5", "rhs_mag_f1"];
_defUniforms = ["CUP_U_O_Partisan_VSR_Mixed1", "rhs_uniform_flora_patchless_alt", "rhs_uniform_flora_patchless", "rhsgref_uniform_ttsko_forest", "CUP_U_O_Partisan_TTsKO", "rhsgref_uniform_reed", "CUP_U_O_CHDKZ_Kam_01", "CUP_U_O_CHDKZ_Kam_02", "CUP_U_O_CHDKZ_Commander", "CUP_U_O_CHDKZ_Kam_07"];
_defWeapons = [];
_defVests = ["rhs_6b5_vsr", "rhs_6b5_ttsko", "rhs_6b5",  "rhs_6b5_khaki", "rhs_6b5_rifleman_vsr", "rhs_6b5_rifleman_ttsko", "rhs_6b5_rifleman",  "rhs_6b5_rifleman_khaki"];
_defBackpacks = [];
_defHeadgear = ["CUP_H_SLA_Helmet_OD_worn", "CUP_H_RUS_SSH68_cover_vsr93", "rhsgref_ssh68_ttsko_forest"];
_defFacewear = ["murshun_cigs_cig0"];

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_akms", "rhs_weap_aks74"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "rhs_30Rnd_545x39_7N6M_AK", "rhs_45Rnd_545x39_AK_Green", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74n", "CUP_arifle_AKMS", "rhs_weap_aks74n", "rhs_weap_ak74n_gp25", "CUP_arifle_AKMS_GL", "rhs_weap_aks74n_gp25", "Binocular"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_3-Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_30Rnd_762x39mm_tracer", "CUP_1Rnd_SMOKE_GP25_M", "CUP_1Rnd_SMOKERed_GP25_M", "CUP_IlumFlareWhite_GP25_M", "rhs_VOG25", "rhs_VOG25P"];
	_availableVests = ["rhs_6b5_officer_khaki", "rhs_6b5_officer", "rhs_6b5_officer_ttsko", "rhs_6b5_officer_vsr"];
	_availableItems = ["ACRE_SEM52SL", "rhs_acc_1p78"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_akms", "rhs_weap_aks74"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "rhs_45Rnd_545x39_AK_Green", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_30Rnd_762x39mm_tracer"];
	_availableVests = ["rhs_6b5_medic_khaki", "rhs_6b5_medic", "rhs_6b5_medic_ttsko", "rhs_6b5_medic_vsr"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_RPK74_45"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "rhs_45Rnd_545x39_AK_Green"];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_pkm"];
	_availableMagazines = ["rhs_100Rnd_762x54mmR_green"];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74_gp25", "rhs_weap_akms_gp25", "rhs_weap_aks74_gp25"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_3-Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_30Rnd_762x39mm_tracer", "CUP_1Rnd_SMOKE_GP25_M", "CUP_1Rnd_SMOKERed_GP25_M", "CUP_IlumFlareWhite_GP25_M", "rhs_VOG25", "rhs_VOG25P"];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// LAT
if (_role == "LAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_aks74u", "rhs_weap_rpg7"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "rhs_45Rnd_545x39_AK_Green", "rhs_rpg7_OG7V_mag", "rhs_rpg7_PG7V_mag"];
	_availableVests = [];
	_availableItems = ["rhs_acc_pgo7v"];
	_availableBackpacks = ["CUP_B_RPGPack_Khaki"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_aks74u", "rhs_weap_rpg7"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "rhs_45Rnd_545x39_AK_Green", "rhs_rpg7_OG7V_mag", "rhs_rpg7_PG7VL_mag"];
	_availableVests = [];
	_availableItems = ["rhs_acc_pgo7v"];
	_availableBackpacks = ["CUP_B_RPGPack_Khaki"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// HAT
if (_role == "HAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_aks74u", "rhs_weap_rpg7"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "rhs_45Rnd_545x39_AK_Green", "rhs_rpg7_OG7V_mag", "rhs_rpg7_PG7VR_mag"];
	_availableVests = [];
	_availableItems = ["rhs_acc_pgo7v"];
	_availableBackpacks = ["CUP_B_RPGPack_Khaki"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Engineer
if (_role == "ENG") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = [];
	_availableWeapons = [];
	_availableMagazines = [];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_RUS_Backpack"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

//Populate with predefined items and whatever is already in the crate
_backpacks 	= (_availableBackpacks + _defBackpacks);
_items 		= (_availableVests + _availableItems + _availableUniforms + _defUniforms + _defVests + _defItems + _defFacewear + _availableFacewear + _defHeadgear + _availableHeadgear);
_magazines 	= (_availableMagazines + _defGrenades + _defMagazines);
_weapons 	= (_availableWeapons + _defWeapons);

if (!_rearmOnly) then {
	[_obj, _backpacks] 	call BIS_fnc_addVirtualBackpackCargo;
	[_obj, _items	 ] 	call BIS_fnc_addVirtualItemCargo;
	[_obj, _magazines] 	call BIS_fnc_addVirtualMagazineCargo;
	[_obj, _weapons	 ] 	call BIS_fnc_addVirtualWeaponCargo;
} else {
	[_obj, _magazines] 	call BIS_fnc_addVirtualMagazineCargo;
	[_obj, (_availableItems + _defItems)] call BIS_fnc_addVirtualItemCargo;
};


player setVariable ["EMF_KA_permittedGear", [_backpacks, _items, _magazines, _weapons], true];
