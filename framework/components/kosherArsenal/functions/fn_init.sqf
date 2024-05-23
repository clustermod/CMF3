#include "script_component.hpp"
/*
 * Author: Eric
 * Loads kosherArsenal
 *
 * Arguments:
 * 0: loadouts <ARRAY>
 * 1: light <BOOL> (Default: false)
 * 2: forcePrimary <BOOL> (Default: true)
 * 3: randomPos <BOOL> (Default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [["exampleLoadout"], true, false, true] call cmf_kosherArsenal_fnc_init
 *
 * Public: Yes
 */
SCRIPT(init);

if (!hasInterface) exitWith {};

[{ cmf_player getVariable [QEGVAR(main,player_loaded), false] && { alive cmf_player } }, {
    [{
        params[["_loadouts", nil, [[]]], /* ["_light", false], */ ["_forcePrimary", false], ["_randomPos", false]];

        if (isNil "_loadouts") exitWith { ERROR_MSG("No loadoutfiles defined"); };

        /* Keep a list of used loadouts */
        { GVAR(loadouts) pushBackUnique _x } forEach _loadouts;

        /* Check if light should be attached */
        _light = ((getLightingAt cmf_player) select 1 < 30); // @TODO: Fine tune this value

        /* Randomize player spawn position if enabled */
        if (_randomPos) then {
            player setpos [((getPos player) select 0) + random[-5, 0, 5], ((getPos player) select 1) + random[-5, 0, 5], ((getPos player) select 2)];
        };

        /* Get the unit's loadout */
        private _team = player getVariable [QEGVAR(organization,team), 0];
        private _role = player getVariable [QEGVAR(organization,role), "RFL"];
        if (((count _loadouts) - 1) < _team) then {
            _team = (count _loadouts) - 1;
        };

        /* Ignore the unit if role is ZEUS */
        if (_role isEqualTo "ZEUS") exitWith {};

        /* Verify that the loadoutfile exists and save it on the unit */
        private _loadout = format["rsc\loadouts\%1.sqf", (_loadouts select _team)];
        if !(FILE_EXISTS(_loadout)) exitWith { ERROR_MSG_1("Unable to find loadoutfile: %1", _loadout); };
        player setVariable [QGVAR(loadout), _loadout, true];

        /* If player is Re-Jip in same role exit */
        private _reJip = false;
        private _disconUnits = missionNameSpace getVariable [QEGVAR(main,disconUnits), createHashMap];
        if (!isNil { _disconUnits get (getPlayerUID player) }) then { _reJip = true; };

        if (_reJip && { ESETTING(gameplay,safestart) && { missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false] } }) exitWith { };

        /* Create the arsenal object and initialize ace arsenal */
        private _arsenal = (createGroup sideLogic) createUnit ["Logic", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        systemChat str _arsenal;
        [_arsenal, []] call ace_arsenal_fnc_initBox;

        /* Load the whitelist */
        private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

        /* Get gear from whitelist and check loadout file version */
        private _permittedGear = [];
        if (isNil "_whitelist") then {
            /* Backwards compatability with old loadoutfiles */
            _permittedGear = player getVariable ["EMF_KA_permittedGear", 0];

            /* remove arsenal added by old loadout format */
            {
                if (((player actionParams _x) select 0) isEqualTo "Arsenal") then {
                    player removeAction _x;
                }
            } forEach (actionIDs player)
        } else {
            _permittedGear = (_whitelist select 1);

            /* Strip the unit */
            [player] call EFUNC(common,stripUnit);

            /* Randomize the spawn loadout */
            player addBackpack (selectRandom (_permittedGear select 0));
            player addVest (selectRandom (_permittedGear select 1));
            player forceAddUniform (selectRandom (_permittedGear select 2));
            player addHeadgear (selectRandom (_permittedGear select 4));
            player addWeapon (selectRandom (_permittedGear select 7));

            if ("ITEMMAP" in (((_whitelist select 1) select 8) apply { toUpper _x })) then { player linkItem "ItemMap" };
            if ("ITEMCOMPASS" in (((_whitelist select 1) select 8) apply { toUpper _x })) then { player linkItem "ItemCompass" };
            if ("ITEMWATCH" in (((_whitelist select 1) select 8) apply { toUpper _x })) then { player linkItem "ItemWatch" };
        };

        /* Add the allowed gear to the arsenal */
        {
            [_arsenal, _x] call ace_arsenal_fnc_addVirtualItems;
        } forEach _permittedGear;

        /* Create a light if enabled */
        private _lightobject = objnull;
        if (_light) then {
            _lightobject = "#lightpoint" createVehicle getPos player;
            _lightobject setPosASL getPosASL player;
            _lightobject setLightBrightness 0.2;
            _lightobject setLightAmbient [1.0, 1.0, 1.0];
            _lightobject setLightColor [1.0, 1.0, 1.0];
        };

        /* Open the arsenal */
        [_arsenal, player, false] call ace_arsenal_fnc_openBox;

        /* add the force close button and disable voices and insignias */
        [{ !isNull findDisplay IDD_ace_arsenal }, {
            ((findDisplay IDD_ace_arsenal) displayCtrl IDC_buttonImport) ctrlShow false;
            (findDisplay IDD_ace_arsenal) ctrlCreate [QGVAR(forceClose), 2055, ((findDisplay IDD_ace_arsenal) displayCtrl IDC_menuBar)];

            /* Disable voices and insignias */
            {
                private _ctrl = (findDisplay IDD_ace_arsenal) displayctrl _x;
                _ctrl ctrlEnable false;
                _ctrl ctrlSetFade 0.6;
                _ctrl ctrlCommit 0;
            } forEach [2035, 2037];
        }] call CBA_fnc_waitUntilAndExecute;

        /* handle closing the arsenal */
        private _onClose = {
            _thisArgs params["_forcedprimary", "_arsenal", "_light", "_lightobject"];

            /* if force primary is enabled and the player doesn't have a primary selected kick him back into the arsenal */
            if (_forcedprimary && { primaryWeapon player isEqualTo "" && { !(player getVariable [QGVAR(close), false]) } }) exitWith {
                ["<t color='#ff0000'>"+LSTRING(required_primary)+"</t>", -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
                [{
                    [_this, cmf_player, false] call ace_arsenal_fnc_openBox;
                }, _arsenal, 0.1] call CBA_fnc_waitAndExecute;

                [{ !isNull findDisplay IDD_ace_arsenal }, {
                    ((findDisplay IDD_ace_arsenal) displayCtrl IDC_buttonImport) ctrlShow false;
                    (findDisplay IDD_ace_arsenal) ctrlCreate [QGVAR(forceClose), 2055, ((findDisplay IDD_ace_arsenal) displayCtrl IDC_menuBar)];
                }, _arsenal, 0.1] call CBA_fnc_waitUntilAndExecute;
            };

            /* Delete arsenal object */
            //deleteVehicle _arsenal;

            /* Delete light if enabled */
            if (_light) then {
                deleteVehicle _lightobject;
            };

            player setVariable [QGVAR(close), false, true];

            /* Raise event */
            [QGVAR(onClose), [(player getVariable [QGVAR(close), false])]] call CBA_fnc_localEvent;

            ["ace_arsenal_displayClosed", _thisId] call CBA_fnc_removeEventHandler;
        };

        /* Handle force closing the arsenal */
        [{
            player getVariable [QGVAR(close), false]
        }, {
            (findDisplay IDD_ace_arsenal) closeDisplay 1;
            [player] call EFUNC(common,stripUnit);
        }] call CBA_fnc_waitUntilAndExecute;

        /* Add closed eventhandler */
        ["ace_arsenal_displayClosed", _onClose, [_forcePrimary, _arsenal, _light, _lightobject]] call CBA_fnc_addEventHandlerArgs;

        /* Raise event */
        [QGVAR(onOpen), [false]] call CBA_fnc_localEvent;

    }, _this, 0.1] call CBA_fnc_waitAndExecute;
}, _this] call CBA_fnc_waitUntilAndExecute;