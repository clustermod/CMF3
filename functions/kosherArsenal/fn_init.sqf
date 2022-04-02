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
 * [["exampleLoadout"], true, false, true] call emf_kosherArsenal_fnc_init
 *
 * Public: Yes
 */
scriptName "functions\kosherArsenal\fn_init.sqf";
params[["_loadouts", nil, [[]]], ["_light", false], ["_forcePrimary", true], ["_randomPos", true]];

if (isDedicated) exitWith {};
if (isNil "_loadouts") exitWith {/* CALL EMF_DEBUG WITH ERR */};

// Wait until player respawns the first time (replace with a respawn eventhandler)
waitUntil {!alive Player};
waitUntil {alive Player};
sleep 0.1;

// Randomize player position on spawn
if (_randomPos) then {
  player setpos [((getPos player) select 0) + random[-5, 0, 5], ((getPos player) select 1) + random[-5, 0, 5], ((getPos player) select 2)];
};

// Get units loadout
private _team = player getVariable ["emf_utilities_setRole_team", 0];
private _role = player getVariable ["emf_utilities_setRole_role", "RFL"];
if (((count _loadouts) - 1) < _team) then {
  _team = (count _loadouts) - 1;
};

// Save loadout on unit
private _loadout = format["rsc\loadouts\%1.sqf", (_loadouts select _team)];
if !(fileExists _loadout) exitWith { ["ERR", format["Unable to find loadoutfile: %1", _loadout], "init", "kosherArsenal"] call EMF_DEBUG };
player setVariable ["emf_kosherArsenal_loadout", _loadout, true];


// Create arsenal
private _arsenal = "HeliHEmpty" createVehicleLocal [0,0,0];
[_arsenal, []] call ace_arsenal_fnc_initBox;

// Load arsenal whitelist
private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

// Get gear from whitelist and check loadout file version (to add backwards compatability)
private["_permittedGear"];
_permittedGear = [];
if (isNil "_whitelist") then {
    _permittedGear 	= player getVariable ["EMF_KA_permittedGear", 0];

    // remove arsenal added by old laodout format:
    {
      if (((player actionParams _x) select 0) == "Arsenal") then {
        player removeAction _x;
       }
    } forEach (actionIDs player)
} else {
    _permittedGear 	= (_whitelist select 1);

    // strip unit
    [player] call emf_utilities_fnc_stripUnit;

    // Randomize spawn loadout
    player addBackpack (selectRandom (_permittedGear select 0));
    player addVest (selectRandom (_permittedGear select 1));
    player forceAddUniform (selectRandom (_permittedGear select 2));
    player addHeadgear (selectRandom (_permittedGear select 4));
    player addWeapon (selectRandom (_permittedGear select 7));
    player linkItem "ItemMap";
    player linkItem "ItemCompass";
    player linkItem "ItemWatch";
};

// Add items to arsenal
{
  [_arsenal, _x] call ace_arsenal_fnc_addVirtualItems;
} forEach _permittedGear;

// Create light
private["_lightobject"];
_lightobject = objnull;
if (_light) then {
	_lightobject = "#lightpoint" createVehicle getPos player;
	_lightobject setPosASL getPosASL player;
	_lightobject setLightBrightness 0.2;
	_lightobject setLightAmbient [1.0, 1.0, 1.0];
	_lightobject setLightColor [1.0, 1.0, 1.0];
};

[_arsenal, player, false] call ace_arsenal_fnc_openBox;
[] spawn {
  waitUntil{!isNull (findDisplay 1127001)};
  ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
  (findDisplay 1127001) ctrlCreate ["emf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];
};

private _onClose = {
  _thisArgs params["_forcedprimary", "_arsenal", "_light", "_lightobject"];

  if (_forcedprimary && (primaryWeapon player == "") && !(player getVariable ["emf_kosherArsenal_init_cancel", false])) exitWith {
      ["<t color='#ff0000'>You are required to have a primary firearm</t>", -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
      _arsenal spawn {
        sleep 0.1;
        [_this, player, false] call ace_arsenal_fnc_openBox;
        [] spawn {
          waitUntil{!isNull (findDisplay 1127001)};
          ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
          (findDisplay 1127001) ctrlCreate ["emf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];
        };
      }
  };
  deleteVehicle _arsenal;

  // Delete light
  if (_light) then {
  	deleteVehicle _lightobject;
  };

  ["ace_arsenal_displayClosed", _thisId] call CBA_fnc_removeEventHandler;
  player setVariable ["emf_kosherArsenal_init_cancel", false, true];
};

[] spawn {
  waitUntil{(player getVariable ["emf_kosherArsenal_init_cancel", false])};
  (findDisplay 1127001) closeDisplay 1;
  [player] call emf_utilities_fnc_stripUnit;
};

["ace_arsenal_displayClosed", _onClose, [_forcePrimary, _arsenal, _light, _lightobject]] call CBA_fnc_addEventHandlerArgs;
