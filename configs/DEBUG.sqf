scriptName "configs\DEBUG.sqf";
private["_levels", "_types", "_missionDebugLevel", "_missionDebugType"];
_levels = ["OFF", "FATAL", "ERR", "WARN", "INFO", "DEBUG", "TRACE", "ALL"];
_types = ["LOG", "CHAT", "ALL"];
_missionDebugLevel = toUpper getText (missionConfigFile >> "EMF" >> "DEBUG_LEVEL");
_missionDebugType = toUpper getText (missionConfigFile >> "EMF" >> "DEBUG_TYPE");

// Verify debug level
if !(_missionDebugLevel in _levels) exitWith {
  [format["Unknown DEBUG level: %1", _missionDebugLevel], "configs\DEBUG.sqf"] call emf_fnc_throwError;
};

// Verify debug type
if !(_missionDebugType in _types) exitWith {
  [format["Unknown DEBUG type: %1", _missionDebugType], "configs\DEBUG.sqf"] call emf_fnc_throwError;
};

// Define a function to handle debug logging
EMF_DEBUG = {
  private["_levels", "_missionDebugLevel", "_missionDebugType"];
  params[["_debugLevel", "INFO"], ["_stderr", ""]];

  _levels = ["OFF", "FATAL", "ERR", "WARN", "INFO", "DEBUG", "TRACE", "ALL"];
  _missionDebugLevel = toUpper getText (missionConfigFile >> "EMF" >> "DEBUG_LEVEL");
  _missionDebugType = toUpper getText (missionConfigFile >> "EMF" >> "DEBUG_TYPE");

  if (_missionDebugLevel isEqualTo "OFF") exitWith {false};

  for "_i" from (count _this -1) to 2 step -1 do {
    _stderr = format["[%1] ", (_this select _i)] + _stderr;
  };
  _stderr = format["[EMF] %1", _stderr];

  if (_missionDebugLevel isEqualTo "ALL") exitWith {
    if (_missionDebugLevel isEqualTo "ERR") then {
        [_stderr] call BIS_fnc_error;
        true;
    };
    if (_missionDebugType isEqualTo "LOG") exitWith {
        if (isServer) then {
            diag_log _stderr;
        } else {
            [_stderr] remoteExec ["diag_log", 2];
        };
        true;
    };
    if (_missionDebugType isEqualTo "CHAT") exitWith {
        if (isServer) then {
            systemChat _stderr;
        } else {
            [_stderr] remoteExec ["systemChat", 2];
        };
        true;
    };
    [_stderr] call BIS_fnc_log;
    systemChat _stderr;
    true;
  };

  if ((_levels find (toUpper _debugLevel)) >= (_levels find _missionDebugLevel) || _missionDebugLevel isEqualTo 7) exitWith {
      if (_missionDebugLevel isEqualTo "ERR") then {
          if (isServer) then {
            [_stderr] call BIS_fnc_error;
          } else {
            [_stderr] remoteExecCall ["BIS_fnc_error", 2];
          };
          true;
      };
      if (_missionDebugType isEqualTo "LOG") exitWith {
          if (isServer) then {
              diag_log _stderr;
          } else {
              [_stderr] remoteExec ["diag_log", 2];
          };
          true;
      };
      if (_missionDebugType isEqualTo "CHAT") exitWith {
          if (isServer) then {
              systemChat _stderr;
          } else {
              [_stderr] remoteExec ["systemChat", 2];
          };
          true;
      };
      [_stderr] call BIS_fnc_log;
      systemChat _stderr;
      true;
  };
  false;
};
publicVariable "EMF_DEBUG";
