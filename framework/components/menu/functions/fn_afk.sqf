#include "script_component.hpp"
/*
 * Author: Eric
 * Function for AFK players
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * call cmf_menu_fnc_afk
 * 
 * Public: No
 */

private _action = ([QGVAR(safestart_menu), 
    "Toggle AFK Mode", 
    "", {
        if (!GVAR(isAFK)) then {
            private _attachUnitIndex = (units group cmf_player) findIf { _x isNotEqualTo cmf_player && { (cmf_player distance _x) < 10 } };
            if (_attachUnitIndex isEqualTo -1) exitWith { hintSilent "You must be within 5m of a group member to go AFK" };
            private _attachUnit = (units group cmf_player) select _attachUnitIndex;
            private _relPos = _attachUnit worldToModelVisual getPos cmf_player;

            GVAR(afkData) = [_attachUnit, _relPos];
            [cmf_player, true] remoteExec ["hideObjectGlobal", 2];
            [0, "BLACK", 1] spawn BIS_fnc_fadeEffect;
            ([QGVAR(afkMessage)] call BIS_fnc_rscLayer) cutText ["You are AFK", "PLAIN"];
            cmf_player setVariable [QEGVAR(player,disableACRERadio), false];
            cmf_player setVariable [QEGVAR(player,overrideSound), 0];

            [format ["%1 has gone AFK", name cmf_player]] remoteExec ["systemChat"];
        } else {
            GVAR(afkData) params ["_attachedUnit", "_relPos"];
            cmf_player setPos (_attachedUnit modelToWorldVisual _relPos);
            if (!alive _attachedUnit) then {
                cmf_player setDamage 1;
            };

            [cmf_player, false] remoteExec ["hideObjectGlobal", 2];
            [1, "BLACK", 1] spawn BIS_fnc_fadeEffect;
            ([QGVAR(afkMessage)] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
            cmf_player setVariable [QEGVAR(player,disableACRERadio), nil];
            cmf_player setVariable [QEGVAR(player,overrideSound), nil];

            [format ["%1 is no longer AFK", name cmf_player]] remoteExec ["systemChat"];
        };

        GVAR(isAFK) = !GVAR(isAFK);
    }, 
    { alive cmf_player && { !visibleMap } }
] call ace_interact_menu_fnc_createAction);

_action;