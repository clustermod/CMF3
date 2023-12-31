#include "script_component.hpp"

if (!hasInterface) exitWith {};

LOG_1("Initializing player %1...", (name player));
GVAR(player_initialized) = false;

/* Raise event */
[QGVAR(player_initialized), []] call CBA_fnc_localEvent;

GVAR(player_initialized) = true;
INFO_1("Player %1 Initialized!", (name player));