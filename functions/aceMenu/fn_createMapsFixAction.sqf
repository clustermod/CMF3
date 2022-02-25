/*
 * Author: Eric
 * Creates the fix map action in ace
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_aceMenu_fnc_createMapsFixAction
 *
 * Public: No
 */
scriptName "functions\aceMenu\fn_createMapsFixAction.sqf";
private["_fixAction"];

if (isDedicated) exitWith {};

_fixAction = ["emf_fix_map", "Fix map", "rsc\data\bug_icon.paa", {
  false call RR_mapStuff_fnc_mapEH;
  {detach _x; deleteVehicle _x} forEach attachedObjects player;
}, {true}] call ace_interact_menu_fnc_createAction;

[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _fixAction] call ace_interact_menu_fnc_addActionToClass;
