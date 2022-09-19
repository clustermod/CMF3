#include "script_component.hpp"
/*
 * Author: Eric
 * Create a rallypoint system similar to Squad's rallypoint system.
 *
 * Arguments:
 * 0: Unit Array <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [["SL", "PL", _myUnit]] call cmf_common_fnc_rallypoint
 *
 * public: Yes
*/
SCRIPT(rallypoint);

_this spawn {

    params [["_units", []]];

    /* Code to place rallypoint */
    private _rallypointPlaceCode = {
        _this spawn {
            /* Get config settings */
            private _objectClass = CONFIG_PARAM_3(SETTINGS,rallypoint,rallyObjectClass);
            private _enemyKillRadius = CONFIG_PARAM_3(SETTINGS,rallypoint,enemyKillRadius);
            private _cooldown = CONFIG_PARAM_3(SETTINGS,rallypoint,cooldown);

            /* Create placement UI */
            ([QGVAR(rallypoint_HUD)] call BIS_fnc_rscLayer) cutRsc [QGVAR(rallypoint), "PLAIN"];

            /* Detect mouse input */
            GVAR(rallypoint_placeLoop) = true;
            GVAR(rallypoint_place) = false;
            (findDisplay 46) displayAddEventHandler ["mouseButtonDown", {
                switch ((_this select 1)) do {
                    case (0): { GVAR(rallypoint_place) = true };
                    case (1): { GVAR(rallypoint_place) = false };
                };
                GVAR(rallypoint_placeLoop) = false;
                (findDisplay 46) displayRemoveEventHandler ["mouseButtonDown", _thisEventHandler];
            }];

            /* Block LMB from firing */
            player addAction ["", { player removeAction (_this select 2)}, "", 0, false, true, "DefaultAction"];

            /* Placement loop */
            private _obj = _objectClass createVehicle (getPos player);
            _obj setPosASL (getPosASL player);
            while { GVAR(rallypoint_placeLoop) } do {
                /* Get X and Y Coordinate */
                private _intersections = lineIntersectsSurfaces [eyePos player, AGLToASL (screenToWorld[0.5, 0.5]), player, _obj, true, 1];
                private _pos = ((_intersections select 0) select 0);
                if (count _intersections isEqualTo 0) then {
                    _pos = AGLToASL (screenToWorld[0.5, 0.5])
                };

                /* Move position slightly closer for the Z calculation */
                private _dir = player getDir _pos;
                private _distance = player distance2D _pos;
                private _height = (_pos select 2) + 0.1;
                private _pos = (getPos player) getPos [(_distance - 0.1) min 3, _dir];

                /* Get height correction */
                private _height = ((lineIntersectsSurfaces [[_pos select 0, _pos select 1, _height], [(_pos select 0), (_pos select 1), 0], _obj] select 0) select 0) select 2;
                if (isNil "_height") then {
                    _height = 0;
                };

                /* Set position */
                private _finalPos = [_pos select 0, _pos select 1, _height];
                _obj setPosASL _finalPos;
                _obj setDir _dir;

                sleep 0.01;
            };

            /* Remove placement UI */
            ([QGVAR(rallypoint_HUD)] call BIS_fnc_rscLayer) cutRsc ["Default", "PLAIN"];

            /* place rallypoint if not cancelled */
            if (GVAR(rallypoint_place)) then {
                /* Get old rallypoint */
                private _oldRallyParams = player getVariable [QGVAR(rallypoint_lastRally), [objNull, [objNull, -1], scriptNull]];
                _oldRallyParams params ["_oldObject", "_oldRespawn", "_oldKillSCript"];

                /* Check if enemies are close to rally */
                private _units = (nearestObjects [_obj, ["Man"], _enemyKillRadius]) apply { [side _x, side player] call BIS_fnc_sideIsFriendly };
                if (false in _units) exitWith {
                    hint format["Enemy within %1 meters of rally", _enemyKillRadius];
                    deleteVehicle _obj;
                };

                /* Delete old rallypoint */
                deleteVehicle _oldObject;
                _oldRespawn call BIS_fnc_RemoveRespawnPosition;
                terminate _oldKillSCript;

                /* Create new rallypoint */
                private _respawn = [side player, getPosATL _obj, format["%1 Rallypoint", groupID group player]] call BIS_fnc_addRespawnPosition;
                private _marker = "";

                /* Spawn script to Kill rally point if enemy units get too close */
                private _killScript = [player, _obj, _enemyKillRadius, side player, _respawn, _marker] spawn {
                    params ["_unit", "_obj", "_enemyKillRadius", "_side", "_respawn", "_marker"];

                    /* Check if enemies are within kill radius of rallypoint */
                    waitUntil { false in ((nearestObjects [_obj, ["Man"], _enemyKillRadius]) apply { [side _x, _side] call BIS_fnc_sideIsFriendly }) };

                    _respawn call BIS_fnc_RemoveRespawnPosition;
                    deleteMarker _marker;
                    deleteVehicle _obj;
                    _unit setVariable [QGVAR(rallypoint_lastRally), [objNull, [objNull, -1], scriptNull], true];
                };

                /* Save current rally to unit */
                player setVariable [QGVAR(rallypoint_lastRally), [_obj, _respawn, _killScript], true];

                /* Spawn cooldown timer */
                _cooldown spawn {
                    private _cooldownTime = diag_tickTime + _this;
                    player setVariable [QGVAR(rallypoint_canCreate), false, true];

                    waitUntil {diag_tickTime > _cooldownTime};
                    player setVariable [QGVAR(rallypoint_canCreate), true, true];
                }
            } else {
                deleteVehicle _obj;
            };
        };
    };

    /* Code to run when rallypoint is unavailable */
    private _rallypointFailedCode = {
        private _cooldown = CONFIG_PARAM_3(SETTINGS,rallypoint,cooldown);
        hint format["can only be done once every %1 minutes", (_cooldown / 60)];
    };

    /* Create Place action */
    private _rallypointPlaceAction = [QGVAR(rallypoint_place), "Place rallypoint", "rsc\data\icon_ace_rallypoint_place_ca.paa", _rallypointPlaceCode, {
        ((vehicle player) == player) && (player getVariable [QGVAR(rallypoint_canCreate), true]) && !(missionNamespace getVariable [QGVAR(rallypoint_disabled), false])
    }] call ace_interact_menu_fnc_createAction;

    /* Create Unable to place action */
    private _rallypointFailedAction = [QGVAR(rallypoint_disabled), "Place rallypoint", "rsc\data\icon_ace_rallypoint_disabled_ca.paa", _rallypointFailedCode, {
        (((vehicle player) == player) && !(player getVariable [QGVAR(rallypoint_canCreate), true])) || (missionNamespace getVariable [QGVAR(rallypoint_disabled), false])
    }] call ace_interact_menu_fnc_createAction;

    /* Throw warning if units array is empty */
    if (count _units isEqualTo 0) exitWith {
        WARNING("_units array is empty");
    };

    {
        /* If the unit is a string check player role against it */
        if (IS_STRING(_x)) then {
            if (([player, _x] call EFUNC(common,isRole)) && !(player getVariable [QGVAR(rallypoint), false])) then {
                waitUntil { alive player && !isNull player };
                [typeOf player, 1, ["ACE_SelfActions"], _rallypointPlaceAction] call ace_interact_menu_fnc_addActionToClass;
                [typeOf player, 1, ["ACE_SelfActions"], _rallypointFailedAction] call ace_interact_menu_fnc_addActionToClass;

                player setVariable [QGVAR(rallypoint), true, true];
                LOG_1("Added rallypoint for %1", name player);
            };
        };

        /* If the unit is a object apply to object */
        if (IS_OBJECT(_x)) then {
            if !(_x getVariable [QGVAR(rallypoint), false]) then {
                waitUntil { alive _x && !isNull _x };
                /* Add interactions where unit is local */
                [[typeOf _x, 1, ["ACE_SelfActions"], _rallypointPlaceAction], ace_interact_menu_fnc_addActionToClass] remoteExec ["call", _x];
                [[typeOf _x, 1, ["ACE_SelfActions"], _rallypointFailedAction], ace_interact_menu_fnc_addActionToClass] remoteExec ["call", _x];

                _x setVariable [QGVAR(rallypoint), true, true];
                LOG_1("Added rallypoint for %1", name _x);
            };
        };
    } forEach _units;
};
