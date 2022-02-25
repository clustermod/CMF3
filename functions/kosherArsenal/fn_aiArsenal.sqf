/*
 * Author: Eric
 * kosher arsenal for AI
 *
 * Arguments:
 * 0: side <SIDE>
 * 1: file <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [east, "exampleLoadout"] call emf_kosherArsenal_fnc_aiArsenal
 *
 * Public: Yes
 */
scriptName "functions\kosherArsenal\fn_aiArsenal.sqf";
params["_side", "_loadoutFile"];

missionNamespace setVariable ["emf_kosherai_enabled", true, true];
missionNamespace setVariable ["emf_kosherai_side", _side, true];
missionNamespace setVariable ["emf_kosherai_loadoutFile", _loadoutFile, true];

// Initialize preplaced units
{
  if (side _x isEqualTo _side) then {
    private _role = [_x] call emf_fnc_setAIType;
    [_role, objnull, false, _x, true] execVM format["rsc\loadouts\%1.sqf", _loadoutFile];
    ["_role", "_obj", "_rearmOnly", "_unit", ["_rand", false]]
  };
} forEach allUnits;
