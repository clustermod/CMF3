#include "script_component.hpp"
/*
 * Author: Eric
 * Creates sub menus in the ace arsenal for medical and radio equipment
 *
 * Public: No
 */
SCRIPT(initAceSettings);

private _medicalEquipment = [
    "kat_aatKit", "kat_accuvac", "kat_X_AED", "Attachable_Helistretcher", "kat_AED", "adv_aceCPR_AED", "kat_crossPanel", "ACE_bloodIV", "kat_bloodIV_O", "kat_bloodIV_A", "kat_bloodIV_AB", "kat_bloodIV_B", "ACE_bloodIV_250", "kat_bloodIV_O_250", "kat_bloodIV_A_250", "kat_bloodIV_AB_250", "kat_bloodIV_B_250", "ACE_bloodIV_500", "kat_bloodIV_O_500", "kat_bloodIV_A_500", "kat_bloodIV_AB_500", "kat_bloodIV_B_500", "ACE_bodyBag", "usm_fielddressing",
    "KAT_Empty_bloodIV_250", "KAT_Empty_bloodIV_500", "FirstAidKit", "Medikit", "ACE_salineIV", "ACE_salineIV_250", "ACE_salineIV_500", "vtx_stretcher_item", "ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "kat_chestSeal", "ACE_epinephrine", "kat_guedel", "kat_larynx", "ACE_morphine", "ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_splint", "kat_stethoscope",
    "ACE_surgicalKit", "ACE_tourniquet", "kat_IV_16", "kat_amiodarone", "kat_atropine", "kat_IO_FAST", "kat_lidocaine", "kat_naloxone", "kat_nitroglycerin", "kat_norepinephrine", "kat_phenylephrine", "kat_TXA", "kat_Pulseoximeter", "kat_bloodIV_O_N", "kat_bloodIV_A_N", "kat_bloodIV_AB_N", "kat_bloodIV_B_N", "kat_bloodIV_O_250_N", "kat_bloodIV_A_250_N", "kat_bloodIV_AB_250_N", "kat_bloodIV_B_250_N", "kat_bloodIV_O_500_N", "kat_bloodIV_A_500_N",
    "kat_bloodIV_AB_500_N", "kat_bloodIV_B_500_N"
];

private _radioEquipment = [
    "ACRE_PRC117F", "ACRE_PRC148", "ACRE_PRC152", "ACRE_PRC343", "ACRE_PRC77", "ACRE_SEM52SL", "ACRE_SEM70", "ACRE_VHF30108SPIKE", "ACRE_VHF30108", "ACRE_VHF30108MAST", "ACRE_BF888S"
];

/* Create medical submenu */
[_medicalEquipment, "Medical", "\z\ace\addons\medical_gui\data\categories\medication.paa", 0] call ace_arsenal_fnc_addRightPanelButton;

/* Create radio submenu */
[_radioEquipment, "Radios", "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa", 1] call ace_arsenal_fnc_addRightPanelButton;

/* Raise event */
[QGVAR(onAddedAceSettings), [[0, "Medical", _medicalEquipment], [1, "Radios", _radioEquipment]]] call CBA_fnc_localEvent;
