#include "script_component.hpp"
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
 * call cmf_zeus_fnc_forceCloseArsenal
 *
 * Public: No
 */
SCRIPT(forceCloseArsenal);

if (isNull (_this select 1)) exitWith { [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage };
if !((_this select 1) isKindOf "Man") exitWith { [LSTRING(unit_requirement_message)] call zen_common_fnc_showMessage };
if !(isPlayer (_this select 1)) exitWith { [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage };

[(_this select 1)] call EFUNC(kosherArsenal,forceClose);
[LSTRING(forceclose_kosherArsenal_message)] call zen_common_fnc_showMessage;
