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
 * [] call cmf_menu_fnc_safestart
 * 
 * Public: No
 */
params ["_target"];

private _action = ([QGVAR(safestart_menu), 
    LSTRING(disable_safestart_displayname), 
    "rsc\data\icon_ace_startgame_ca.paa", {
        missionNameSpace setVariable [QEGVAR(gameplay,safestart_Countdown), true, true];

        [[], {
            [EGVAR(gameplay,setting_safestartDelay), "Weapons are live in: ", true] call EFUNC(utility,countDown);
            missionNamespace setVariable [QEGVAR(gameplay,safestart_disable), true, true];
        }] remoteExec ["spawn", 0];
    }, 
    { 
        is3DENPreview || (!(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false]) && 
        !isNull (getAssignedCuratorLogic player)) || ((call BIS_fnc_admin) > 0 && 
        !(missionNamespace getVariable [QEGVAR(gameplay,safestart_Countdown), false])) 
    }
] call ace_interact_menu_fnc_createAction);

_action;