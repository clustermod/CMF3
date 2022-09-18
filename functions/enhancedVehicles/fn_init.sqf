#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes enhanced vehicles on passed vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [myVehicle] call cmf_enhancedVehicles_fnc_init
 *
 * Public: Yes
 */
SCRIPT(init);

params["_veh"];

/* Code to handle damage */
private _damageHandle = {
    params ["_veh", "_selection", "_damage", "", "_projectile", "", "", "_hitPoint"];

    /* Check if vehicle is local */
    if !(local _veh) exitWith {};

    /* Check if enhancedVehicles has been disabled */
    if (missionNamespace getVariable [QGVAR(disable), false]) exitWith {};

    /* Get the projectile type the vehicle was hit with */
    private _projectileType = getNumber (configfile >> "CfgAmmo" >> _projectile >> "explosive");

    /* Check if the damage is enough to kill the vehicle, and if it is take over the damage handling */
    if (_damage > 0.9 && !(["wheel", _selection] call Bis_fnc_inString || ["glass", _selection] call Bis_fnc_inString || ["body", _selection] call Bis_fnc_inString)) then {

        /* If the projectile type was explosive play cool visual and audiable effects */
        if ((_projectileType isEqualTo 1)) then {
            [_veh, _projectile, _hitPoint] spawn {
                params["_veh", "_projectile", "_hitPoint"];
                {
                    /* Handle medical for units in hit vehicle */
                    [[_veh, _projectile, _hitPoint], FUNC(medicalHandler)] remoteExec ["call", _x];

                    /* Handle local sound and visual effects for players in vehicle */
                    if (isPlayer _x) then {
                        [[], FUNC(localEffect)] remoteExec ["call", _x];
                    };
                } forEach crew _veh;
            };
        };
        _damage = 0.9;

        /* Raise event */
        [QGVAR(onDisabled), [_veh, _projectile, _hitPoint], _veh] call CBA_fnc_targetEvent;
    };

    /* Set the damage amount on the vehicle */
    _damage;
};

/* Add the eventhandler */
if (_veh isKindOf "car" || _veh isKindOf "tank") then {
    _veh setVariable ["ace_cookoff_enable", false, true];
    _veh addEventHandler ["HandleDamage", _damageHandle];

    /* Raise event */
    [QGVAR(enableEnhancedVehicles), [_veh], _veh] call CBA_fnc_targetEvent;
};

/* Initialize Offroading script on vehicle */
if (_veh isKindOf "car") then {
    [_veh] call FUNC(offroading);
};
