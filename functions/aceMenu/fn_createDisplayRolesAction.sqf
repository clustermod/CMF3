/*
 * Author: Eric
 * creates action to display all players roles in ace.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_aceMenu_fnc_createDisplayRolesAction
 *
 * Public: No
 */
scriptName "functions\aceMenu\fn_createDisplayRolesAction.sqf";
private["_rolesAction"];

if (isDedicated) exitWith {};

_rolesAction = ["emf_display_roles", "Show roles", "rsc\data\bug_icon.paa", {
  private _roles = [];
  {
    private _p = _x;
    if (allCurators findIf {getAssignedCuratorUnit _x == _p} == -1) then {
  	   _roles pushBack format["%2	%1", (name _p), (_p getVariable ["emf_utilities_setRole_role", "RFL"])];
    } else {
  	   _roles pushBack format["ZEUS	%1", (name _p)];
    }
  } forEach allPlayers;

  hint (_roles joinstring "\n");
}, {true}] call ace_interact_menu_fnc_createAction;

[typeof player, 1, ["ACE_SelfActions", "EMF_BUGACTIONS"], _rolesAction] call ace_interact_menu_fnc_addActionToClass;
