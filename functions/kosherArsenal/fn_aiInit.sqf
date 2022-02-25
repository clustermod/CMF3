/*
 * Author: Eric
 * inits some functions for kosherAI
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_kosherArsenal_fnc_aiInit
 *
 * Public: No
 */
scriptName "functions\kosherArsenal\fn_aiInit.sqf";

emf_fnc_setAIType = {
  params["_unit"];
  // Leader
  if ((leader _unit) isEqualTo _unit) exitWith {_unit setVariable["emf_kosherai_role", "SL"]};
  // Medic
  if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "attendant") isEqualTo 1) exitWith {_unit setVariable["emf_kosherai_role", "MED"]; "MED"};
  // Engineer
  if (getNumber (configFile >> "CfgVehicles" >> typeOf _unit >> "engineer") isEqualTo 1) exitWith {_unit setVariable["emf_kosherai_role", "ENG"]; "ENG"};
  // Anti tank
  if ((secondaryWeapon _unit) != "") exitWith {_unit setVariable["emf_kosherai_role", "AT"]; "AT"};
  // Machinegunner
  if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "MachineGun") exitWith {_unit setVariable["emf_kosherai_role", "MG"]; "MG"};
  // Sniper
  if (((primaryweapon _unit) call BIS_fnc_itemtype) select 1 == "SniperRifle") exitWith {_unit setVariable["emf_kosherai_role", "MAR"]; "MAR"};
  // Rifleman
  _unit setVariable["emf_kosherai_role", "RFL"]; "RFL"
};

[] spawn {
  waitUntil{(!isnull (getAssignedCuratorLogic player))};
  (getAssignedCuratorLogic player) addEventHandler ["CuratorGroupPlaced", {
    private["_group", "_side", "_loadoutFile"];
    _group = _this select 1;
    systemChat "group placed";
    if (missionNamespace getVariable ["emf_kosherai_enabled", false]) then {
      _side = missionNamespace getVariable "emf_kosherai_side";
      _loadoutFile = missionNamespace getVariable "emf_kosherai_loadoutFile";
      {
        if (side _x isEqualTo _side) then {
          private _role = [_x] call emf_fnc_setAIType;
          [_role, _x] execVM format["rsc\aiLoadouts\%1.sqf", _loadoutFile];
        };
      } forEach units _group;
    };
  }];
};
