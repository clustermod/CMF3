/*
 * Author: Eric
 * sets AI Skill to be more balanced. Launched postInit, do not call this!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * public: Yes
*/

// Create a inline function to set skills on supplied unit
EMF_fnc_SS_setSkill =
{
  params["_unit"];
  _unit setSkill ["aimingAccuracy", 	0.3 ];
  _unit setSkill ["aimingShake", 	0.5 ];
  _unit setSkill ["aimingSpeed", 	0.3 ];
  _unit setSkill ["spotDistance", 	0.2 ];
  _unit setSkill ["spotTime", 	0.5 ];
  _unit setSkill ["courage", 	0.5 ];
  _unit setSkill ["commanding", 	0.5 ];
  _unit setSkill ["general", 	0.4 ];
  _unit setSkill ["reloadSpeed", 	0.5 ];
  _unit setSkill ["endurance", 	0.5 ];
};
publicVariable "EMF_fnc_SS_setSkill";

// Add a eventhandler to run the function each time a unit is placed in zeus
{
  _x addEventHandler ['CuratorObjectPlaced',{
    private _entity = _this select 1;
    [_entity] remoteExecCall ["EMF_fnc_SS_setSkill", 0, true];
  }];
} forEach AllCurators;

// Set skill on all eden spawned AI
{
    if (!isPlayer _x) then {
      [_x] remoteExecCall ["EMF_fnc_SS_setSkill", 0, true];
    }
} forEach allUnits;
