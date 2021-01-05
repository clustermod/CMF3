params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
private _defGrenades = ["rhs_mag_an_m8hc", "rhs_mag_m18_green", "rhs_mag_m18_red", "rhs_mag_m18_purple"];
private _defUniforms = [];
private _defWeapons = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = [];

// Set default Insignia
[player, ""] call BIS_fnc_setUnitInsignia;

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = ["usm_bdu_w"];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "rhs_mag_m67"];
	_availableVests = ["usm_vest_pasgt_lbv_rm_m", "usm_vest_pasgt_lbe_rm_m"];
	_availableItems = ["ACRE_PRC343", "ItemGPS"];
	_availableBackpacks = [];
	_availableHeadgear = ["usm_helmet_pasgt_w"];
	_availableFacewear = ["LEN_BCG", "LEN_Ess1", "G_SWDG"];
};

// Medic
if (_role == "MED") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = ["usm_bdu_w"];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "rhs_mag_m67"];
	_availableVests = ["usm_vest_pasgt_lbv_rm_m", "usm_vest_pasgt_lbe_rm_m"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "ACRE_PRC343", "ItemGPS"];
	_availableBackpacks = ["usm_pack_m5_medic"];
	_availableHeadgear = ["usm_helmet_pasgt_w"];
	_availableFacewear = ["LEN_BCG", "LEN_Ess1", "G_SWDG"];
};

// Engineer
if (_role == "ENG") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = ["usm_bdu_w"];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "rhs_mag_m67"];
	_availableVests = ["usm_vest_pasgt_lbv_rm_m", "usm_vest_pasgt_lbe_rm_m"];
	_availableItems = ["ACRE_PRC343", "ItemGPS", "ToolKit"];
	_availableBackpacks = [];
	_availableHeadgear = ["usm_helmet_pasgt_w"];
	_availableFacewear = ["LEN_BCG", "LEN_Ess1", "G_SWDG"];
};

// Platoon Leader
if (_role == "PL") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = ["usm_bdu_w"];
	_availableWeapons = ["CUP_arifle_M16A2"];
	_availableMagazines = ["CUP_30Rnd_556x45_Stanag_Tracer_Red", "rhs_mag_m67"];
	_availableVests = ["usm_vest_pasgt_lbv_rm_m", "usm_vest_pasgt_lbe_rm_m"];
	_availableItems = ["ACRE_PRC148", "ACRE_PRC343", "ItemGPS", "ToolKit"];
	_availableBackpacks = [];
	_availableHeadgear = ["usm_helmet_pasgt_w"];
	_availableFacewear = ["LEN_BCG", "LEN_Ess1", "G_SWDG"];
};

// Pilot
if (_role == "PILOT") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	_availableUniforms = ["nomex_olive"];
	_availableWeapons = ["rhsusf_weap_m9"];
	_availableMagazines = ["rhsusf_mag_15Rnd_9x19_FMJ"];
	_availableVests = ["Airchew_vest_NH"];
	_availableItems = ["ACRE_PRC148", "ItemGPS", "ToolKit", "rhsusf_ANPVS_15"];
	_availableBackpacks = [];
	_availableHeadgear = ["rhsusf_hgu56p", "rhsusf_hgu56p_visor"];
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
