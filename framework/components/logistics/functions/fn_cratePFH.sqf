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
 * call cmf_logistics_fnc_cratePFH
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
        ([QGVAR(name)] call BIS_fnc_rscLayer) cutText ["","plain"];
        GVAR(observedCrate) = [objNull, scriptNull];
    };

    /* Exit if player is looking at same object */
    if (_newObject isEqualTo (_oldObject select 0)) exitWith {
        if ((_oldObject select 0) distance cmf_player > 5 || count crew (_oldObject select 0) > 0) then {
            terminate (_oldObject select 1);
            ([QGVAR(name)] call BIS_fnc_rscLayer) cutText ["","plain"];
            GVAR(observedCrate) = [objNull, scriptNull];
        };
    };

    /* Hide previous text */
    if (cmf_player distance _newObject > 5) then {
        terminate (_oldObject select 1);
        ([QGVAR(name)] call BIS_fnc_rscLayer) cutText ["","plain"];
    };

    /* Show new text if there is any */
    private _name = _newObject getVariable ["ace_cargo_customName", nil];
    if (isNil "_name") then {
        _name = _newObject getVariable [QGVAR(objectName), nil];
    };

    if (!isNil "_name" && { count crew (_oldObject select 0) isEqualTo 0 }) then {
        private _handle = [format ["<t font='PuristaMedium' size='0.6'>%1</t>", _name], -1, -1, 9999, 0.5, 0, ([QGVAR(name)] call BIS_fnc_rscLayer)] spawn BIS_fnc_dynamicText;
        GVAR(observedCrate) = [_newObject, _handle];
    } else {
        GVAR(observedCrate) = [objNull, scriptNull];
    };
}] call CBA_fnc_addPerFrameHandler;
