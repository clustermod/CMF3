params["_role", "_obj", "_rearmOnly"];
_availableUniforms = []; _availableWeapons = []; _availableMagazines = []; _availableVests = []; _availableItems = []; _availableBackpacks = []; _availableHeadgear = []; _availableFacewear = [];

// Define default gear
_defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
_defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
_defGrenades = ["rhs_grenade_m1939e_f_mag", "rhs_grenade_m1939l_f_mag", "rhs_mag_an_m8hc"];
_defUniforms = ["CUP_U_B_GER_Flecktarn_5"];
_defWeapons = [];
_defVests = [];
_defBackpacks = [];
_defHeadgear = ["CUP_H_Ger_M92_Cover_GG_CB", "CUP_H_Ger_M92_Cover", "CUP_H_Ger_M92_Cover_GG_CF", "CUP_H_Ger_M92_Cover_GG"];
_defFacewear = ["murshun_cigs_cig0", "CUP_G_ESS_BLK", "UK3CB_BAF_G_Tactical_Grey"];

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris_black"];
	_availableMagazines = ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_RFL"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris_black"];
	_availableMagazines = ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_TL"];
	_availableItems = ["ACRE_PRC148"];
	_availableBackpacks = [];
	_availableHeadgear = ["CUP_H_Ger_Beret_INF_Grn"];
	_availableFacewear = ["CUP_G_PMC_RadioHeadset"];
};

// Medic
if (_role == "MED") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris_black"];
	_availableMagazines = ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_Med_LT"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["CUP_B_GER_Pack_Flecktarn"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_MG3"];
	_availableMagazines = ["CUP_120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M", "CUP_120Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_MG_LT"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_GER_Pack_Flecktarn"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then
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
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris_black", "CUP_launch_M72A6"];
	_availableMagazines = ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_RFL_LT"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_GER_Pack_Flecktarn"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris_black", "rhs_weap_maaws"];
	_availableMagazines = ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "rhs_mag_maaws_HE", "rhs_mag_maaws_HEDP", "rhs_mag_maaws_HEAT"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_RFL_LT"];
	_availableItems = ["rhs_optic_maaws"];
	_availableBackpacks = ["CUP_B_GER_Pack_Flecktarn"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// HAT
if (_role == "HAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_G3A3_modern_ris_black"];
	_availableMagazines = ["CUP_20Rnd_762x51_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_G3", "ace_compat_rhs_usf3_mag_TOW2A", "ace_compat_rhs_usf3_mag_TOW2b", "ace_compat_rhs_usf3_mag_TOW2"];
	_availableVests = ["CUP_V_B_GER_PVest_Fleck_RFL_LT"];
	_availableItems = ["rhs_optic_maaws"];
	_availableBackpacks = ["CUP_B_GER_Pack_Flecktarn"];
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
