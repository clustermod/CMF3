params["_role", "_obj", "_rearmOnly"];
_availableUniforms = []; _availableWeapons = []; _availableMagazines = []; _availableVests = []; _availableItems = []; _availableBackpacks = []; _availableHeadgear = []; _availableFacewear = [];

// Define default gear
_defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
_defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
_defGrenades = ["rhs_mag_an_m8hc", "HandGrenade", "SmokeShellBlue", "SmokeShellRed"];
_defUniforms = ["usm_bdu_dcu"];
_defWeapons = [];
_defVests = [];
_defBackpacks = [];
_defHeadgear = ["usm_helmet_pasgt_g_dcu", "usm_helmet_pasgt_dcu"];
_defFacewear = ["rhs_ess_black", "murshun_cigs_cig0"];

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = ["usm_vest_rba_lbe_rm", "usm_vest_rba_lbv_rm", "usm_vest_lbv_rm", "usm_vest_LBE_rm"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A2", "rhsusf_weap_m1911a1"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhsusf_mag_7x45acp_MHP"];
	_availableVests = ["usm_vest_rba_lbe_rmp", "usm_vest_rba_lbv_rmp", "usm_vest_lbv_rmp", "usm_vest_LBE_rmp"];
	_availableItems = ["ACRE_SEM52SL"];
	_availableBackpacks = ["usm_pack_st138_prc77"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = ["usm_vest_rba_lbe_rm", "usm_vest_rba_lbv_rm", "usm_vest_lbv_rm", "usm_vest_LBE_rm"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["usm_pack_m5_medic"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_M249_E2", "CUP_lmg_M60"];
	_availableMagazines = ["rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote", "rhsusf_200Rnd_556x45_soft_pouch_coyote", "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = ["usm_vest_rba_lbe_mg", "usm_vest_rba_lbv_mg", "usm_vest_lbv_mg", "usm_vest_LBE_mg"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then
{
	_availableUniforms = [];
	_availableWeapons = [];
	_availableMagazines = [];
	_availableVests = ["usm_vest_rba_lbe_mg", "usm_vest_rba_lbv_mg", "usm_vest_lbv_mg", "usm_vest_LBE_mg"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = [];
	_availableMagazines = [];
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
	_availableWeapons = ["CUP_arifle_M16A2", "CUP_launch_M72A6"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = ["usm_vest_rba_lbe_rm", "usm_vest_rba_lbv_rm", "usm_vest_lbv_rm", "usm_vest_LBE_rm"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = ["usm_vest_rba_lbe_rm", "usm_vest_rba_lbv_rm", "usm_vest_lbv_rm", "usm_vest_LBE_rm"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// HAT
if (_role == "HAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = ["usm_vest_rba_lbe_rm", "usm_vest_rba_lbv_rm", "usm_vest_lbv_rm", "usm_vest_LBE_rm"];
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
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = ["usm_vest_rba_lbe_rm", "usm_vest_rba_lbv_rm", "usm_vest_lbv_rm", "usm_vest_LBE_rm"];
	_availableItems = [];
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
