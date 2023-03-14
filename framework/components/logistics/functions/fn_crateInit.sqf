#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes supply crates
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_logistics_fnc_crateInit
 *
 * Public: No
 */

/* Add ACE interaction menu actions */
["ReammoBox_F", "init", {
    params ["_crate"];

    /* hide original ace rename action */
    _crate setVariable ["ace_cargo_noRename", 1];
}, true, [], true] call CBA_fnc_addClassEventHandler;
