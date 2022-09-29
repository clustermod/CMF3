#include "script_component.hpp"
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
 * [] call cmf_menu_fnc_displayRolesAction
 *
 * Public: No
 */
SCRIPT(displayRolesAction);

/* Geta  list of all player roles */
private _roles = [];
{
    private _p = _x;
    if (allCurators findIf {getAssignedCuratorUnit _x == _p} == -1) then {
    	   _roles pushBack format["%2	%1", (name _p), (_p getVariable [QEGVAR(common,role), "RFL"])];
    } else {
    	   _roles pushBack format["ZEUS	%1", (name _p)];
    }
} forEach allPlayers;

/* Display the roles */
hint (_roles joinstring "\n");
