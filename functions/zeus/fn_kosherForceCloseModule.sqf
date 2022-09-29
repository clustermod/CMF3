/*
 * Author: Eric
 * Creates module that force closes kosher arsenal for supplied unit
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_zeus_fnc_kosherForceCloseModule
 *
 * Public: No
 */
scriptName "functions\zeus\fn_kosherForceCloseModule.sqf";

private _dialogFunction = {
  if (isNull (_this select 1)) exitWith {["Must select a unit"] call zen_common_fnc_showMessage};
  if !((_this select 1) isKindOf "Man") exitWith {["Selected object must be a unit"] call zen_common_fnc_showMessage};
  if !(isPlayer (_this select 1)) exitWith {["Selected unit must be player"] call zen_common_fnc_showMessage};

  [(_this select 1)] call emf_kosherArsenal_fnc_forceClose;
  ["Closed units arsenal"] call zen_common_fnc_showMessage;
};

["EMF", "Force close kosher arsenal", _dialogFunction, ""] call zen_custom_modules_fnc_register;
