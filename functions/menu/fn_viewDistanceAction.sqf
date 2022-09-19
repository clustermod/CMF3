#include "script_component.hpp"
/*
 * Author: Eric
 * Open viewdistance UI
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Parameters <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_menu_fnc_viewDistanceAction
 *
 * Public: No
 */
SCRIPT(viewDistanceAction);

/* Call TAW View Distance Function */
_this call TAWVD_fnc_openMenu
