params["_role", "_obj", "_rearmOnly"];
_availableUniforms = []; _availableWeapons = []; _availableMagazines = []; _availableVests = []; _availableItems = []; _availableBackpacks = []; _availableHeadgear = []; _availableFacewear = [];

// Define default gear
_defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
_defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
_defGrenades = ["rhs_mag_f1", "rhs_mag_rgd5", "rhs_mag_rdg2_white", "rhs_mag_rdg2_black"];
_defUniforms = ["CUP_U_O_RUS_VSR93_VDV", "CUP_U_O_RUS_VSR93_VDV_rolled_up", "CUP_U_O_RUS_VSR93_worn_VDV", "CUP_U_O_RUS_VSR93_worn_VDV_rolled_up", "CUP_U_O_RUS_VSR98_VDV", "CUP_U_O_RUS_VSR98_VDV_rolled_up", "CUP_U_O_RUS_VSR98_worn_VDV", "CUP_U_O_RUS_VSR98_worn_VDV_rolled_up"];
_defWeapons = [];
_defVests = [];
_defBackpacks = [];
_defHeadgear = ["CUP_H_RUS_SSH68_olive", "CUP_H_RUS_SSH68_cover_vsr93", "CUP_H_RUS_SSH68_cover_vsr98"];
_defFacewear = ["murshun_cigs_cig0"];

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74m", "rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_aks74"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_rifleman_vsr"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74m", "rhs_weap_ak74", "rhs_weap_ak74_2", "rhs_weap_aks74", "Binocular", "rhs_weap_makarov_pm"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhs_6sh92_vsr_radio", "LOP_V_6Sh92_Radio_OLV", "rhs_6b5_officer_vsr"];
	_availableItems = ["ACRE_SEM52SL", "cup_optic_pechenegscope"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74m", "rhs_weap_ak74", "rhs_weap_aks74", "rhs_weap_ak74_2"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_medic_vsr"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_RPK74M", "CUP_arifle_RPK74"];
	_availableMagazines = ["CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M", "rhs_45Rnd_545x39_7N10_AK", "rhs_45Rnd_545x39_AK_Green", "rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_rifleman_vsr"];
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
	_availableMagazines = ["rhs_100Rnd_762x54mmR", "rhs_100Rnd_762x54mmR_green"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_rifleman_vsr"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_HikingPack_Civ"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_ak74m_gp25", "rhs_weap_ak74_gp25"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green", "rhs_VOG25", "rhs_VOG25P", "CUP_FlareWhite_GP25_M", "CUP_1Rnd_SMOKE_GP25_M", "CUP_1Rnd_SmokeRed_GP25_M"];
	_availableVests = ["rhs_6sh92_vsr_vog", "LOP_V_6Sh92_Vog_OLV", "rhs_6b5_rifleman_vsr"];
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
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green", "rhs_rpg7_PG7V_mag", "rhs_rpg7_OG7V_mag"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_rifleman_vsr"];
	_availableItems = ["rhs_acc_pgo7v3"];
	_availableBackpacks = ["rhs_rpg_empty"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_aks74u", "rhs_weap_rpg7"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green", "rhs_rpg7_PG7VL_mag", "rhs_rpg7_OG7V_mag"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_rifleman_vsr"];
	_availableItems = ["rhs_acc_pgo7v3"];
	_availableBackpacks = ["rhs_rpg_empty"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// HAT
if (_role == "HAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_aks74u", "rhs_weap_rpg7"];
	_availableMagazines = ["rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_plum_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_AK_green", "rhs_rpg7_PG7VR_mag", "rhs_rpg7_OG7V_mag"];
	_availableVests = ["rhs_6sh92_vsr", "LOP_V_6Sh92_OLV", "rhs_6b5_rifleman_vsr"];
	_availableItems = ["rhs_acc_pgo7v3"];
	_availableBackpacks = ["rhs_rpg_empty"];
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
