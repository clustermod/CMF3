#include "script_component.hpp"
/*
 * Author: Eric
 * Adds / Removes Features from the ace spectator UI
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call cmf_player_fnc_spectator
 *
 * Public: No
 */

// @TODO: Rewrite to create control inside a control group
_this spawn {

    while { true } do {
        waitUntil {!isNull findDisplay IDD_SPEC_DISPLAY};
        private _display = findDisplay IDD_SPEC_DISPLAY;

        private _ctrl = _display ctrlCreate [QGVAR(spectatorAAR), -1];

        /* Hide button if ui is hidden */
        while { !isNull findDisplay IDD_SPEC_DISPLAY } do {
            waitUntil {if (isNil "ace_spectator_uiVisible") exitWith { true }; ace_spectator_uiVisible};
            if (isNil "ace_spectator_uiVisible") exitWith {};
            _ctrl ctrlSetFade 0;
            _ctrl ctrlCommit 0.25;

            waitUntil {if (isNil "ace_spectator_uiVisible") exitWith { true }; !ace_spectator_uiVisible};
            _ctrl ctrlSetFade 1;
            _ctrl ctrlCommit 0.25;
        }
    };
};
