/*
 * Author: Eric
 * defines a function.
 *
 * Arguments:
 * 0: category <STRING>
 * 1: name <STRING>
 * 2: path <STRING>
 *
 * Return Value:
 * functionName <STRING>
 *
 * Example:
 * ["common", "throwError", "common\throwError.sqf"] call emf_fnc_defineFunction
 *
 * Public: Yes
 */
scriptName "functions\common\fn_defineFunction.sqf";
params[["_category", ""], "_name", "_path", ["_postInit", false]];

if (isNil "_name") exitWith {["ERR", "Failed to define function: function name undefined", "defineFunction", "common"] call EMF_DEBUG; ""};
if (_name == "") exitWith {["ERR", "Failed to define function: function name cannot be nothing", "defineFunction", "common"] call EMF_DEBUG; ""};
if (isNil "_path") exitWith {["ERR", "Failed to define function: function path undefined", "defineFunction", "common"] call EMF_DEBUG; ""};
if (_path == "") exitWith {["ERR", "Failed to define function: function path cannot be nothing", "defineFunction", "common"] call EMF_DEBUG; ""};

if _postInit then {
  _path spawn {
    waitUntil{!isNull player};
    call compile(preprocessFileLineNumbers (format["functions\%1", _this]));
  }
};

if (_category isEqualTo "") exitWith {
  private _functionName = format["emf_%1_fnc_%2", _category, _name];
  if (toUpper(getText(missionConfigFile >> "EMF" >> "DEBUG_LEVEL")) isEqualTo "DEBUG") then {
    missionNamespace setVariable [_functionName, compile(preprocessFileLineNumbers (format["functions\%1", _path])), true];
  } else {
    missionNamespace setVariable [_functionName, compileFinal(preprocessFileLineNumbers (format["functions\%1", _path])), true];
  };
  _functionName;
  ["TRACE", format["Defined function: %1", _functionName], _path] call EMF_DEBUG;
};

private _functionName = format["emf_%1_fnc_%2", _category, _name];
if (toUpper(getText(missionConfigFile >> "EMF" >> "DEBUG_LEVEL")) isEqualTo "DEBUG") then {
  missionNamespace setVariable [_functionName, compile(preprocessFileLineNumbers (format["functions\%1", _path])), true];
} else {
  missionNamespace setVariable [_functionName, compileFinal(preprocessFileLineNumbers (format["functions\%1", _path])), true];
};
_functionName;
["TRACE", format["Defined function: %1", _functionName], _path] call EMF_DEBUG;

// use compileFinal if debug is disabled
