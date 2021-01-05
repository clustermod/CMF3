params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defNODS = ["tgc_pvs23_base", "tgc_pvs23_band", "tgc_pvs23_bolle_a", "tgc_pvs23_bolle_b", "tgc_pvs23_bungee", "tgc_pvs23_special_m", "tgc_pvs23_special_n", "tgc_pvs23_compass", "tgc_pvs23_special_2", "tgc_pvs23_special", "tgc_pvs23_special_p", "tgc_pvs23_special_o"];
private _defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
private _defGrenades = ["SmokeShell", "HandGrenade", "SmokeShellBlue", "SmokeShellRed", "rhs_mag_mk84"];
private _defUniforms = ["CUP_I_B_PMC_Unit_42", "CUP_I_B_PMC_Unit_41", "CUP_I_B_PMC_Unit_43"];
private _defWeapons = [];
private _defVests = ["tgc_cvcrck_n", "tgc_cvcrck_m", "tgc_hpc_one_ng", "tgc_hpc_radio_ng", "tgc_hpc_radio", "tgc_hpc_one", "tgc_mtv_sg", "tgc_mtv_light", "tgc_mtv_lightp", "tgc_mtv_medium", "tgc_mtv_medium2", "tgc_mtv_medium3", "tgc_mtv_radio", "tgc_mtv_tan"];
private _defBackpacks = [];
private _defHeadgear = ["tc2002_sb", "tc2002_sm", "tc2002_blk", "tc2002_od", "tc2002od2", "tc2002_tan", "tc2002_p", "tc2002_s"];
private _defFacewear = ["murshun_cigs_cig0", "rhs_goggles_clear", "rhs_goggles_black", "G_ESS_black"];

// Set default Insignia
[player, ""] call BIS_fnc_setUnitInsignia;

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhsusf_weap_glock17g4"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_mag_17Rnd_9x19_FMJ"];
	_availableVests = [];
	_availableItems = ["sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3"];
	_availableBackpacks = ["tgc_hpc_backpanel", "tgc_ravBackpanel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "rhsusf_bino_m24", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhsusf_weap_glock17g4"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhsusf_mag_17Rnd_9x19_FMJ"];
	_availableVests = [];
	_availableItems = ["ACRE_PRC148", "sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3"];
	_availableBackpacks = ["tgc_hpc_backpanel", "tgc_ravBackpanel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	[player, "UK3CB_BAF_Insignia_RedCross"] call BIS_fnc_setUnitInsignia;
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhsusf_weap_glock17g4"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_mag_17Rnd_9x19_FMJ"];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "adv_aceCPR_AED", "sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3"];
	_availableBackpacks = ["tgc_tssi_m9_hpc"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_Mk48", "CUP_lmg_Mk48_tan", "CUP_lmg_Mk48_nohg", "CUP_lmg_Mk48_nohg_tan", "CUP_lmg_Mk48_des", "CUP_lmg_Mk48_nohg_des"];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = [];
	_availableItems = ["sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "cup_optic_holoblack", "cup_optic_holodesert"];
	_availableBackpacks = ["tgc_tssi_m9_hpc"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhs_weap_M320"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_M397_HET", "rhs_mag_M433_HEDP", "rhs_mag_M441_HE", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green", "rhs_mag_m716_Yellow"];
	_availableVests = [];
	_availableItems = ["sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3"];
	_availableBackpacks = ["tgc_hpc_backpanel", "tgc_ravBackpanel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Engineer
if (_role == "ENG") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "ACE_VMH3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhsusf_weap_glock17g4"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_mag_17Rnd_9x19_FMJ", "DemoCharge_Remote_Mag", "CUP_Mine_M", "ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag"];
	_availableVests = [];
	_availableItems = ["sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3", "ACE_Clacker", "ACE_rope12", "ACE_rope15", "ACE_rope18", "ACE_rope27", "ACE_rope36", "ACE_SpraypaintBlack", "ACE_SpraypaintBlue", "ACE_SpraypaintGreen", "ACE_SpraypaintRed", "ACE_wirecutter"];
	_availableBackpacks = ["tgc_breacherA"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// EOD
if (_role == "EOD") then
{
	player setVariable ["ACE_IsEOD", true, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "ACE_VMH3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhsusf_weap_glock17g4"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_mag_17Rnd_9x19_FMJ"];
	_availableVests = [];
	_availableItems = ["sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3", "ACE_DefusalKit"];
	_availableBackpacks = ["tgc_breacherB"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Ammobearer
if (_role == "AB") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4a1_carryhandle_grip3", "rhs_weap_m4a1_grip3", "rhs_weap_m4a1_carryhandle", "rhs_weap_m4a1", "rhs_weap_m4a1_d", "rhs_weap_m4a1_mstock", "rhs_weap_m4a1_d_mstock", "rhs_weap_m4a1_blockII", "rhs_weap_m4a1_blockII_bk", "rhs_weap_m4a1_blockII_KAC_bk", "rhs_weap_m4a1_blockII_d", "rhs_weap_m4a1_blockII_KAC_d", "rhs_weap_m4a1_blockII_KAC", "rhsusf_weap_glock17g4"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_mag_17Rnd_9x19_FMJ"];
	_availableVests = [];
	_availableItems = ["sma_eotech552_3xdown", "sma_eotech552_3xdown_des", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_acog_usmc", "rhsusf_acc_acog_rmr", "cup_optic_holoblack", "cup_optic_holodesert", "cup_acc_anpeq_15_black", "cup_acc_anpeq_15", "cup_acc_anpeq_15_black_top", "cup_acc_anpeq_15_tan_top", "cup_acc_anpeq_2_grey", "cup_acc_anpeq_2_desert", "cup_acc_anpeq_2_black_top", "cup_acc_anpeq_2_coyote_top", "rhsusf_acc_sfmb556", "rhsusf_acc_sf3p556", "rhsusf_acc_kac_grip", "rhsusf_acc_grip3"];
	_availableBackpacks = ["tgc_hpc_backpanel", "tgc_ravBackpanel"];
	_availableHeadgear = [];
	_availableFacewear = [];
};
//Populate with predefined items and whatever is already in the crate
private _backpacks 	= (_availableBackpacks + _defBackpacks);
private _items 		= (_availableVests + _availableItems + _availableUniforms + _defUniforms + _defVests + _defItems + _defFacewear + _availableFacewear + _defHeadgear + _availableHeadgear + _defNODS);
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
