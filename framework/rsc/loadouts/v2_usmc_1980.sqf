/*
 * Author: Eric
 * A US Marines in a 1980 setting (transitional period). Basically a mix of late vietnam era gear with the new PASGT system and M81
 *
 * CC Core v2
 */

/* passed variables */
params ["_role", "_unit"];

/* Custom additional condition */
private _condition = true;
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["cup_acc_zenit_2ds", "ACE_Canteen", "ACE_EarPlugs", "kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = ["rhs_mag_an_m8hc", "rhs_mag_m67"];
private _defUniforms = ["U_Simc_OG107_tee_MC_weiss", "U_Simc_OG107_tee_MC", "U_Simc_OG107_mk1_trop_MC", "U_Simc_OG107_mk1_tuck_trop_MC", "U_Simc_OG107_mk1_MC", "U_Simc_OG107_mk1_tuck_MC", "U_Simc_OG107_mk1_trop_nomex_MC", "U_Simc_OG107_mk1_tuck_trop_nomex_MC", "U_Simc_regenkot_og107", "U_Simc_regenkot_erdl_low", "U_Simc_bdu_eto_blench_trop", "U_Simc_bdu_eto_blench"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = ["G_LEN_BCG", "G_SWDG", "TRYK_SBeard_BK", "TRYK_SBeard", "TRYK_SBeard_BW", "TRYK_SBeard_Gr"];

/* Rifleman */
if (_condition && _role in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A1", "CUP_arifle_M16A1E1"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_20Rnd_556x45_Stanag_Tracer_Red", "CUP_20Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_30Rnd_556x45_Stanag"];
	_availableVests = ["V_Simc_vest_pasgt_alice_lc2", "V_Simc_vest_pasgt_alice_lc2_alt", "V_Simc_vest_pasgt_alice_mc_etool", "V_Simc_vest_pasgt_alice_mc", "V_Simc_vest_pasgt_alice_mc_alt", "V_Simc_vest_pasgt_alice_etool", "V_Simc_vest_pasgt_alice_alt", "V_Simc_vest_pasgt_alice", "V_Simc_Alice_mc_lc2", "V_Simc_Alice_lc2_alt", "V_Simc_Alice_lc2", "V_Simc_Alice_mc_sekop", "V_Simc_Alice_mc_alt", "V_Simc_Alice_mc", "V_Simc_Alice_sekop", "V_Simc_Alice_alt", "V_Simc_Alice", "V_Simc_Alice_ligt_zusp", "V_Simc_Alice_ligt"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_US_ALICE_asspack", "B_simc_pack_alice_flak_frame_1_alt", "B_simc_pack_alice_frame_1"];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition && _role in ["SL", "FTL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A1GL", "rhsusf_weap_m1911a1", "uns_binocular_navy"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_20Rnd_556x45_Stanag_Tracer_Red", "CUP_20Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_30Rnd_556x45_Stanag", "rhs_mag_M397_HET", "rhs_mag_M433_HEDP", "rhs_mag_M441_HE", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green", "rhs_mag_m716_yellow", "rhs_mag_M583A1_white", "rhs_mag_m661_green", "rhs_mag_m662_red", "CUP_1Rnd_StarFlare_Red_M203", "CUP_1Rnd_StarFlare_White_M203", "rhsusf_mag_7x45acp_MHP"];
	_availableVests = ["V_Simc_vest_pasgt_alice_lc2", "V_Simc_vest_pasgt_alice_lc2_alt", "V_Simc_vest_pasgt_alice_mc_etool", "V_Simc_vest_pasgt_alice_mc", "V_Simc_vest_pasgt_alice_mc_alt", "V_Simc_vest_pasgt_alice_etool", "V_Simc_vest_pasgt_alice_alt", "V_Simc_vest_pasgt_alice", "V_Simc_Alice_mc_lc2", "V_Simc_Alice_lc2_alt", "V_Simc_Alice_lc2", "V_Simc_Alice_mc_sekop", "V_Simc_Alice_mc_alt", "V_Simc_Alice_mc", "V_Simc_Alice_sekop", "V_Simc_Alice_alt", "V_Simc_Alice", "V_Simc_Alice_ligt_zusp", "V_Simc_Alice_ligt"];
	_availableItems = ["ACRE_PRC77"];
	_availableGrenades = ["rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red"];
	_availableBackpacks = ["B_simc_pack_alice_flak_frame_rajio", "B_simc_pack_alice_frame_rajio"];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Fireteam Leader and Interpreter */
if (_condition && _role in ["FTL-I"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A1GL", "rhsusf_weap_m1911a1", "uns_binocular_navy"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_20Rnd_556x45_Stanag_Tracer_Red", "CUP_20Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_30Rnd_556x45_Stanag", "rhs_mag_M397_HET", "rhs_mag_M433_HEDP", "rhs_mag_M441_HE", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green", "rhs_mag_m716_yellow", "rhs_mag_M583A1_white", "rhs_mag_m661_green", "rhs_mag_m662_red", "CUP_1Rnd_StarFlare_Red_M203", "CUP_1Rnd_StarFlare_White_M203", "rhsusf_mag_7x45acp_MHP"];
	_availableVests = ["V_Simc_vest_pasgt_alice_lc2", "V_Simc_vest_pasgt_alice_lc2_alt", "V_Simc_vest_pasgt_alice_mc_etool", "V_Simc_vest_pasgt_alice_mc", "V_Simc_vest_pasgt_alice_mc_alt", "V_Simc_vest_pasgt_alice_etool", "V_Simc_vest_pasgt_alice_alt", "V_Simc_vest_pasgt_alice", "V_Simc_Alice_mc_lc2", "V_Simc_Alice_lc2_alt", "V_Simc_Alice_lc2", "V_Simc_Alice_mc_sekop", "V_Simc_Alice_mc_alt", "V_Simc_Alice_mc", "V_Simc_Alice_sekop", "V_Simc_Alice_alt", "V_Simc_Alice", "V_Simc_Alice_ligt_zusp", "V_Simc_Alice_ligt"];
	_availableItems = ["ACRE_PRC77"];
	_availableGrenades = ["rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red"];
	_availableBackpacks = ["B_simc_pack_alice_flak_frame_rajio", "B_simc_pack_alice_frame_rajio"];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Medic */
if (_condition && _role in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A1", "CUP_arifle_M16A1E1"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_20Rnd_556x45_Stanag_Tracer_Red", "CUP_20Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_30Rnd_556x45_Stanag"];
	_availableVests = ["V_Simc_vest_pasgt_alice_lc2", "V_Simc_vest_pasgt_alice_lc2_alt", "V_Simc_vest_pasgt_alice_mc_etool", "V_Simc_vest_pasgt_alice_mc", "V_Simc_vest_pasgt_alice_mc_alt", "V_Simc_vest_pasgt_alice_etool", "V_Simc_vest_pasgt_alice_alt", "V_Simc_vest_pasgt_alice", "V_Simc_Alice_mc_lc2", "V_Simc_Alice_lc2_alt", "V_Simc_Alice_lc2", "V_Simc_Alice_mc_sekop", "V_Simc_Alice_mc_alt", "V_Simc_Alice_mc", "V_Simc_Alice_sekop", "V_Simc_Alice_alt", "V_Simc_Alice", "V_Simc_Alice_ligt_zusp", "V_Simc_Alice_ligt"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit", "ACE_bodyBag"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_pack_frem_flak_med5", "B_simc_pack_frem_med5"];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition && _role in ["AR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_M60"];
	_availableAttachments = [];
	_availableMagazines = ["rhsusf_100Rnd_762x51_m62_tracer", "Tier1_250Rnd_762x51_Belt_M62_Tracer", "Tier1_100Rnd_762x51_Belt_M62_Tracer"];
	_availableVests = ["V_Simc_vest_pasgt_alice_mc_60", "V_Simc_vest_pasgt_alice_mc_249", "V_Simc_vest_pasgt_alice_lc2_60", "V_Simc_vest_pasgt_alice_249", "V_Simc_Alice_249", "V_Simc_Alice_lc2_60", "V_Simc_Alice_mc_249", "V_Simc_Alice_mc_lc2_60", "V_Simc_Alice_60_ligt", "V_Simc_Alice_60", "V_Simc_Alice_mc_60"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = [];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Assistant Autorifleman */
if (_condition && _role in ["AAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A1", "CUP_arifle_M16A1E1"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_20Rnd_556x45_Stanag_Tracer_Red", "CUP_20Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_30Rnd_556x45_Stanag", "rhsusf_100Rnd_762x51_m62_tracer", "Tier1_250Rnd_762x51_Belt_M62_Tracer", "Tier1_100Rnd_762x51_Belt_M62_Tracer"];
	_availableVests = ["V_Simc_vest_pasgt_alice_lc2", "V_Simc_vest_pasgt_alice_lc2_alt", "V_Simc_vest_pasgt_alice_mc_etool", "V_Simc_vest_pasgt_alice_mc", "V_Simc_vest_pasgt_alice_mc_alt", "V_Simc_vest_pasgt_alice_etool", "V_Simc_vest_pasgt_alice_alt", "V_Simc_vest_pasgt_alice", "V_Simc_Alice_mc_lc2", "V_Simc_Alice_lc2_alt", "V_Simc_Alice_lc2", "V_Simc_Alice_mc_sekop", "V_Simc_Alice_mc_alt", "V_Simc_Alice_mc", "V_Simc_Alice_sekop", "V_Simc_Alice_alt", "V_Simc_Alice", "V_Simc_Alice_ligt_zusp", "V_Simc_Alice_ligt"];
	_availableItems = ["ACE_SpareBarrel_Item"];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_pack_alice_flak_frame_1_alt", "B_simc_pack_alice_frame_1"];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Anti-Tank, Light */
if (_condition && _role in ["LAT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_M16A1", "CUP_arifle_M16A1E1", "CUP_launch_M72A6", "CUP_launch_M72A6_Special"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_20Rnd_556x45_Stanag_Tracer_Red", "CUP_20Rnd_556x45_Stanag", "CUP_30Rnd_556x45_Stanag_Tracer_Red", "CUP_30Rnd_556x45_Stanag"];
	_availableVests = ["V_Simc_vest_pasgt_alice_lc2", "V_Simc_vest_pasgt_alice_lc2_alt", "V_Simc_vest_pasgt_alice_mc_etool", "V_Simc_vest_pasgt_alice_mc", "V_Simc_vest_pasgt_alice_mc_alt", "V_Simc_vest_pasgt_alice_etool", "V_Simc_vest_pasgt_alice_alt", "V_Simc_vest_pasgt_alice", "V_Simc_Alice_mc_lc2", "V_Simc_Alice_lc2_alt", "V_Simc_Alice_lc2", "V_Simc_Alice_mc_sekop", "V_Simc_Alice_mc_alt", "V_Simc_Alice_mc", "V_Simc_Alice_sekop", "V_Simc_Alice_alt", "V_Simc_Alice", "V_Simc_Alice_ligt_zusp", "V_Simc_Alice_ligt"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_US_ALICE_asspack", "B_simc_pack_alice_flak_frame_1_alt", "B_simc_pack_alice_frame_1"];
	_availableHeadgear = ["H_Simc_M1_m81_SWDG_B", "H_Simc_M1_m81_ns_B", "H_Simc_M1_m81_B_cl_erla", "H_Simc_pasgt_m81", "H_Simc_pasgt_m81_b", "H_Simc_pasgt_m81_SWDG_low_b", "H_Simc_pasgt_m81_b_SWDG", "H_Simc_pasgt_m81_scrim_panama", "H_Simc_pasgt_m81_scrim", "H_Simc_pasgt_m81_scrim_alt", "H_Simc_pasgt_m81_scrim_SWDG", "H_Simc_pasgt_m81_SWDG", "H_Simc_pasgt_m81_SWDG_low", "H_Simc_M1_erdl2_ns_alt", "H_Simc_M1_erdl2_cl", "H_Simc_M1_erdl_swdg", "H_Simc_M1_bitch_rear_ben", "H_Simc_M1_bitch_Cl", "H_Simc_M1_bitch_swdg", "H_Simc_SVN_M1C_ns", "H_Simc_SVN_M1C_op", "H_Simc_SVN_M1C_Cl"];
	_availableFacewear = [];
};

/* Crewman */
if (_condition && _role in ["CRW"]) then {
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m3a1", "uns_binocular_navy"];
	_availableAttachments = [];
	_availableMagazines = ["rhsgref_30rnd_1143x23_M1911B_SMG"];
	_availableVests = ["V_Simc_vest_pasgt_grun", "V_Simc_vest_pasgt_grun_sluit", "V_Simc_vest_pasgt", "V_Simc_vest_pasgt_sluit"];
	_availableItems = [];
	_availableGrenades = ["rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red"];
	_availableBackpacks = [];
	_availableHeadgear = ["H_Simc_CVC_G", "H_Simc_CVC_G_low", "H_Simc_CVC"];
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
