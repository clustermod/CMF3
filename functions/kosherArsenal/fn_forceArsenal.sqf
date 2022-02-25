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
 * [this, true] call emf_kosherArsenal_fnc_forceArsenal
 *
 * Public: Yes
 */
scriptName "functions\kosherArsenal\fn_init.sqf";
params["_unit", ["_forcePrimary", true]];

{
  // Save loadout on unit
  private _loadout = player getVariable ["emf_kosherArsenal_loadout", ""];
  private _role = player getVariable ["emf_utilities_setRole_role", "RFL"];

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
    } else {
      _permittedGear 	= (_whitelist select 1);
    };

    // Add items to arsenal
    {
      [_arsenal, _x] call ace_arsenal_fnc_addVirtualItems;
      } forEach _permittedGear;

      [_arsenal, player, false] call ace_arsenal_fnc_openBox;
      [] spawn {
        waitUntil{!isNull (findDisplay 1127001)};
        ((findDisplay 1127001) displayCtrl 1005) ctrlShow false;
        (findDisplay 1127001) ctrlCreate ["emf_arsenalForceCloseButton", 2055, ((findDisplay 1127001) displayCtrl 10)];
      };

      private _onClose = {
        _thisArgs params["_forcedprimary", "_arsenal"];

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

        ["ace_arsenal_displayClosed", _thisId] call CBA_fnc_removeEventHandler;
        player setVariable ["emf_kosherArsenal_init_cancel", false, true];
      };

      ["ace_arsenal_displayClosed", _onClose, [_forcePrimary, _arsenal]] call CBA_fnc_addEventHandlerArgs;

} remoteExec ["call", _unit, true];
