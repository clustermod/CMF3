#include "script_component.hpp"
/*
 * Author: Eric
 * Report a bug
 * 
 * Arguments:
 * 0: Target <OBJECT>
 * 
 * Return Value:
 * Child Action <ARRAY>
 * 
 * Example:
 * call cmf_menu_fnc_safestart
 * 
 * Public: No
 */
params ["_target"];

private _action = ([QGVAR(safestart_menu), 
    LSTRING(disable_safestart_displayname), 
    "components\menu\data\icon_ace_startgame_ca.paa", {
        EGVAR(gameplay,safestart_Countdown) = true;
        publicVariable QEGVAR(gameplay,safestart_Countdown);

        [[], {
            [ESETTING(gameplay,safestartDelay), "Weapons are live in: ", true] call EFUNC(common,countDown);
            EGVAR(gameplay,safestart_disable) = true;
            publicVariable QEGVAR(gameplay,safestart_disable);
        }] remoteExec ["spawn", 0];
    }, 
    { 
        is3DENPreview || !(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false] && 
        { !isNull (getAssignedCuratorLogic player) }) || call BIS_fnc_admin > 0 && 
        { !(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false]) }
    }
] call ace_interact_menu_fnc_createAction);

_action;