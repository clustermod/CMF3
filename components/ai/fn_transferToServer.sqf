/*
 * Author: Eric
 * Transfers zeus spawned AI to server for better ai calculations and better performance for the zeus client
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call emf_init_fnc_transferToServer
 *
 * Public: No
 */
SCRIPT(transferToServer);

/* Check if it's enabled */
private _enabled = ( CONFIG_PARAM_3(SETTINGS,ai,transferToServer) ) isEqualTo 1;
if !(_enabled) exitWith {};

[] spawn {
    if (isDedicated) exitWith {};

    waitUntil{!isnull (getAssignedCuratorLogic player)};
    (getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {
        private _entity = _this select 1;

        if ( count crew _entity > 0 ) then {
			/* Call function on server */
			[[group effectiveCommander _entity], {
                params [["_group", grpNull]];

                if !( (owner leader _group) isEqualTo 2 ) then {
            		/* Set group owner to server */
            		_group setGroupOwner 2;
                    LOG_1("Transfered %1 to server", groupId _group);
            	};
            }] remoteExec ["call", 2];
		};
    }];
};
