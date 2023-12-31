#include "script_component.hpp"
/*
 * Author: Eric
 * Register Group to the CMF ORBAT System
 * 
 * Arguments:
 * 0: Size <STRING> ("FT", "SQD", "PLT", "COY", "BAT")
 * 1: level <STRING> ("FT", "SQD", "PLT", "COY", "BAT")
 * 2: type <STRING>
 * 3: Group <GROUP>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["FT", _myGroup] call cmf_organization_fnc_registerGroup
 * 
 * Public: Yes
 */
if (!isServer) exitWith {};

params ["_size", "_level", "_type", "_group"];

