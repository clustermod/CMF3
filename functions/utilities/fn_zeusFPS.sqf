/*
 * Author: Eric
 * Creates a 3D widget displaying playerunit's FPS for zeus.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call emf_utilities_fnc_zeusFPS
*/
scriptName "functions\utilities\fn_zeusFPS.sqf";

if (!hasInterface) exitwith {};
[] spawn {
   while {true} do {
        player setVariable ["DNI_PlayerFPS", floor diag_fps, true];
        sleep 0.1;
    };
};

// Wait until zeus module is initialized
waitUntil {
    private _hasCurators = (count allcurators) > 0;
    private _hasInitializedCurators = (count (call BIS_fnc_listCuratorPlayers)) > 0;
    private _curatorsInitialized = !_hasCurators || _hasInitializedCurators;
    ((time > 2) || _curatorsInitialized)
    };

if (player in (call bis_fnc_listcuratorplayers)) then {
	addMissionEventHandler ["Draw3D", {
		{
			private _distance = position curatorCamera distance _x;
			if (_distance < 1200) then {
				private _playerFPS = _x getVariable ["DNI_PlayerFPS",50];
				if (_playerFPS  <20) then
				{
					drawIcon3D
					["", [1,0,0,0.7], position _x, 1, 2, 0, format["%1 FPS: %2", name _x, str _playerFPS], 0, 0.05, "PuristaMedium", "center"];
				}
				else
				{
					drawIcon3D
					["", [1,1,1,0.7], position _x, 1, 2, 0, format["%1 FPS: %2", name _x, str _playerFPS], 0, 0.03, "PuristaMedium", "center"];
				};
			};
		} forEach allPlayers;
	}];
};
