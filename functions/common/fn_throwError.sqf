/*
 * Author: Eric
 * throws an error and logs it.
 *
 * Arguments:
 * 0: Error <STRING>
 * 1: Function <STRING>
 * 2: Category <STRING>
 *
 * Return Value:
 * None <NIL>
 *
 * Example:
 * ["divided by zero", "mathFunction", "mathCategory"] call emf_fnc_throwError
 *
 * Public: Yes
 */
scriptName "functions\common\fn_throwError.sqf";
params[["_error", ""], ["_function", ""], ["_category", ""]];

if (_error isEqualTo "") exitWith {
  ["missing error string", _category, _function, _error] call BIS_fnc_error;
  ["[emf_fnc_throwError] missing error string", _category, _function, _error] call BIS_fnc_log;
};

if (_function isEqualTo "") exitWith {
    if (_category isEqualTo "") exitWith {
      ["%1", _error] call BIS_fnc_error;
      ["%1", _error] call BIS_fnc_log;
    };

    ["[%1] %2", _category, _error] call BIS_fnc_error;
    ["[%1] %2", _category, _error] call BIS_fnc_log;
};

if (_category isEqualTo "") exitWith {
    if (_function isEqualTo "") exitWith {
      ["%1", _error] call BIS_fnc_error;
      ["%1", _error] call BIS_fnc_log;
    };

    ["[%1] %2", _category, _error] call BIS_fnc_error;
    ["[%1] %2", _category, _error] call BIS_fnc_log;
};

["[%1] [%2] %3", _category, _function, _error] call BIS_fnc_error;
["[%1] [%2] %3", _category, _function, _error] call BIS_fnc_log;
