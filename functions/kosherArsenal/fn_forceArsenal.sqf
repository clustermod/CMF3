#include "script_component.hpp"
/*
 * Author: Eric
 * Force opens kosher arsenal on a unit
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: forcePrimary <BOOL> (Default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, true] call cmf_kosherArsenal_fnc_forceArsenal
 *
 * Public: Yes
 */
SCRIPT(forceArsenal);
params["_unit", ["_forcePrimary", true]];

/* Call where unit is local */
{
    /* Get unit loadout */
    private _loadout = player getVariable [QGVAR(loadout), ""];
    private _role = player getVariable [QEGVAR(common,role), "RFL"];

    /* Create arsenal object and initilize ace arsenal */
    private _arsenal = "HeliHEmpty" createVehicleLocal [0,0,0];
    [_arsenal, []] call ace_arsenal_fnc_initBox;

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

    /* Create the force close button in the arsenal */
    [] spawn {
        waitUntil{!isNull (findDisplay 1127001)};
        ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
        (findDisplay 1127001) ctrlCreate ["cmf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];
    };

    /* handle closing the arsenal */
    private _onClose = {
        _thisArgs params["_forcedprimary", "_arsenal"];

        /* if force primary is enabled and the player doesn't have a primary selected kick him back into the arsenal */
        if (_forcedprimary && (primaryWeapon player == "") && !(player getVariable [QGVAR(close), false])) exitWith {
            ["<t color='#ff0000'>You are required to have a primary firearm</t>", -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
            _arsenal spawn {
                sleep 0.1;
                [_this, player, false] call ace_arsenal_fnc_openBox;
                [] spawn {
                    waitUntil{!isNull (findDisplay 1127001)};
                    ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
                    (findDisplay 1127001) ctrlCreate ["emf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];
                };
            };
        };

        /* Delete the arsenal object */
        deleteVehicle _arsenal;

        /* Remove the closed eventHandler */
        ["ace_arsenal_displayClosed", _thisId] call CBA_fnc_removeEventHandler;
        player setVariable [QGVAR(close), false, true];

        /* Raise event */
    	[QGVAR(onClose), [(player getVariable [QGVAR(close), false])]] call CBA_fnc_localEvent;
    };

    /* Add closed eventhandler */
    ["ace_arsenal_displayClosed", _onClose, [_forcePrimary, _arsenal]] call CBA_fnc_addEventHandlerArgs;

    /* Raise event */
	[QGVAR(onOpen), [true]] call CBA_fnc_localEvent;
} remoteExec ["call", _unit, true];
