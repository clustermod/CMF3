#include "script_component.hpp"
/*
 * Author: Eric
 * Sets role and team of supplied unit, is required for most of CMF functions.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Role <STRING> [Default: "RFL"]
 * 2: Team <NUMBER> [Default: 0]
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myUnit, "SL", 0] call cmf_common_fnc_setRole
 *
 * public: Yes
*/
SCRIPT(setRole);
params["_unit", ["_role", "RFL", [""]], ["_team", 0]];

/* Throw error if object is not defined */
if (isNil {(_this select 0)}) exitWith {
    ERROR_MSG("No object");
};

/* Throw warning if role is not defined */
if (isNil {(_this select 1)}) exitWith {
    WARNING("No role, defaulting to ""RFL""");
};

/* Set the objects role */
_unit setVariable [QGVAR(role), _role, true];

/* Set the objects team */
_unit setVariable [QGVAR(team), _team, true];

LOG_3("team %1 and role %2 set for %3", _team, _role, name _unit);

/* Raise event */
[QGVAR(onUnitRoleChanged), _this, _unit] call CBA_fnc_targetEvent;
