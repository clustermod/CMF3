#include "script_component.hpp"
/*
 * Author: Eric
 * Make ai reinforce groups in contact
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

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,ai,reinforce) ) isEqualTo 1;
if !(_enabled) exitWith {};

if (!isServer) exitWith {};

/* Enable LAMBS reinforcements on unit */
while { !(missionNamespace getVariable [QGVAR(reinforce_disable), false]) } do {
    {
        if !(_x getVariable [QGVAR(reinforce_initialized), false]) then {
            {
                [[_x], true] call lambs_danger_fnc_setReinforcement;
                [[_x], true] call lambs_danger_fnc_setHasRadio;
            } forEach units _x;

            /* Add eventhandler to make group rush to contact */
            ["lambs_danger_OnInformationShared", {
                _thisArgs params ["_thisGroup"];
                params ["", "_group", "_target"];

                if (_thisGroup getVariable [QGVAR(reinforce_disableGroup), false]) exitWith {};

                if ((group _target) getVariable [QGVAR(reinforce_disableTarget), false]) exitWith {};

                private _range = CONFIG_PARAM_3(SETTINGS,ai,reinforceRange);
                if ( (leader _thisGroup distance leader _group) < _range && _thisGroup != _group && !(_thisGroup getVariable [QGVAR(reinforce_targetGroup), grpNull] isEqualTo _group) && side _thisGroup isEqualTo side _group ) then {
                    LOG_2("%1 reinforcing %2(TaskRush)", groupId _thisGroup, groupId _group);

                    [_thisGroup, 100, 15, [], getPos _target, false] spawn lambs_wp_fnc_taskRush;

                    /* Delete old waypoints and add new */
                    for "_i" from count waypoints _thisGroup - 1 to 0 step -1 do {
                    	deleteWaypoint [_group, _i];
                    };
                    private _wp = _thisGroup addWaypoint [_target, 0];
                    _wp setWaypointType "MOVE";
                    _thisGroup setVariable [QGVAR(reinforce_targetGroup), _group, true];
                };

            }, _x] call CBA_fnc_addEventHandlerArgs;

            LOG_1("Enabled reinforce on %1", groupId _x);
            _x setVariable [QGVAR(reinforce_initialized), true, true];
        };
        sleep 0.03;
    } forEach allGroups;
    sleep 1;
};
