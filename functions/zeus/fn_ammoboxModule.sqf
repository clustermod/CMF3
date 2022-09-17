#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a zeus module to set object as an ammo box
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_zeus_fnc_ammoboxModule
 *
 * Public: No
 */

scriptName "functions\zeus\fn_ammoboxModule.sqf";

private _dialogFunction = {
  if (isNull (_this select 1)) exitWith {["Must select an object"] call zen_common_fnc_showMessage};

  private _result = [(_this select 1)] call emf_kosherArsenal_fnc_ammobox;
  if (_result) then {
    ["Added kosher ammobox"] call zen_common_fnc_showMessage;
  } else {
    ["Failed to add kosher ammobox"] call zen_common_fnc_showMessage;
  };
};

["EMF", "Add kosher ammobox", _dialogFunction, "rsc\data\icon_module_ammobox_ca.paa"] call zen_custom_modules_fnc_register;
