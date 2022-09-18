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
params["_object"];

/* Check if ammobox already initialized on object */
if (_object getVariable [QGVAR(ammobox_initialized), false]) exitWith { false };

/* ammobox function */
private _onOpen = {
    /* Create the arsenal object and initialize ace arsenal on it */
    private _arsenal = "HeliHEmpty" createVehicleLocal [0,0,0];
    [_arsenal, []] call ace_arsenal_fnc_initBox;

    /* Get player's role and loadout */
    private _role = player getVariable [QEGVAR(common,role), "RFL"];
    private _loadout = player getVariable [QGVAR(loadout), ""];

    /* Check if the file exists and load the whitelist */
    if !(FILE_EXISTS(_loadout)) exitWith { ERROR_1("Loadoutfile %1 does not exist!",_loadout) };
    private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

    /* Get gear from whitelist and check loadout file version */
    private _permittedGear = [];
    if (isNil "_whitelist") then {
        /* Backwards compatability with old loadoutfiles */
        _permittedGear 	= player getVariable ["EMF_KA_permittedGear", 0];
    } else {
        _permittedGear 	= (_whitelist select 1);
    };

    /* Add the allowed gear to the arsenal */
    {
        [_arsenal, _x] call ace_arsenal_fnc_addVirtualItems;
    } forEach _permittedGear;

    /* Open the arsenal */
    [_arsenal, player, false] call ace_arsenal_fnc_openBox;

    waitUntil{!isNull findDisplay 1127001};
    ctrlActivate ((findDisplay 1127001) displayCtrl 2010);

    /* Hide unwanted parts of the arsenal for ammobox */
    private _hideUI = [] spawn {
        while {true} do {
            {
                ((findDisplay 1127001) displayCtrl _x) ctrlShow false;
            } forEach [3, 4, 13, 16, 18, 41, 51, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 1003, 1004, 1005];
            sleep 0.1;
        };
    };

    /* When the arsenal is closed terminate the hiding script and delete the arsenal object */
    ["ace_arsenal_displayClosed", {
        terminate (_thisArgs select 0);
        deleteVehicle (_thisArgs select 1);

        /* Raise event */
    	[QGVAR(onAmmoboxClose), []] call CBA_fnc_localEvent;
    }, [_hideUI, _arsenal]] call CBA_fnc_addEventHandlerArgs;

    /* Raise event */
	[QGVAR(onAmmoboxOpen), []] call CBA_fnc_localEvent;
};

/* Add addAction to open arsenal */
[_object, ["Rearm at arsenal", _onOpen, [], 6, true, false,"", "_this getVariable [QQGVAR(loadout), ''] != ''"]] remoteExec ["addAction", 0, true];
_object setVariable [QGVAR(ammobox_initialized), true, true];

true;
