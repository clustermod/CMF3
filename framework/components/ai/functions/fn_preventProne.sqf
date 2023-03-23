#include "script_component.hpp"
/*
 * Author: Eric
 * Prevents AI 'from going prone
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_ai_fnc_preventProne
 *
 * Public: No
 */
SCRIPT(preventProne);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,ai,preventProne) ) isEqualTo 1;
if !(_enabled) exitWith {};

/* preventProne on AI units */
["CAManBase", "init", {
  params ["_unit"];

  if (missionNamespace getVariable [QEGVAR(utility,preventProne_disable), false]) exitWith {};
  if (_unit getVariable [QEGVAR(utility,preventProne_disable), false]) exitWith {};
  if (isPlayer _unit) exitWith {};

  [_unit] call EFUNC(utility,preventProne);
  LOG_1("Enabled preventProne for %1", _unit);
}, true, [], true] call CBA_fnc_addClassEventHandler;