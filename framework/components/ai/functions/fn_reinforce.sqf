#include "script_component.hpp"
/*
 * Author: Eric
 * Makes ai reinforce groups in contact
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [300, 15] call cmf_ai_fnc_reinforce
 *
 * public: Yes
*/
SCRIPT(reinforce);

if (!isServer) exitWith {};

/* Transfer all new AI groups to server */
["CAManBase", "init", {
    params ["_unit"];

    if (!SETTING(reinforce)) exitWith {};

    private _group = group _unit;

    if (_group getVariable [QGVAR(reinforce_initialized), false]) exitWith {};

    {
        [[_group], true] call lambs_danger_fnc_setReinforcement;
        [[_group], true] call lambs_danger_fnc_setHasRadio;
    } forEach units _group;

    /* Add eventhandler to make group rush to contact */
    ["lambs_danger_OnInformationShared", {
        _thisArgs params ["_reinforceGroup"];
        params ["", "_shareGroup", "_target"];

        if (_reinforceGroup getVariable [QGVAR(reinforce_disableGroup), false]) exitWith {};
        if ((group _target) getVariable [QGVAR(reinforce_disableTarget), false]) exitWith {};

        if ( (leader _reinforceGroup distance leader _shareGroup) < SETTING(reinforceRange) && _reinforceGroup != _shareGroup && !(_reinforceGroup getVariable [QGVAR(reinforce_targetGroup), grpNull] isEqualTo _shareGroup) && side _reinforceGroup isEqualTo side _shareGroup ) then {
            LOG_2("%1 reinforcing %2(TaskRush)", groupId _reinforceGroup, groupId _shareGroup);

            [_reinforceGroup, 200, 15, [], getPos _target, false] spawn lambs_wp_fnc_taskRush;

            /* Delete old waypoints and add new */
            for "_i" from count waypoints _reinforceGroup - 1 to 0 step -1 do {
                deleteWaypoint [_reinforceGroup, _i];
            };
            private _wp = _reinforceGroup addWaypoint [_target, 0];
            _wp setWaypointType "MOVE";
            _reinforceGroup setVariable [QGVAR(reinforce_targetGroup), _shareGroup, true];
        };
    }, _group] call CBA_fnc_addEventHandlerArgs;

    LOG_1("Enabled reinforce on %1", groupId _group);
    _group setVariable [QGVAR(reinforce_initialized), true, true];
}, true, [], true] call CBA_fnc_addClassEventHandler;