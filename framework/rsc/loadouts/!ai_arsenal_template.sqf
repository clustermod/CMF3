#pragma sls disable VV-001
/*
 * Author: [Author]
 * [Description]
 *
 * [Modpack Version]
 */

/* Get the unit's role */
params ["_role"];
private ["_availableUniforms", "_availableWeapons", "_availableMagazines", "_availableVests", "_availableItems", "_availableBackpacks", "_availableHeadgear", "_availableFacewear", "_availableAttachments", "_availableGrenades"];

/* Default gear */
private _defItems = ["kat_guedel", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch"];
private _defWeapons = [];
private _defAttachments = [];
private _defMagazines = [];
private _defGrenades = [];
private _defUniforms = [];
private _defVests = [];
private _defBackpacks = [];
private _defHeadgear = [];
private _defFacewear = [];

/* Rifleman */
if (_role in ["RFL"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Squad Leader */
if (_role in ["SL"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Medic */
if (_role in ["MED"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = ["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED", "kat_aatKit"];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Machinegunner */
if (_role in ["MG"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Anti-Tank */
if (_role in ["AT"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Engineer */
if (_role in ["ENG"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Marksman */
if (_role in ["MAR"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Crewman */
if (_role in ["CRW"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Rotary Pilot */
if (_role in ["RPIL"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
    _availableHeadgear = [];
    _availableFacewear = [];
};

/* Fixed-Wing Pilot */
if (_role in ["WPIL"]) then {
    _availableUniforms = [];
    _availableWeapons = [];
    _availableAttachments = [];
    _availableMagazines = [];
    _availableVests = [];
    _availableItems = [];
    _availableGrenades = [];
    _availableBackpacks = [];
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
