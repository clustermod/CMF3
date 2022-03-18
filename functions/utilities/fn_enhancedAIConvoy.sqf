/*
 * Author: Tova
 * Enhances AI pathing and convoy behaviour
 *
 * Arguments:
 * 0: group <GROUP>
 * 1: speed <NUMBER>
 * 2: dispersion <NUMBER>
 * 3: pushThrough <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [myGroup, 60, 20, true] call emf_utilities_fnc_enhancedAIConvoy
 *
 * Public: Yes
 */

_this spawn {
  params ["_convoyGroup", ["_convoySpeed",50], ["_convoySeparation",50], ["_pushThrough", true]];
  if (_pushThrough) then {
    _convoyGroup enableAttack !(_pushThrough);
    {(vehicle _x) setUnloadInCombat [false, false];} forEach (units _convoyGroup);
  };
  _convoyGroup setFormation "COLUMN";
  {
    (vehicle _x) limitSpeed _convoySpeed*1.15;
    (vehicle _x) setConvoySeparation _convoySeparation;
  } forEach (units _convoyGroup);
  (vehicle leader _convoyGroup) limitSpeed _convoySpeed;
  while {sleep 5; !isNull _convoyGroup} do {
    {
      if ((speed vehicle _x < 5) && (_pushThrough || (behaviour _x != "COMBAT"))) then {
        (vehicle _x) doFollow (leader _convoyGroup);
      };
    } forEach (units _convoyGroup) - (crew (vehicle (leader _convoyGroup))) - allPlayers;
    {
      (vehicle _x) setConvoySeparation _convoySeparation;
    } forEach (units _convoyGroup);
  };
};
