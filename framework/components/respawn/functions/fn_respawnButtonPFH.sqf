#include "script_component.hpp"
/*
 * Author: Eric
 * Disables respawn button when menu is opened
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_respawn_fnc_respawnButtonPFH
 * 
 * Public: No
 */
disableSerialization;

if (isNull (findDisplay 49)) exitWith {};
if (!ctrlShown ((findDisplay 49) displayCtrl 1010)) exitWith {};

if (ctrlShown ((findDisplay 49) displayCtrl 1010) && isNull (uiNamespace getVariable [QGVAR(ctrlCounter), controlNull])) then {
    private _ctrl = (findDisplay 49) ctrlCreate ["RscText", -1];
    _ctrl ctrlSetTextColor [1, 0.3, 0.3, 1];
    _ctrl ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

    _ctrl ctrlSetPosition [
        ( safeZoneX + ( safeZoneWAbs / 2 )) - ( 0.5 / 2 ),
        (( safeZoneY + safeZoneH ) - 0.1) - 0.1,
        0.5,
        0.1
    ];

    _ctrl ctrlShow false;
    _ctrl ctrlCommit 0;

    uiNamespace setVariable [QGVAR(ctrlCounter), _ctrl];
};

((findDisplay 49) displayCtrl 1010) ctrlEnable GVAR(respawnState);