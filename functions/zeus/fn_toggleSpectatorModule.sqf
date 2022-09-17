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
 * [] call emf_zeus_fnc_toggleSpectatorModule
 *
 * Public: No
 */

["EMF", "Toggle Spectator", {
    private _entity = _this select 1;

    if (_entity != objNull) then {
        if (isPlayer _entity) then {
            [[], {
                private _curSpectators = [] call ace_spectator_fnc_players;
                [!(player in _curSpectators)] call ace_spectator_fnc_setSpectator;
            }] remoteExec ["call", _entity];
            ["Toggled spectator"] call zen_common_fnc_showMessage;
        } else {
            ["Selected entity is not a player"] call zen_common_fnc_showMessage;
        };
    } else {
        ["No player selected"] call zen_common_fnc_showMessage;
    };

}, "rsc\data\icon_module_spectate_ca.paa"] call zen_custom_modules_fnc_register;
