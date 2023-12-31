#include "script_component.hpp"
/*
 * Author: Eric
 * Returns a group;s callsign data
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value:
 * Group Callsign Data <ARRAY>
 *
 * Example:
 * [myGroup] call cmf_common_fnc_getCallsign
 *
 * Public: No
 */

params ["_group"];

/* Get callsign */
private _callsign = _group getVariable [QGVAR(sqd_callsign),""];

/* Get Type */
private _type = _group getVariable [QGVAR(sqd_type), ""];

/* Get Size */
private _size = _group getVariable [QGVAR(sqd_size), ""];

[_callsign, _type, _size]
