params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
private _defGrenades = ["rhs_mag_f1", "rhs_mag_rgd5", "rhs_mag_rdg2_white", "rhs_mag_rdg2_black"];
private _defUniforms = ["CUP_U_O_SLA_Urban"];
private _defWeapons = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["rhs_altyn_novisor", "rhs_altyn"];
private _defFacewear = ["SE_GP7_Gas_Mask"];

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akms", "rhs_weap_tt33", "rhs_weap_makarov_pm"];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "rhs_mag_762x25_8", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhsgref_6b23_khaki"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akms", "rhs_weap_tt33", "rhs_weap_makarov_pm"];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "rhs_mag_762x25_8", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhsgref_6b23_khaki"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akms", "rhs_weap_tt33", "rhs_weap_makarov_pm"];
	_availableMagazines = ["CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "rhs_mag_762x25_8", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhsgref_6b23_khaki"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["rhs_medic_bag"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_pkm", "rhs_weap_tt33", "rhs_weap_makarov_pm"];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M", "rhs_mag_762x25_8", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhsgref_6b23_khaki"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_RUS_Backpack"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "AB") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_akms", "rhs_weap_tt33", "rhs_weap_makarov_pm"];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_bakelite_M", "CUP_30Rnd_762x39_AK47_bakelite_M", "CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M", "CUP_30Rnd_762x39_AK47_M", "rhs_mag_762x25_8", "rhs_mag_9x18_8_57N181S", "CUP_5Rnd_B_Saiga12_Slug", "CUP_5Rnd_B_Saiga12_HE", "CUP_5Rnd_B_Saiga12_Buck_0", "CUP_5Rnd_B_Saiga12_Buck_00", "CUP_5Rnd_B_Saiga12_Buck_1", "CUP_5Rnd_B_Saiga12_Buck_2", "CUP_5Rnd_B_Saiga12_Buck_3", "CUP_5Rnd_B_Saiga12_Buck_4"];
	_availableVests = ["rhsgref_6b23_khaki"];
	_availableItems = [];
	_availableBackpacks = ["CUP_B_RUS_Backpack"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "SHOTGUN") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_sgun_Saiga12K", "rhs_weap_tt33", "rhs_weap_makarov_pm"];
	_availableMagazines = ["CUP_5Rnd_B_Saiga12_Slug", "CUP_5Rnd_B_Saiga12_HE", "CUP_5Rnd_B_Saiga12_Buck_0", "CUP_5Rnd_B_Saiga12_Buck_00", "CUP_5Rnd_B_Saiga12_Buck_1", "CUP_5Rnd_B_Saiga12_Buck_2", "CUP_5Rnd_B_Saiga12_Buck_3", "CUP_5Rnd_B_Saiga12_Buck_4", "rhs_mag_762x25_8", "rhs_mag_9x18_8_57N181S"];
	_availableVests = ["rhsgref_6b23_khaki_sniper"];
	_availableItems = [];
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
