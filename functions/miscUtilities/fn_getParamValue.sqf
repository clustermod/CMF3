/*
 * Author: Eric
 * Returns a Parameter from an array by key
 *
 * Arguments:
 * 0: Params <ARRAY>
 * 1: Key <STRING>
 *
 * Return Value:
 * ParamValue <ANY>
 *
 * Example:
 * [[["Param1", "Value1"], ["Param2", 5]], "Param2"] call EMF_fnc_getParamValue
 *
 * Public: Yes
 */
private ["_params", "_key"];
private ["_value"];
params["_params", "_key"];
_value = if (count _this > 2) then { _this select 2 } else { objNull };

  {
    if (_x select 0 == _key) then {
      _value = _x select 1;
    };
  } foreach (_params);

  _value
