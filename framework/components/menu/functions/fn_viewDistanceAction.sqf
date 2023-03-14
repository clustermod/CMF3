#include "script_component.hpp"
/*
 * Author: Eric
 * Open viewdistance UI
 *
 * Arguments:
 * None
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

/* Call viewdistance open */
_this call EFUNC(viewdistance,openDialog);
