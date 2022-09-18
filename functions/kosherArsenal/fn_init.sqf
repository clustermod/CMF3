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
params[["_loadouts", nil, [[]]], ["_light", false], ["_forcePrimary", true], ["_randomPos", false]];

if (!hasInterface) exitWith {};
if (isNil "_loadouts") exitWith { ERROR_MSG("No loadoutfiles defined"); };

/* Wait until player spawns in */
waitUntil {!alive Player};
waitUntil {alive Player};
sleep 0.1;

/* Randomize player spawn position if enabled */
if (_randomPos) then {
  player setpos [((getPos player) select 0) + random[-5, 0, 5], ((getPos player) select 1) + random[-5, 0, 5], ((getPos player) select 2)];
};

/* Get the unit's loadout */
private _team = player getVariable [QEGVAR(common,team), 0];
private _role = player getVariable [QEGVAR(common,role), "RFL"];
if (((count _loadouts) - 1) < _team) then {
  _team = (count _loadouts) - 1;
};

/* Ignore the unit if role is ZEUS */
if (_role isEqualTo "ZEUS") exitWith {};

/* Verify that the loadoutfile exists and save it on the unit */
private _loadout = format["rsc\loadouts\%1.sqf", (_loadouts select _team)];
if !(FILE_EXISTS(_loadout)) exitWith { ERROR_MSG_1("Unable to find loadoutfile: %1", _loadout); };
player setVariable [QGVAR(loadout), _loadout, true];

/* Create the arsenal object and initialize ace arsenal */
private _arsenal = "HeliHEmpty" createVehicleLocal [0,0,0];
[_arsenal, []] call ace_arsenal_fnc_initBox;

/* Load the whitelist */
private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

/* Get gear from whitelist and check loadout file version */
private _permittedGear = [];
if (isNil "_whitelist") then {
    /* Backwards compatability with old loadoutfiles */
    _permittedGear 	= player getVariable ["EMF_KA_permittedGear", 0];

    /* remove arsenal added by old loadout format */
    {
      if (((player actionParams _x) select 0) == "Arsenal") then {
        player removeAction _x;
       }
    } forEach (actionIDs player)
} else {
    _permittedGear 	= (_whitelist select 1);

    /* Strip the unit */
    [player] call EFUNC(utility,stripUnit);

    /* Randomize the spawn loadout */
    player addBackpack (selectRandom (_permittedGear select 0));
    player addVest (selectRandom (_permittedGear select 1));
    player forceAddUniform (selectRandom (_permittedGear select 2));
    player addHeadgear (selectRandom (_permittedGear select 4));
    player addWeapon (selectRandom (_permittedGear select 7));
    player linkItem "ItemMap";
    player linkItem "ItemCompass";
    player linkItem "ItemWatch";
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
[] spawn {
  waitUntil{!isNull (findDisplay 1127001)};
  ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
  (findDisplay 1127001) ctrlCreate ["cmf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];

  /* Disable voices and insignias */
  {
			private _ctrl = (findDisplay 1127001) displayctrl _x;
			_ctrl ctrlEnable false;
			_ctrl ctrlSetFade 0.6;
			_ctrl ctrlCommit 0;
	} forEach [2035, 2037];
};

/* handle closing the arsenal */
private _onClose = {
  _thisArgs params["_forcedprimary", "_arsenal", "_light", "_lightobject"];

  /* if force primary is enabled and the player doesn't have a primary selected kick him back into the arsenal */
  if (_forcedprimary && (primaryWeapon player == "") && !(player getVariable [QGVAR(close), false])) exitWith {
      ["<t color='#ff0000'>You are required to have a primary firearm</t>", -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
      _arsenal spawn {
        sleep 0.1;
        [_this, player, false] call ace_arsenal_fnc_openBox;
        [] spawn {
          waitUntil{!isNull (findDisplay 1127001)};
          ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
          (findDisplay 1127001) ctrlCreate ["cmf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];
        };
      }
  };

  /* Delete arsenal object */
  deleteVehicle _arsenal;

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
[] spawn {
  waitUntil{(player getVariable [QGVAR(close), false])};
  (findDisplay 1127001) closeDisplay 1;
  [player] call EFUNC(utility,stripUnit);
};

/* Add closed eventhandler */
["ace_arsenal_displayClosed", _onClose, [_forcePrimary, _arsenal, _light, _lightobject]] call CBA_fnc_addEventHandlerArgs;

/* Raise event */
[QGVAR(onOpen), [false]] call CBA_fnc_localEvent;
