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
 * None
 *
 * Example:
 * [this, "SL", 0] call EMF_fnc_EMFRoleSet
 *
 * public: Yes
*/

params["_obj", "_role", ["_team", 0]];

//Set team variable
_obj setVariable ["unitTeamRole", _team, true];

//Check if _role exists and is valid
if (isNil "_role") then {
  ['Units role is not set, setting default role to "RFL"'] call BIS_fnc_error;
  'Units role is not set, setting default role to "RFL"' call BIS_fnc_log;
  //Set role variable to default
  _obj setVariable ["unitSquadRole", "RFL", true];
} else {
  if ((typeName _role) == "STRING") then {
    //Set role variable to _role
    _obj setVariable ["unitSquadRole", _role, true];
  } else {
    ['Units role is not a string, setting default role to "RFL"'] call BIS_fnc_error;
    'Units role is not set, setting default role to "RFL"' call BIS_fnc_log;
    //Set role variable to default
    _obj setVariable ["unitSquadRole", "RFL", true];
  };
};
