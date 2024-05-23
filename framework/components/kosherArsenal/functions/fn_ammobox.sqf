#include "script_component.hpp"
/*
 * Author: Eric
 * initializes an object as a ammobox
 *
 * Arguments:
 * 0: object <OBJECT>
 *
 * Return Value:
 * Success <BOOLEAN>
 *
 * Example:
 * [this] call cmf_kosherArsenal_fnc_ammobox
 *
 * Public: Yes
 */
SCRIPT(ammobox);

params ["_object"];

/* Check if ammobox already initialized on object */
if (_object getVariable [QGVAR(ammobox_initialized), false]) exitWith { false };

/* ammobox function */
private _onOpen = {
    /* Create the arsenal object and initialize ace arsenal on it */
    private _arsenal = (createGroup sideLogic) createUnit ["Logic", [0, 0, 0], [], 0, "CAN_COLLIDE"];
    [_arsenal, []] call ace_arsenal_fnc_initBox;

    /* Get player's role and loadout */
    private _role = player getVariable [QEGVAR(organization,role), "RFL"];
    private _loadout = player getVariable [QGVAR(loadout), ""];

    /* Check if the file exists and load the whitelist */
    if !(fileExists _loadout) exitWith { ERROR_1("Loadoutfile %1 does not exist!",_loadout) };
    private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

    /* Get gear from whitelist and check loadout file version */
    private _permittedGear = [];
    if (isNil "_whitelist") then {
        /* Backwards compatability with old loadoutfiles */
        _permittedGear = player getVariable ["EMF_KA_permittedGear", 0];
    } else {
        _permittedGear = (_whitelist select 1);
    };

    /* Add the allowed gear to the arsenal */
    {
        [_arsenal, _x] call ace_arsenal_fnc_addVirtualItems;
    } forEach _permittedGear;

    /* Open the arsenal */
    [_arsenal, player, false] call ace_arsenal_fnc_openBox;

    [{ !isNull findDisplay IDD_ace_arsenal }, {
        [findDisplay IDD_ace_arsenal, (findDisplay IDD_ace_arsenal) displayCtrl IDC_buttonUniform] call ace_arsenal_fnc_fillLeftPanel;
    }] call CBA_fnc_waitUntilAndExecute;

    /* Hide unwanted parts of the arsenal for ammobox */
    private _hideUI = [{
        if (isNil "ace_arsenal_currentLeftPanel") exitWith {};
        {
            if ( (ace_arsenal_currentLeftPanel isEqualTo IDC_buttonSecondaryWeapon) && (_x in [IDC_blockLeftFrame, IDC_blockLeftBackground, IDC_leftTabContent, IDC_sortLeftTab, IDC_leftSearchbar, IDC_leftSearchbarButton]) ) then {
                ((findDisplay IDD_ace_arsenal) displayCtrl _x) ctrlShow true;
            } else {
                ((findDisplay IDD_ace_arsenal) displayCtrl _x) ctrlShow false;
            }
        } forEach [
            IDC_blockLeftFrame, IDC_blockLeftBackground, IDC_leftTabContent, IDC_sortLeftTab, IDC_leftSearchbar, IDC_leftSearchbarButton, IDC_iconBackgroundPrimaryWeapon, IDC_buttonPrimaryWeapon,
            IDC_iconBackgroundHandgun, IDC_buttonHandgun, IDC_iconBackgroundHeadgear, IDC_buttonHeadgear, IDC_iconBackgroundGoggles, IDC_buttonGoggles,
            IDC_iconBackgroundNVG, IDC_buttonNVG, IDC_iconBackgroundBinoculars, IDC_buttonBinoculars, IDC_iconBackgroundMap, IDC_buttonMap, IDC_iconBackgroundGPS, IDC_buttonGPS, IDC_iconBackgroundRadio, IDC_buttonRadio,
            IDC_iconBackgroundCompass, IDC_buttonCompass, IDC_iconBackgroundWatch, IDC_buttonWatch, IDC_iconBackgroundFace, IDC_buttonFace, IDC_iconBackgroundVoice, IDC_buttonVoice, IDC_iconBackgroundInsigna, IDC_buttonInsignia,
            IDC_buttonExport, IDC_buttonImport
        ];
        
        ((findDisplay IDD_loadouts_display ) displayCtrl IDC_buttonLoad ) ctrlShow false;
    }] call CBA_fnc_addPerFrameHandler;

    /* When the arsenal is closed terminate the hiding script and delete the arsenal object */
    ["ace_arsenal_displayClosed", {
        [(_thisArgs select 0)] call CBA_fnc_removePerFrameHandler;
        deleteVehicle (_thisArgs select 1);

        /* Raise event */
        [QGVAR(onAmmoboxClose), []] call CBA_fnc_localEvent;
    }, [_hideUI, _arsenal]] call CBA_fnc_addEventHandlerArgs;

    /* Raise event */
    [QGVAR(onAmmoboxOpen), []] call CBA_fnc_localEvent;
};

/* Add addAction to open arsenal */
[_object, [LSTRING(rearm_ammobox), _onOpen, [], 6, true, false,"", "(_this getVariable ['"+QGVAR(loadout)+"', ''] != '') && { (_this distance _target) < 5 }"]] remoteExec ["addAction", 0, true];

/* Add ACE Interaction to open arsenal */
private _action = [QGVAR(rearm), LSTRING(rearm_ammobox), "", _onOpen, { _player getVariable [QGVAR(loadout), ''] != '' }] call ace_interact_menu_fnc_createAction;
[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_object setVariable [QGVAR(ammobox_initialized), true, true];

true;
