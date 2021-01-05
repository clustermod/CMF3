params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
private _defGrenades = ["Chemlight_red", "rhs_mag_rdg2_white", "rhs_mag_rgd5"];
private _defUniforms = ["M93_bdu_B", "RSF_Fatigues_Cargo", "RSF_NoSleeve_Green", "RSF_Fatigues_Cargo_green", "M93_lizard_pants_brown_B", "M93_Frog_B"];
private _defWeapons = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["H_Beret_blk", "TRYK_H_Bandana_wig", "rhsgref_hat_M1951", "Bandanna_Green", "rhs_Booniehat_m81"];
private _defFacewear = ["G_Aviator", "G_Shades_Black", "G_Squares_Tinted", "CUP_Beard_Black", "immersion_cigs_cigar0"];

// Set default Insignia
[player, ""] call BIS_fnc_setUnitInsignia;

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["hlc_rifle_g3a3v", "CUP_arifle_FNFAL5060", "CUP_arifle_FNFAL5060_woodland", "rhs_weap_m3a1", "CUP_launch_M72A6"];
	_availableMagazines = ["hlc_20rnd_762x51_T_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_M", "CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_woodland_M", "rhsgref_30rnd_1143x23_M1T_2mag_SMG", "rhsgref_30rnd_1143x23_M1T_SMG"];
	_availableVests = ["CUP_V_O_SLA_M23_1_OD", "rhsgref_chicom", "CUP_V_RUS_Smersh_1", "CUP_V_O_Ins_Carrier_Rig_Light"];
	_availableItems = [];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhssaf_zrak_rd7j", "hlc_rifle_g3a3v", "CUP_arifle_FNFAL5060", "CUP_arifle_FNFAL5060_woodland", "rhs_weap_m3a1", "CUP_launch_M72A6"];
	_availableMagazines = ["hlc_20rnd_762x51_T_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_M", "CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_woodland_M", "rhsgref_30rnd_1143x23_M1T_2mag_SMG", "rhsgref_30rnd_1143x23_M1T_SMG"];
	_availableVests = ["CUP_V_O_SLA_M23_1_OD", "rhsgref_chicom", "CUP_V_RUS_Smersh_1", "CUP_V_O_Ins_Carrier_Rig_Light"];
	_availableItems = ["hlc_optic_zfsg1"];
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
	_availableWeapons = ["hlc_rifle_g3a3v", "CUP_arifle_FNFAL5060", "CUP_arifle_FNFAL5060_woodland", "rhs_weap_m3a1", "CUP_launch_M72A6"];
	_availableMagazines = ["hlc_20rnd_762x51_T_G3", "CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_M", "CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_woodland_M", "rhsgref_30rnd_1143x23_M1T_2mag_SMG", "rhsgref_30rnd_1143x23_M1T_SMG"];
	_availableVests = ["CUP_V_O_SLA_M23_1_OD", "rhsgref_chicom", "CUP_V_RUS_Smersh_1", "CUP_V_O_Ins_Carrier_Rig_Light"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit"];
	_availableBackpacks = ["CUP_B_SLA_Medicbag"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_FNMAG"];
	_availableMagazines = ["CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"];
	_availableVests = ["CUP_V_O_Ins_Carrier_Rig_MG"];
	_availableItems = [];
	_availableBackpacks = ["usm_pack_762x51_ammobelts"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Marksman
if (_role == "MAR") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_svdp_wd"];
	_availableMagazines = ["ACE_10Rnd_762x54_Tracer_mag"];
	_availableVests = ["CUP_V_O_SLA_M23_1_OD", "rhsgref_chicom", "CUP_V_RUS_Smersh_1", "CUP_V_O_Ins_Carrier_Rig_Light"];
	_availableItems = ["rhs_acc_pso1m21", "ACE_RangeCard"];
	_availableBackpacks = [];
	_availableHeadgear = [];
	_availableFacewear = [];
};

// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = ["CUP_glaunch_6G30", "rhs_weap_m3a1"];
	_availableMagazines = ["rhsgref_30rnd_1143x23_M1T_2mag_SMG", "rhsgref_30rnd_1143x23_M1T_SMG", "CUP_6Rnd_HE_GP25_M", "CUP_IlumFlareWhite_GP25_M"];
	_availableVests = ["CUP_V_O_SLA_Carrier_Belt03"];
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
