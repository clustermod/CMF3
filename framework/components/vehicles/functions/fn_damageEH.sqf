#include "script_component.hpp"
/*
 * Author: Eric
 * Handles vehicle damage for vehicles
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Selection <STRING>
 * 2: Damage <NUMBER>
 * 3: Source <OBJECT>
 * 4: Projectile <String>
 * 5: hitIndex <NUMBER>
 * 6: Instigator <OBJECT>
 * 7: HitPoint <STRING>
 * 8: directHit <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * this addEventHandler ["HandleDamage", cmf_vehicles_fnc_damageEH];
 *
 * Public: Yes
 */

params ["_veh", "_selection", "_damage", "", "_projectile", "", "", "_hitPoint"];

/* Check if vehicle is local */
if !(local _veh) exitWith {};

/* Check if enhancedVehicles has been disabled */
if (missionNamespace getVariable [QGVAR(damageDisable), false]) exitWith {};

/* Get the projectile type the vehicle was hit with */
private _projectileType = [GVAR(projectileCache), _selection, nil] call CBA_fnc_hashGet;
if (isNil "_projectileType") then {
    _projectileType = getNumber (configfile >> "CfgAmmo" >> _projectile >> "explosive");

    if (isNil "_projectileType") then {
        _projectileType = 0;
    };

    GVAR(projectileCache) = [GVAR(projectileCache), typeOf _veh, _projectileType] call CBA_fnc_hashSet;
};

/* Get the vehicle selectionNames */
private _vehicleSelections = [GVAR(vehicleCache), typeOf _veh, []] call CBA_fnc_hashGet;
if (_vehicleSelections isEqualTo []) then {
    private _engineName = getText (configFile >> "cfgVehicles" >> (typeOf _veh) >> "HitPoints" >> "HitEngine" >> "name");
    private _fuelName = getText (configFile >> "cfgVehicles" >> (typeOf _veh) >> "HitPoints" >> "HitFuel" >> "name");

    _vehicleSelections = [_engineName, _fuelName];

    GVAR(vehicleCache) = [GVAR(vehicleCache), typeOf _veh, _vehicleSelections] call CBA_fnc_hashSet;
};


/* Check if the damage is enough to kill the vehicle, and if it is take over the damage handling */
//LOG_2("%1 in %2 || %1 isEqualTo """"", _selection, str _vehicleSelections);
if (_damage > 0.8 && { (_selection in _vehicleSelections) || _selection isEqualTo "" }) then {
    LOG_2("Registered damage on selection: %1 = %2", _selection, str _damage);

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

    /* Disable engine */
    if (_veh getHit "engine" != 1) then {
        LOG_2("Vehicled disabled: %1 = %2", _selection, str _damage);
        _veh setHit ["engine", 1];
        _veh engineOn false;

        {
            if (!isPlayer _x) then {
                unassignVehicle _x;
            };
        } forEach crew _veh;
    };

    /* Allow fueltank to start leaking */
    if (_selection isEqualTo "fuel") then {
        if (_veh getHit "fuel" >= 0.9 && { _veh getVariable [QGVAR(isBurning), false] && { (random 1) < (0.5 * (fuel _veh)) } }) then {
            private "_key";
            for "_y" from 0 to 9001 do {
                _key = QGVAR(vehicleFire_) + str _y;
                if !(_key in _aceKeys) exitWith {};
            };

            private _boundingRect = boundingBoxReal _veh;
            private _radius = (_boundingRect select 2) / 2;

            private _burnTime = 600 * fuel _veh;
            ["ace_fire_addFireSource", [_veh, _radius, 10 * (fuel _veh), _key, { (_this select 0) > time }, [_burnTime]]] call CBA_fnc_serverEvent;
            _veh setVariable [QGVAR(isBurning), true, true];

            [{time > (_this select 0)}, { (_this select 1) setVariable [QGVAR(isBurning), false, true] }, [_burnTime, _veh]] call CBA_fnc_waitUntilAndExecute;
        };
    } else {
        _damage = 0.8;
    };

    /* Dissembark ai crew */
    {
        if (!isPlayer _x) then {
            unassignVehicle _x;
            doGetOut _x;
        }
    } forEach crew _veh;

    /* Raise event */
    [QGVAR(onDisabled), [_veh, _projectile, _hitPoint], _veh] call CBA_fnc_targetEvent;
};

/* Set the damage amount on the vehicle */
_damage;