/*
 * Author: Eric
 * Creates a zeus module to force kosher arsenal on a player
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_zeus_fnc_forceArsenalModule
 *
 * Public: No
 */

scriptName "functions\zeus\fn_forceArsenalModule.sqf";

private _dialogFunction = {
  if (isNull (_this select 1)) exitWith {["Must select a unit"] call zen_common_fnc_showMessage};
  if !((_this select 1) isKindOf "Man") exitWith {["Selected object must be a unit"] call zen_common_fnc_showMessage};
  if !(isPlayer (_this select 1)) exitWith {["Selected unit must be player"] call zen_common_fnc_showMessage};

  [(_this select 1)] call emf_kosherArsenal_fnc_forceArsenal;
  ["Forced open kosher arsenal on unit"] call zen_common_fnc_showMessage;
};

["EMF", "Force kosher arsenal", _dialogFunction, ""] call zen_custom_modules_fnc_register;
