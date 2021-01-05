params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
private _defGrenades = ["rhs_mag_rgd5", "rhs_mag_f1", "rhs_mag_rdg2_white", "rhs_mag_rdg2_black"];
private _defUniforms = ["CUP_U_O_RUS_VSR93_worn_MSV", "CUP_U_O_RUS_VSR93_worn_MSV_rolled_up"];
private _defWeapons = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["CUP_H_SLA_Helmet_OD_worn", "CUP_H_RUS_SSH68_green", "CUP_H_RUS_SSH68_olive", "CUP_H_RUS_SSH68_cover_vsr93", "rhsgref_ssh68_vsr"];
private _defFacewear = ["CUP_Beard_Black", "CUP_Beard_Brown", "murshun_cigs_cig0", "CUP_G_RUS_Balaclava_Ratnik", "CUP_G_RUS_Balaclava_Ratnik_v2", "LEN_BCG"];

// Set default Insignia
[player, ""] call BIS_fnc_setUnitInsignia;

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer"];
	_availableVests = ["rhs_6b5_rifleman_khaki", "rhs_6b5_khaki", "rhs_6b5_rifleman", "rhs_6b5", "rhs_6b5_rifleman_vsr", "rhs_6b5_vsr"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74_gp25", "rhs_weap_akm_gp25", "rhs_weap_akms_gp25", "rhs_weap_aks74_gp25", "rhs_weap_makarov_pm", "ACRE_SEM52SL"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_VOG25", "rhs_VOG25P", "rhs_VG40OP_red", "rhs_GDM40", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhs_6b5_officer_khaki", "rhs_6b5_officer", "rhs_6b5_officer_vsr"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "RTO") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74", "rhs_weap_makarov_pm"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhs_6b5_officer_khaki", "rhs_6b5_officer", "rhs_6b5_officer_vsr"];
	_availableItems = [];
	_availableBackpacks = ["usm_pack_st138_prc77"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	[player, "UK3CB_BAF_Insignia_RedCross"] call BIS_fnc_setUnitInsignia;
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer"];
	_availableVests = ["rhs_6b5_rifleman_khaki", "rhs_6b5_khaki", "rhs_6b5_rifleman", "rhs_6b5", "rhs_6b5_rifleman_vsr", "rhs_6b5_vsr"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["rhs_medic_bag"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_RPK74_45", "CUP_arifle_RPK74"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer", "CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M", "CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"];
	_availableVests = ["rhs_6b5_rifleman_khaki", "rhs_6b5_khaki", "rhs_6b5_rifleman", "rhs_6b5", "rhs_6b5_rifleman_vsr", "rhs_6b5_vsr"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74", "rhs_weap_rpg7"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_rpg7_OG7V_mag", "rhs_rpg7_PG7V_mag", "rhs_rpg7_type69_airburst_mag", "rhs_rpg7_PG7VL_mag"];
	_availableVests = ["rhs_6b5_rifleman_khaki", "rhs_6b5_khaki", "rhs_6b5_rifleman", "rhs_6b5", "rhs_6b5_rifleman_vsr", "rhs_6b5_vsr"];
	_availableItems = ["rhs_acc_pgo7v2"];
	_availableBackpacks = ["rhs_rpg_empty"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Ammo Bearer
if (_role == "AB") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_akm", "rhs_weap_akms", "rhs_weap_aks74"];
	_availableMagazines = ["rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_AK_plum_green", "CUP_30Rnd_TE1_Green_Tracer_545x39_AK74M_M", "rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm_bakelite_tracer", "rhs_VOG25", "rhs_VOG25P", "rhs_VG40OP_red", "rhs_GDM40", "CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M", "CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M", "rhs_rpg7_OG7V_mag", "rhs_rpg7_PG7V_mag", "rhs_rpg7_type69_airburst_mag", "rhs_rpg7_PG7VL_mag"];
	_availableVests = ["rhs_6b5_rifleman_khaki", "rhs_6b5_khaki", "rhs_6b5_rifleman", "rhs_6b5", "rhs_6b5_rifleman_vsr", "rhs_6b5_vsr"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
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
