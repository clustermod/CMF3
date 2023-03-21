/*
 * Author: Eric
 * Transfers zeus spawned AI to server for better ai calculations and better performance for the zeus client
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_ai_fnc_transferToServer
 *
 * Public: No
 */
SCRIPT(transferToServer);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,ai,transferToServer) ) isEqualTo 1;
if !(_enabled) exitWith {};

if (!isServer) exitWith {};

/* Transfer all new AI groups to server */
["CAManBase", "init", {
  params ["_unit"];

  if (isPlayer _unit) exitWith {};

  private _group = group _unit;
  if (groupowner _group isEqualTo 2) exitWith {};

  _group setGroupOwner 2;
  LOG_1("Transfered %1 to server", groupId _group);
}, true, [], true] call CBA_fnc_addClassEventHandler;
