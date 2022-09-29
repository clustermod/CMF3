/* Get the unit's role */
private _condition = player getVariable ["cmf_common_role", "RFL"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["ACRE_BF888S", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"];
private _defWeapons = ["rhsusf_weap_m1911a1"];
private _defAttachments = [];
private _defMagazines = ["rhsusf_mag_7x45acp_MHP"];
private _defGrenades = ["Chemlight_blue", "Chemlight_green", "Chemlight_red", "rhs_mag_m18_green", "rhs_mag_m18_purple", "rhs_mag_m18_red", "rhs_mag_an_m8hc", "rhs_mag_m67"];
private _defUniforms = ["U_Simc_bdu_raid_trop", "U_simc_bdu_raid", "U_Simc_bdu_raid_knee_trop", "U_Simc_bdu_raid_knee", "U_Simc_bdu_raid_knee_nomex", "U_Simc_bdu_raid_knee_nomex_trop"];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = ["H_Simc_protec_half_nvo", "H_Simc_protec_hs_nvo", "H_Simc_protec_hs_nvo_ir", "H_Simc_protec_hs_nvo_ir_swdg", "H_Simc_protec_hs_nvo_ir_swdg_low", "H_Simc_protec_hs_nvo_swdg", "H_Simc_protec_hs_nvo_swdg_low", "H_Simc_protec_half_nvo_ir_swdg_low", "H_Simc_protec_half_nvo_ir_swdg", "H_Simc_protec_half_nvo_swdg", "H_Simc_protec_half_nvo_swdg_low", "H_Simc_protec_full_nvo", "H_Simc_protec_full_nvo_ir", "H_Simc_protec_full_nvo_ir_swdg", "H_Simc_protec_full_nvo_ir_swdg_low", "H_Simc_protec_full_nvo_swdg", "H_Simc_protec_full_nvo_swdg_low"];
private _defFacewear = ["CUP_G_Oakleys_Clr", "CUP_G_Oakleys_Drk", "CUP_G_Oakleys_Embr"];

/* Rifleman */
if (_condition in ["RFL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Colt727", "rhs_weap_m14_rail_fiberglass"];
	_availableAttachments = ["cup_optic_aimpoint_5000", "tier1_m600v_black"];
	_availableMagazines = ["rhsusf_20Rnd_762x51_m993_Mag", "rhs_mag_30Rnd_556x45_Mk318_Stanag"];
	_availableVests = ["V_Simc_vest_fauf_rig_1", "V_Simc_vest_fauf_rig_3", "V_Simc_vest_fauf_alice", "V_Simc_vest_fauf_alice_45"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_AssaultPack_Black"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Squad Leader and Fireteam Leader */
if (_condition in ["SL", "FTL", "PL"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Colt727", "rhs_weap_m14_rail_fiberglass"];
	_availableAttachments = ["cup_optic_aimpoint_5000", "tier1_m600v_black"];
	_availableMagazines = ["rhsusf_20Rnd_762x51_m993_Mag", "rhs_mag_30Rnd_556x45_Mk318_Stanag"];
	_availableVests = ["V_Simc_vest_fauf_rig_1", "V_Simc_vest_fauf_rig_3", "V_Simc_vest_fauf_alice", "V_Simc_vest_fauf_alice_45"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_AssaultPack_Black"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Medic */
if (_condition in ["MED"]) then {
	player setVariable ["ace_medical_medicclass", 2, true];
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Colt727", "rhs_weap_m14_rail_fiberglass"];
	_availableAttachments = ["cup_optic_aimpoint_5000", "tier1_m600v_black"];
	_availableMagazines = ["rhsusf_20Rnd_762x51_m993_Mag", "rhs_mag_30Rnd_556x45_Mk318_Stanag"];
	_availableVests = ["V_Simc_vest_fauf_rig_1", "V_Simc_vest_fauf_rig_3", "V_Simc_vest_fauf_alice", "V_Simc_vest_fauf_alice_45"];
	_availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED"];
	_availableGrenades = [];
	_availableBackpacks = ["UK3CB_B_US_Medic_Backpack"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Autorifleman */
if (_condition in ["AR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_lmg_M249_E2"];
	_availableAttachments = [];
	_availableMagazines = ["CUP_200Rnd_TE4_Red_Tracer_556x45_M249"];
	_availableVests = ["V_Simc_vest_fauf_alice_249"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_AssaultPack_Black"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Assistant Autorifleman */
if (_condition in ["AAR"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Colt727", "rhs_weap_m14_rail_fiberglass"];
	_availableAttachments = ["cup_optic_aimpoint_5000", "tier1_m600v_black"];
	_availableMagazines = ["rhsusf_20Rnd_762x51_m993_Mag", "rhs_mag_30Rnd_556x45_Mk318_Stanag"];
	_availableVests = ["V_Simc_vest_fauf_rig_1", "V_Simc_vest_fauf_rig_3", "V_Simc_vest_fauf_alice", "V_Simc_vest_fauf_alice_45"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["B_simc_pack_alice_flak_frame_1_alt"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Anti-Tank, Light */
if (_condition in ["LAT"]) then {
	_availableUniforms = [];
	_availableWeapons = ["CUP_arifle_Colt727", "rhs_weap_m14_rail_fiberglass", "CUP_launch_M72A6"];
	_availableAttachments = ["cup_optic_aimpoint_5000", "tier1_m600v_black"];
	_availableMagazines = ["rhsusf_20Rnd_762x51_m993_Mag", "rhs_mag_30Rnd_556x45_Mk318_Stanag"];
	_availableVests = ["V_Simc_vest_fauf_rig_1", "V_Simc_vest_fauf_rig_3", "V_Simc_vest_fauf_alice", "V_Simc_vest_fauf_alice_45"];
	_availableItems = [];
	_availableGrenades = [];
	_availableBackpacks = ["CUP_B_AssaultPack_Black"];
	_availableHeadgear = [];
	_availableFacewear = [];
};

/* Loadout array that's passed back to kosherArsenal */
[
	/* Loadoutfile version */
	"1.2",

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
