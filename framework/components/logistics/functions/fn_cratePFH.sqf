#include "script_component.hpp"
/*
 * Author: Eric
 * Shows the crate name when looking at it
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_logistics_fnc_cratePFH
 *
 * Public: No
 */

[{
    /* Get object player is looking at */
    private _newObject = cursorObject;

    /* Get previously looked at object */
    private _oldObject = missionNamespace getVariable [QGVAR(observedCrate), [objNull, scriptNull]];

    /* If HUD is disabled exit */
    if !(missionNameSpace getVariable [QEGVAR(menu,hud_show), true]) exitWith {
        terminate (_oldObject select 1);
        (["cmf_logistics_name"] call BIS_fnc_rscLayer) cutText ["","plain"];
        missionNamespace setVariable [QGVAR(observedCrate), [objNull, scriptNull], false];
    };

    /* Exit if player is looking at same object */
    if (_newObject isEqualTo (_oldObject select 0)) exitWith {};

    /* Hide previous text */
    if (player distance _newObject > 5) then {
        terminate (_oldObject select 1);
        (["cmf_logistics_name"] call BIS_fnc_rscLayer) cutText ["","plain"];
    };

    /* Show new text if there is any */
    private _name = _newObject getVariable ["ace_cargo_customName", nil];
    if (!isNil "_name") then {
        private _handle = [format ["<t font='PuristaMedium' size='0.6'>%1</t>", _name], -1, -1, 9999, 0.5, 0, (["cmf_logistics_name"] call BIS_fnc_rscLayer)] spawn BIS_fnc_dynamicText;
        missionNamespace setVariable [QGVAR(observedCrate), [_newObject, _handle], false];
    } else {
        missionNamespace setVariable [QGVAR(observedCrate), [objNull, scriptNull], false];
    };
}] call CBA_fnc_addPerFrameHandler;
