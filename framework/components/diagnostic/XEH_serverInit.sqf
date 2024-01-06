#include "script_component.hpp"

/* Report performance when it drops below 15 FPS */
0 spawn { // @TODO: Replace spawn
    while { true } do {
        waitUntil { sleep 1; diag_fps < 15 };

        private _activeScripts = diag_activeScripts;
        private _warningMessage = format ["Low Server FPS detected: %1 | Spawn: %2 | ExecVM: %3 | Exec: %4 | execFSM: %5", 
            str diag_fps, str (_activeScripts select 0), str (_activeScripts select 1), str (_activeScripts select 2), str (_activeScripts select 3)];

        WARNING(_warningMessage);

        [QGVAR(warningNotification), _warningMessage] call CBA_fnc_globalEvent;
        
        sleep 30;
    };
};

/* Share server FPS */
[{
    if (!isServer) exitWith {};

    [QGVAR(serverFPS), diag_fps] call CBA_fnc_publicVariable;
    [QGVAR(serverScripts), diag_activeScripts] call CBA_fnc_publicVariable;
}, 2] call CBA_fnc_addPerFrameHandler;