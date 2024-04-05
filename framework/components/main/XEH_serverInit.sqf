#include "script_component.hpp"

LOG_1("Initializing CMF v%1...", VERSION_STR);
GVAR(server_initialized) = false;
publicVariable QGVAR(server_initialized);

/* Register player */
addMissionEventHandler ["PlayerConnected", {
    private _owner = _this select 4;

    /* Raise event */
    [QGVAR(server_onPlayerConnected), _this] call CBA_fnc_globalEvent;
}];

INFO_1("CMF v%1 Initialized!", VERSION_STR);
GVAR(server_initialized) = true;
publicVariable QGVAR(server_initialized);