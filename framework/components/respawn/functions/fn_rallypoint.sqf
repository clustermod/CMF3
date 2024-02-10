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
 * [["SL", "PL", _myUnit]] call cmf_respawn_fnc_rallypoint
 *
 * public: Yes
*/
SCRIPT(rallypoint);

params [["_units", []]];

/* Code to place rallypoint */
private _rallypointPlaceCode = {
    // @TODO: Replace Spawn
    _this spawn {
        /* Create placement UI */
        [LSTRING(place_displayName), LSTRING(cancel_displayName)] call ace_interaction_fnc_showMouseHint;

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
        private _obj = GVAR(setting_rallypointObject) createVehicleLocal (getPos player);
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

            /* Basically onEachFrame */
            Sleep 0.001;
        };

        /* Make object global */
        private _rallyPos = getPosASL _obj;
        private _rallyDir = getDir _obj;
        deleteVehicle _obj;
        _obj = GVAR(setting_rallypointObject) createVehicle [0,0,0];
        _obj setPosASL _rallyPos;
        _obj setDir _rallyDir;

        /* Remove placement UI */
        call ace_interaction_fnc_hideMouseHint;

        /* place rallypoint if not cancelled */
        if (GVAR(rallypoint_place)) then {
            /* Get old rallypoint */
            private _oldRallyParams = player getVariable [QGVAR(rallypoint_lastRally), [objNull, [objNull, -1]]];
            _oldRallyParams params ["_oldObject", "_oldRespawn"];

            /* Check if enemies are close to rally */
            private _units = (nearestObjects [_obj, ["Man"], GVAR(setting_rallypointKillRadius)]) apply { [side _x, side player] call BIS_fnc_sideIsFriendly };
            if (false in _units) exitWith {
                hint format[LSTRING(rally_too_close_message), GVAR(setting_rallypointKillRadius)];
                deleteVehicle _obj;
            };

            /* Delete rallypoint from global rallypoints array */
            GVAR(rallypoints) deleteAt (GVAR(rallypoints) find _oldObject);

            /* Delete old rallypoint */
            if (typeof _oldObject isEqualTo SETTING(rallypointObject)) then {
                deleteVehicle _oldObject;
            };
            _oldRespawn call BIS_fnc_RemoveRespawnPosition;

            /* Create new rallypoint */
            private _respawn = [side player, getPosATL _obj, format["%1 Rallypoint", groupID group player]] call BIS_fnc_addRespawnPosition;

            /* Pushback new rallypoint */
            GVAR(rallypoints) pushBack _obj;
            publicVariable QGVAR(rallypoints);

            /* Spawn script to Kill rally point if enemy units get too close */
            [{
                private _nearestUnits = nearestObjects [(_this select 0), ["Man"], GVAR(setting_rallypointKillRadius)];
                isNull (_this select 0) || _nearestUnits findIf { !([side _x, side player] call BIS_fnc_sideIsFriendly) } > -1
            }, {
                params ["_obj", "_respawn"];

                if (isNull _obj) exitWith {};

                _respawn call BIS_fnc_RemoveRespawnPosition;
                deleteVehicle _obj;
                cmf_player setVariable [QGVAR(rallypoint_lastRally), [objNull, [objNull, -1], scriptNull], true];
            }, [_obj, _respawn]] call CBA_fnc_waitUntilAndExecute;

            /* Save current rally to unit */
            cmf_player setVariable [QGVAR(rallypoint_lastRally), [_obj, _respawn], true];

            /* Spawn cooldown timer */
            cmf_player setVariable [QGVAR(rallypoint_canCreate), false, true];
            [{
                cmf_player setVariable [QGVAR(rallypoint_canCreate), true, true];
            }, [], GVAR(setting_rallypointCooldown)] call CBA_fnc_waitAndExecute;
        } else {
            deleteVehicle _obj;
        };
    };
};

/* Code to run when rallypoint is unavailable */
private _rallypointFailedCode = {
    hint format[LSTRING(time_restriction_message), (GVAR(setting_rallypointCooldown) / 60)];
};

/* Create Place action */
private _rallypointPlaceAction = [QGVAR(rallypoint_place), LSTRING(place_rallypoint), "components\respawn\data\icon_ace_rallypoint_place_ca.paa", _rallypointPlaceCode, {
    ((isNull objectParent player) && { (player getVariable [QGVAR(rallypoint_canCreate), true]) && !(missionNamespace getVariable [QGVAR(rallypoint_disabled), false]) })
    && { (player getVariable [QGVAR(showRallypoint), true])
    && !visibleMap }
}] call ace_interact_menu_fnc_createAction;

/* Create Unable to place action */
private _rallypointFailedAction = [QGVAR(rallypoint_disabled), LSTRING(place_rallypoint), "components\respawn\data\icon_ace_rallypoint_disabled_ca.paa", _rallypointFailedCode, {
    (((isNull objectParent player) && { !(player getVariable [QGVAR(rallypoint_canCreate), true]) })
    || (missionNamespace getVariable [QGVAR(rallypoint_disabled), false]))
    && { (player getVariable [QGVAR(showRallypoint), true])
    && !visibleMap }
}] call ace_interact_menu_fnc_createAction;

/* Throw warning if units array is empty */
if (count _units isEqualTo 0) exitWith {
    WARNING("_units array is empty");
};

{
    /* If the unit is a string check player role against it */
    if (IS_STRING(_x)) then {
        if (([player, _x] call EFUNC(organization,isRole)) && { !(player getVariable [QGVAR(rallypoint), false]) }) then {
            waitUntil { alive player && { !isNull player } };
            [typeOf player, 1, ["ACE_SelfActions"], _rallypointPlaceAction] call ace_interact_menu_fnc_addActionToClass;
            [typeOf player, 1, ["ACE_SelfActions"], _rallypointFailedAction] call ace_interact_menu_fnc_addActionToClass;

            cmf_player setVariable [QGVAR(rallypoint), true, true];
            LOG_1("Added rallypoint for %1", name player);
        };
        continue;
    };

    /* If the unit is a object apply to object */
    if (IS_OBJECT(_x)) then {
        if !(_x getVariable [QGVAR(rallypoint), false]) then {
            waitUntil { alive _x && { !isNull _x } };
            /* Add interactions where unit is local */
            [[typeOf _x, 1, ["ACE_SelfActions"], _rallypointPlaceAction], ace_interact_menu_fnc_addActionToClass] remoteExec ["call", _x];
            [[typeOf _x, 1, ["ACE_SelfActions"], _rallypointFailedAction], ace_interact_menu_fnc_addActionToClass] remoteExec ["call", _x];

            _x setVariable [QGVAR(rallypoint), true, true];
            LOG_1("Added rallypoint for %1", name _x);
        };
    };
} forEach _units;

/* Allow Setting vehicle as rallypoint */
private _action = [QGVAR(other), "Set as rallypoint", "components\respawn\data\icon_ace_rallypoint_place_ca.paa", {
    private _oldRallyParams = player getVariable [QGVAR(rallypoint_lastRally), [objNull, [objNull, -1]]];
    _oldRallyParams params ["_oldObject", "_oldRespawn"];

    /* Delete rallypoint from global rallypoints array */
    GVAR(rallypoints) deleteAt (GVAR(rallypoints) find _oldObject);

    /* Delete old rallypoint */
    if (typeof _oldObject isEqualTo SETTING(rallypointObject)) then {
        deleteVehicle _oldObject;
    };
    _oldRespawn call BIS_fnc_RemoveRespawnPosition;

    /* Create new rallypoint */
    private _respawn = [side player, _target, format["%1 Rallypoint", groupID group player]] call BIS_fnc_addRespawnPosition;

    /* Pushback new rallypoint */
    GVAR(rallypoints) pushBack _target;
    publicVariable QGVAR(rallypoints);

    /* Save current rally to unit */
    cmf_player setVariable [QGVAR(rallypoint_lastRally), [_target, _respawn], true];

    /* Spawn cooldown timer */
    cmf_player setVariable [QGVAR(rallypoint_canCreate), false, true];
    [{
        cmf_player setVariable [QGVAR(rallypoint_canCreate), true, true];
    }, [], GVAR(setting_rallypointCooldown)] call CBA_fnc_waitAndExecute;
}, {
    ((isNull objectParent cmf_player) && { (cmf_player getVariable [QGVAR(rallypoint_canCreate), true]) && !(missionNamespace getVariable [QGVAR(rallypoint_disabled), false]) })
    && { (cmf_player getVariable [QGVAR(showRallypoint), true])
    && !visibleMap }
}] call ace_interact_menu_fnc_createAction;

["Car", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;
["Tank", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;
["Ship", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;
["Air", 0, ["ACE_MainActions"], _action, true] call ACE_interact_menu_fnc_addActionToClass;

/* Add button to ping SL to create rallypoint */
[{
    !isNull ((findDisplay 12) displayCtrl 88800)
}, {
    waitUntil { !isNull findDisplay 12 };
    waitUntil { !isNull ((findDisplay 12) displayCtrl 88800) };

    /* Find rally-capable units in group */
    private _rallyUnits = (units group player) select { (_x getVariable [QGVAR(rallypoint), false]) && { (alive _x) && { (lifeState _x != "UNCONCIOUS") } } };

    /* Create button */
    private _ctrlGroup = (findDisplay 12) displayCtrl 88800;
    private _ctrlButton = (findDisplay 12) ctrlCreate ["RscGearShortcutButton", -1, _ctrlGroup];
    _ctrlButton ctrlSetPosition [0,0.386,0.378,0.044];
    _ctrlButton ctrlCommit 0;
    _ctrlButton ctrlSetBackgroundColor [0.101961,0.101961,0.101961,0.8];
    _ctrlButton ctrlSetBackgroundColor [0.101961,0.101961,0.101961,0.8];
    _ctrlButton ctrlSetFont "PuristaLight";
    _ctrlButton ctrlSetFontP 0.95;
    _ctrlButton ctrlSetText "PING FOR RP";
    _ctrlButton ctrlEnable (count _rallyUnits > 0);
    if (count _rallyUnits > 0) then {
        _ctrlButton ctrlSetTooltip "Pings rallypoint-capable units in your group for a rallypoint.";
    } else {
        _ctrlButton ctrlSetTooltip "No rallypoint-capable units alive.";
    };
    _ctrlButton ctrlCommit 0;

    /* Ping rally-capable units in group */
    _ctrlButton ctrlAddEventHandler ["ButtonClick", {
        /* Find rally-capable units in group */
        private _rallyUnits = (units group player) select { _x getVariable [QGVAR(rallypoint), false] && { alive _x } };

        /* Show ping for rallypoint-capable units */
        {
            [player, {
                [format["<t size='1.1' color='#ff6347'>%1 Requested rallypoint<t>", name _this], -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
                playSoundUI ["a3\sounds_f\sfx\ui\tactical_ping\tactical_ping.wss"];
            }] remoteExec ["call", _x];
        } forEach _rallyUnits;
    }];

    /* Update availability of pinging */
    GVAR(rallypoint_PFH) = -1;
    addMissionEventHandler ["Map", {
        params ["_mapIsOpened", "_mapIsForced"];

        if (_mapIsOpened && { !isNull ((findDisplay 12) displayCtrl 88800) }) then {
            GVAR(rallypoint_PFH) = [{
                private _rallyUnits = (units group player) select { (_x getVariable [QGVAR(rallypoint), false]) && { (alive _x) && { (lifeState _x != "UNCONCIOUS") } } };

                _ctrlButton ctrlEnable (count _rallyUnits > 0);
                if (count _rallyUnits > 0) then {
                    _ctrlButton ctrlSetTooltip "Pings rallypoint-capable units in your group for a rallypoint.";
                } else {
                    _ctrlButton ctrlSetTooltip "No rallypoint-capable units alive.";
                };

            }] call CBA_fnc_addPerFrameHandler;
        } else {
            [GVAR(rallypoint_PFH)] call CBA_fnc_removePerFrameHandler;
        };
    }];

}] call CBA_fnc_waitUntilAndExecute;