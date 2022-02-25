/*
 * Author: Eric
 * Sets role and team of supplied unit, is required for most of EMF functions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Role <STRING>
 * 2: Team <NUMBER>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [this, "SL", 0] call emf_gameplay_fnc_EMFRoleSet
 *
 * public: Yes
*/
scriptName "functions\gameplay\fn_setRole.sqf";
params["_obj", "_role", ["_team", 0]];

//Set team variable
_obj setVariable ["emf_utilities_setRole_team", _team, true];

//Check if _role exists and is valid
if (isNil "_role") then {
  ["WARN", 'Units role is not set, setting default role to "RFL"', "setRole", "gameplay"] call EMF_DEBUG;
  //Set role variable to default
  _obj setVariable ["emf_utilities_setRole_role", "RFL", true];
  false;
} else {
  if ((typeName _role) == "STRING") then {
    //Set role variable to _role
    _obj setVariable ["emf_utilities_setRole_role", _role, true];
    true;
  } else {
    ["WARN", 'Units role is not a string, setting default role to "RFL"', "setRole", "gameplay"] call EMF_DEBUG;
    //Set role variable to default
    _obj setVariable ["emf_utilities_setRole_role", "RFL", true];
    false;
  };
};
