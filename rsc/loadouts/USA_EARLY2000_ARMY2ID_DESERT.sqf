params["_role", "_obj", "_rearmOnly"];
private _availableUniforms = []; private _availableWeapons = []; private _availableMagazines = []; private _availableVests = []; private _availableItems = []; private _availableBackpacks = []; private _availableHeadgear = []; private _availableFacewear = [];

// Define default gear
private _defItems = ["Simc_PVS7", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defMagazines = ["murshun_cigs_matches", "murshun_cigs_cigpack"];
private _defGrenades = ["SmokeShell", "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_m67"];
private _defUniforms = ["U_B_BDU_2ID"];
private _defWeapons = [];
private _defVests = ["V_IBA_Alice"];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = ["G_ESS_black", "murshun_cigs_cig0", "CUP_G_Oakleys_clr", "CUP_G_Oakleys_Drk", "LEN_BCG"];

// Set default Insignia
//[player, ""] call BIS_fnc_setUnitInsignia;

// Rifleman
if (_role == "RFL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_grip3", "cup_acc_anpeq_2_blaack_top"];
	_availableBackpacks = [];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};

// Team leader
if (_role == "SL") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle", "Binocular"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red", "rhs_mag_an_m14_th3"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_grip3", "cup_acc_anpeq_2_blaack_top", "rhsusf_acc_compm4", "rhsusf_acc_acog", "ACRE_PRC152"];
	_availableBackpacks = [];
	_availableHeadgear = ["H_PASGTSpacB_m_dcu", "H_PASGTSpecB_m_dcu_ESS", "H_PASGTSpecB_dcu_G"];
	_availableFacewear = [];
};

// Medic
if (_role == "MED") then
{
	[player, "UK3CB_BAF_Insignia_RedCross"] call BIS_fnc_setUnitInsignia;
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag"];
	_availableVests = [];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "adv_aceCPR_AED", "rhsusf_acc_grip3", "cup_acc_anpeq_2_blaack_top"];
	_availableBackpacks = ["usm_pack_m5_medic"];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};

// SAW/LMG
if (_role == "AR") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m249"];
	_availableMagazines = ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249", "rhs_mag_30Rnd_556x45_M855A1_Stanag"];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = ["usm_pack_200rnd_556_bandoliers"];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};

// MMG
if (_role == "MMG") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m240B", "rhsusf_weap_m9"];
	_availableMagazines = ["rhsusf_100Rnd_762x51_m62_tracer", "rhsusf_mag_15Rnd_9x19_FMJ"];
	_availableVests = [];
	_availableItems = [];
	_availableBackpacks = ["usm_pack_762x51_bandoliers"];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};

// Machinegunner assistant
if (_role == "MGA") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhsusf_100Rnd_762x51_m62_tracer"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_grip3", "cup_acc_anpeq_2_blaack_top"];
	_availableBackpacks = ["usm_pack_762x51_bandoliers"];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};
// Grenadier
if (_role == "GRD") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle_m203s"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_M397_HET", "rhs_mag_M433_HEDP", "rhs_mag_M441_HE", "rhs_mag_m713_Red", "rhs_mag_m714_White", "rhs_mag_m715_Green", "rhs_mag_m716_Yellow"];
	_availableVests = [];
	_availableItems = ["cup_acc_anpeq_2_grey"];
	_availableBackpacks = [];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};

// MAT
if (_role == "MAT") then
{
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle", "rhs_weap_maaws"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_maaws_HE", "rhs_mag_maaws_HEDP", "rhs_mag_maaws_HEAT"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_grip3", "cup_acc_anpeq_2_blaack_top", "cup_optic_maaws"];
	_availableBackpacks = ["B_patrelPack_m81"];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
	_availableFacewear = [];
};

// Engineer
if (_role == "ENG") then
{
	player setVariable ["ACE_IsEngineer", 2, true];
	player setVariable ["ACE_IsEOD", true, true];
	_availableUniforms = [];
	_availableWeapons = ["rhs_weap_m4_carryhandle", "ACE_VMH3", "ACE_VMM3"];
	_availableMagazines = ["rhs_mag_30Rnd_556x45_M855A1_Stanag", "DemoCharge_Remote_Mag", "CUP_Mine_M", "ClaymoreDirectionalMine_Remote_Mag", "SLAMDirectionalMine_Wire_Mag"];
	_availableVests = [];
	_availableItems = ["rhsusf_acc_grip3", "cup_acc_anpeq_2_blaack_top", "ACE_Clacker", "ACE_rope12", "ACE_rope15", "ACE_rope18", "ACE_rope27", "ACE_rope36", "ACE_SpraypaintBlack", "ACE_SpraypaintBlue", "ACE_SpraypaintGreen", "ACE_SpraypaintRed", "ACE_wirecutter", "ACE_DefusalKit"];
	_availableBackpacks = ["B_patrelPack_m81"];
	_availableHeadgear = ["H_PASGT_m_dcu", "H_PASGT_m_dcu_ESS"];
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
