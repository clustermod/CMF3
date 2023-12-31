#include "script_component.hpp"
/*
 * Author: Eric
 * Displays informational text underneath players when in curator
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_zeus_fnc_playerInfo
 *
 * Public: No
 */
SCRIPT(playerInfo);

if (!hasInterface) exitwith {};
// @TODO: replace spawn
[] spawn {
   while { true } do {
        player setVariable [QGVAR(fps), floor diag_fps, true];
        sleep 0.1;
    };
};

// @TODO: replace spawn
[] spawn {
  waitUntil { (!isnull (getAssignedCuratorLogic player)) };
  if (player in (call bis_fnc_listcuratorplayers)) then {
      addMissionEventHandler ["Draw3D", {
        if (isNull curatorCamera) exitWith {};
          {
              private _distance = position curatorCamera distance _x;
              if (_distance < 1200) then {
                  private _playerFPS = _x getVariable [QGVAR(fps), 50];
                  if (_playerFPS  <20) then {
                      drawIcon3D
                      ["", [1,0,0,0.7], position _x, 1, 2, 0, format["%1 FPS: %2", name _x, str _playerFPS], 0, 0.05, "PuristaMedium", "center"];
                  } else {
                      drawIcon3D
                      ["", [1,1,1,0.7], position _x, 1, 2, 0, format["%1 FPS: %2", name _x, str _playerFPS], 0, 0.03, "PuristaMedium", "center"];
                  };
              };
          } forEach allPlayers;
      }];
  };
};
