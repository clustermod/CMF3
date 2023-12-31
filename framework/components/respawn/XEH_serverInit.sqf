#include "script_component.hpp"

/* Handle disconnects */
addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "", "_uid"];

    /* Save unit loadout, position and direction before disconnect */
    private _disconUnits = missionNameSpace getVariable [QGVAR(disconUnits), createHashMap];
    _disconUnits set [_uid, [[_unit] call EFUNC(common,getRole), group _unit, getDir _unit, getUnitLoadout _unit, [_unit getVariable[QEGVAR(respawn,respawns), -1], _unit getVariable[QEGVAR(respawn,deaths), 0]]]];
    GVAR(disconUnits) = _disconUnits;
    publicVariable QGVAR(disconUnits);

    false;
}];