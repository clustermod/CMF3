params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["ACRE_PRC148", "ACE_DAGR", "ACE_SpottingScope", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defMagazines = [];
private _defGrenades = ["Chemlight_blue", "Chemlight_green", "Chemlight_red", "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_an_m8hc", "rhs_mag_an_m14_th3", "rhs_mag_m67"];
private _defUniforms = ["U_B_RBU_DCU"];
private _defWeapons = ["Binocular"];
private _defVests = ["V_SPER_Rig_A_dcu", "V_SPER_Rig_A_m81"];
private _defBackpacks = ["usm_pack_alice"];
private _defHeadgear = ["Beanie_Black", "H_Booniehat_dcu_F"];
private _defFacewear = ["G_SWDG", "LEN_BCG", "CUP_FR_NeckScarf4", "CUP_FR_NeckScarf5", "CUP_FR_NeckScarf2", "CUP_FR_NeckScarf", "CUP_FR_NeckScarf3"];
//[player, "ua_sf_sub"] call BIS_fnc_setUnitInsignia;

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_d", "rhs_weap_m4a1_d_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1_carryhandle_grip3"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_EPM", "rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_acog_d", "rhsusf_acc_acog", "cup_acc_anpeq_2_coyote_top", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_grey", "rhsusf_acc_harris_bipod", "rhsusf_acc_kac_grip"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_m203s_d", "rhs_weap_m4a1_carryhandle_m203s"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_EPM", "rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhs_mag_M441_HE", "rhs_mag_M443_HEDP", "rhs_mag_M397_HET", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_acog_d", "rhsusf_acc_acog", "cup_acc_anpeq_2_coyote_top", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_grey"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Fireteam Leader
if (_role == "FTL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_m203s_d", "rhs_weap_m4a1_carryhandle_m203s"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_EPM", "rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhs_mag_M441_HE", "rhs_mag_M443_HEDP", "rhs_mag_M397_HET", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_acog_d", "rhsusf_acc_acog", "cup_acc_anpeq_2_coyote_top", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_grey"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};


// Medic
if (_role == "MED") then
{
	[player, "UK3CB_BAF_Insignia_RedCross"] call BIS_fnc_setUnitInsignia;
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_d", "rhs_weap_m4a1_d_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1_carryhandle_grip3"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_EPM", "rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_acog_d", "rhsusf_acc_acog", "cup_acc_anpeq_2_coyote_top", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_grey", "rhsusf_acc_harris_bipod", "rhsusf_acc_kac_grip", "ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Autorifleman
if (_role == "AR") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_Mk48", "CUP_lmg_Mk48_des", "CUP_lmg_Mk48_nohg", "CUP_lmg_Mk48_nohg_des", "CUP_lmg_Mk48_nohg_tan"];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_elcan", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// TACP
if (_role == "TACP") then
{
	_availableUniforms = [];
	_availableWeapons = ["UK3CB_BAF_Soflam_Laserdesignator", "rhs_weap_m4a1_d", "rhs_weap_m4a1_d_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1_carryhandle_grip3"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_EPM", "rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_acog_d", "rhsusf_acc_acog", "cup_acc_anpeq_2_coyote_top", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_grey", "rhsusf_acc_harris_bipod", "rhsusf_acc_kac_grip", "ACRE_PRC117F", "ACRE_VHF30108SPIKE"];
	_availableBackpacks = ["usm_pack_alice_prc119"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Marksman
if (_role == "MAR") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_srifle_Mk12SPR"];
	_availableMagazines = ["rhs_mag_20Rnd_556x45_M855A1_Stanag"];
	_availableVests = [];
	_availableItems = ["cup_optic_leupoldm3lr", "cup_muzzle_snds_mk12", "rhsusf_acc_harris_bipod", "ACE_ATrag_MX", "ACE_Kestrel4500", "ACE_RangeCard"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

//Populate with predefined items and whatever is already in the crate
private _backpacks 	= (_availableBackpacks + _defBackpacks);
private _items 		= (_availableVests + _availableItems + _availableUniforms + _defUniforms + _defVests + _defItems + _defFacewear + _availableFacewear + _defHeadgear + _availableHeadgear);
private _magazines 	= (_availableMagazines + _defGrenades + _defMagazines);
private _weapons 	= (_availableWeapons + _defWeapons);

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
