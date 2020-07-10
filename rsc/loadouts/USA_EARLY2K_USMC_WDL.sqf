params["_role", "_obj", "_rearmOnly"];
_availableUniforms = []; _availableWeapons = []; _availableMagazines = []; _availableVests = []; _availableItems = []; _availableBackpacks = []; _availableHeadgear = []; _availableFacewear = [];

// Define default gear (common for all roles)
_defItems = ["cup_acc_flashlight", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
_defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack", "CUP_7Rnd_45ACP_1911"];
_defGrenades = ["rhs_mag_m67", "rhs_mag_an_m8hc", "chemlight_red", "rhs_mag_an_m14_th3"];
_defUniforms = ["CUP_U_B_BDUv2_gloves_M81", "CUP_U_B_BDUv2_dirty_M81", "CUP_U_B_BDUv2_M81", "CUP_U_B_BDUv2_gloves_dirty_M81"];
_defWeapons = ["CUP_hgun_Colt1911"];
_defVests = ["CUP_V_B_Interceptor_Base_M81"];
_defBackpacks = ["rhsgref_wdl_alicepack"];
_defHeadgear = ["CUP_H_PASGTv2_WDL_GG", "CUP_H_PASGTv2_WDL_CF", "CUP_H_PASGTv2_WDL", "CUP_H_PASGTv2_NVG_WDL_CF", "CUP_H_PASGTv2_NVG_WDL_GG_CB", "CUP_H_PASGTv2_NVG_WDL_GG", "CUP_H_PASGTv2_NVG_WDL"];
_defFacewear = ["murshun_cigs_cig0", "CUP_G_ESS_BLK"];

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["Binocular", "rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2", "CUP_arifle_M16A2_GL", "rhs_weap_m16a4_carryhandle_M203"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarFlare_Red_M203", "CUP_1Rnd_SmokeRed_M203", "CUP_1Rnd_SmokeWhite_M203"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81", "CUP_V_B_Interceptor_Grenadier_M81"];
	_availableItems = ["ACRE_PRC148"];
	_availableBackpacks = [];
	_availableHeadgear = ["CUP_H_US_patrol_cap_WDL"];
	_availableFacewear = ["TRYK_headset2_glasses"];
};

// Medic
if (_role == "SL") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m249", "cup_lmg_m249_E2"];
	_availableMagazines = ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m240B", "rhs_weap_m240G"];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m79","CUP_arifle_M16A2_GL", "rhs_weap_m16a4_carryhandle_M203"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_1Rnd_HE_M203", "CUP_1Rnd_HEDP_M203", "CUP_1Rnd_StarFlare_Red_M203", "CUP_1Rnd_SmokeRed_M203", "CUP_1Rnd_SmokeWhite_M203"];
	_availableVests = ["CUP_V_B_Interceptor_Grenadier_M81"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// LAT
if (_role == "LAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2", "CUP_launch_M72A6", "CUP_launch_M72A6_Special"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_maaws", "rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "rhs_mag_maaws_HE", "rhs_mag_maaws_HEDP", "rhs_mag_maaws_HEAT"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = ["rhs_optic_maaws"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// HAT
if (_role == "HAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_fgm148", "rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "rhs_fgm148_magazine_AT"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Engineer
if (_role == "ENG") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m16a4_carryhandle", "CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red"];
	_availableVests = ["CUP_V_B_Interceptor_Rifleman_M81"];
	_availableItems = ["ACE_wirecutter", "Toolkit"];
	_availableBackpacks = [];
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
