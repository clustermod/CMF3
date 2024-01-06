#include "script_component.hpp"
/*
 * Author: Eric
 * Repairs and rearms player vehicles inside radius. (BROKEN)
 *
 * Arguments:
 * 0: Center Position <ARRAY>
 * 1: Radius <NUMBER> [Default: 5]
 * 2: Types to repair <ARRAY> [Default: ["Car", "Tank", "Plane", "Helicopter", "Ship"]]
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myPos, 10, ["Helicopter", "Plane"]] call cmf_gameplay_fnc_repairRearmStation
 *
 * public: Yes
*/
SCRIPT(repairRearmStation);

// @TODO: Move to Vehicle Component

if (!isServer) exitWith {};

// @TODO: replace spawn
_this spawn {
    private _fnc_repairRearm = {
        params ["_veh"];

        private _type = typeOf _veh;
        private _name = getText(configFile >> "CfgVehicles" >> _type >> "displayname");
        private _reloadTimeFactor = 1;

        _veh setVehicleAmmo 1;
        QGVAR(reapirRearm_info) cutText [format ["Servicing %1... Please stand by...", _name], "PLAIN DOWN"];

        private _magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

        /* Reload vehicle magazines */
        if (count _magazines > 0) then {
            private _removed = [];
            {
                if (!(_x in _removed)) then {
                    _veh removeMagazines _x;
                    _removed = _removed + [_x];
                };
            } forEach _magazines;

            {

                private _name = getText(configFile >> "CfgMagazines" >> _x >> "displayname");
                QGVAR(reapirRearm_info) cutText [format ["Reloading %1 [%2/%3]", _name, _forEachIndex + 1, count _magazines], "PLAIN DOWN"];
                sleep _reloadTimeFactor;
                _veh addMagazine _x;
            } forEach _magazines;
        };

        /* Get ammount of turrets on vehicle */
        private _turrets = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

        /* Reload magazines */
        if (_turrets > 0) then {
            for "_i" from 0 to (_turrets - 1) do {
                private _config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
                private _turretName = configName _config;
                _magazines = getArray(_config >> "magazines");
                private _removed = [];
                {
                    if (!(_x in _removed)) then {
                        _veh removeMagazines _x;
                        _removed = _removed + [_x];
                    };
                } forEach _magazines;

                {
                    private _name = getText(configFile >> "CfgMagazines" >> _x >> "displayname");
                    QGVAR(reapirRearm_info) cutText [format ["Reloading Turret %1 with %2 [%3/%4]", _turretName, _name, _forEachIndex + 1, count _magazines], "PLAIN DOWN"];
                    sleep _reloadTimeFactor;
                    _veh addMagazine _x;
                    sleep _reloadTimeFactor;
                } forEach _magazines;

                private _count_other = count (_config >> "Turrets");
                if (_count_other > 0) then {
                    for "_i" from 0 to (_count_other - 1) do {
                        private _config2 = (_config >> "Turrets") select _i;
                        _magazines = getArray(_config2 >> "magazines");
                        _removed = [];
                        {
                            if (!(_x in _removed)) then {
                                _veh removeMagazines _x;
                                _removed = _removed + [_x];
                            };
                        } forEach _magazines;

                        {
                            private _name = getText(configFile >> "CfgMagazines" >> _x >> "displayname");
                            QGVAR(reapirRearm_info) cutText [format ["Reloading Turret %1 with %2 [%3/%4]", _turretName, _name, _forEachIndex + 1, count _magazines], "PLAIN DOWN"];
                            sleep _reloadTimeFactor;
                            _veh addMagazine _x;
                            sleep _reloadTimeFactor;
                        } forEach _magazines;
                    };
                };
            };
        };

        /* Reload turrets / drivers magazine */
        _veh setVehicleAmmo 1;

        /* Repair vehicle*/
        sleep _reloadTimeFactor;
        //_veh vehicleChat "Repairing...";
        QGVAR(reapirRearm_info) cutText ["Repairing...", "PLAIN DOWN"];
        _veh setDamage 0;

        /* Refuel vehicle */
        sleep _reloadTimeFactor;
        //_veh vehicleChat "Refuelling...";
        QGVAR(reapirRearm_info) cutText ["Refueling...", "PLAIN DOWN"];
        while {fuel _veh < 0.99} do {
            _veh setFuel ((fuel _veh + 0.01) min 1);
            sleep 0.05;
        };
        sleep _reloadTimeFactor;
        //_veh vehicleChat format ["%1 is ready...", _name];
        QGVAR(reapirRearm_info) cutText [format ["%1 is ready...", _name], "PLAIN DOWN"];
    };

    /* Make all players self verify */
    // @TODO: replace spawn
    [[_this, _fnc_repairRearm], {
        (_this select 0) params ["_centerPos", ["_centerRadius", 5], ["_types", ["Car", "Tank", "Plane", "Helicopter", "Ship"]]];

        while { !(missionNamespace getVariable [QGVAR(repairRearm_disable), false]) } do {
            waitUntil { !isNull objectParent player && { (objectParent player distance _centerPos) < _centerRadius && { _types findIf { objectParent player isKindOf _x } != -1 } } };
            private _vehicle = objectParent player;

            LOG_1("repairRearm %1", typeOf _vehicle);

            /* Spawn the repair and rearm script */
            // @TODO: replace spawn
            private _repairRearmHandle = _vehicle spawn (_this select 1);

            /* Wait until player leaves radius */
            waitUntil { (objectParent player distance _centerPos) > _centerRadius };
            if (!scriptDone _repairRearmHandle) then {
                terminate _repairRearmHandle;
                QGVAR(reapirRearm_info) cutText ["Cancelled Operation!", "PLAIN DOWN"];
            };

            sleep 0.1;
        };
    }] remoteExec ["spawn", 0, true];
};
