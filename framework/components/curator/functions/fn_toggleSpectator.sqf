#include "script_component.hpp"
/*
 * Author: Eric
 * Toggles spectator for unit
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_zeus_fnc_toggleSpectator
 *
 * Public: No
 */
SCRIPT(toggleSpectator);

private _entity = _this select 1;

if (_entity != objNull) then {
    if (isPlayer _entity) then {
        [[], {
            private _curSpectators = call ace_spectator_fnc_players;
            [!(player in _curSpectators)] call ace_spectator_fnc_setSpectator;
        }] remoteExec ["call", _entity];
        [LSTRING(toggle_spectator_success_message)] call zen_common_fnc_showMessage;
    } else {
        [LSTRING(player_requirement_message)] call zen_common_fnc_showMessage;
    };
} else {
    [LSTRING(unitObject_requirement_message)] call zen_common_fnc_showMessage;
};
