#include "script_component.hpp"
/*
 * Author: Willem-Matthijs Crielaard, Eric
 * Return the time the sun reaches the angle in degrees
 *
 * Arguments:
 * 0: date <ARRAY>
 * 1: angle <NUMBER>
 *
 * Return Value:
 * Date <ARRAY>
 *
 * Example:
 * date call cmf_utility_fnc_getTimeOfSunAngle
 *
 * Public: yes
 */

/* ARMA 3 seems to have its equinox off by a few days */
#define EQUINOX_ERROR 2

/* Equinox - 360 is the number of orbital degrees per year, 365 the number of days per year. 81 accounts for march equinox */
#define EQUINOX_MAR ((360 * dateToNumber _date) - (360 * (81 + EQUINOX_ERROR) / 365))
// @TODO: Move to new module environment
params [["_date", date], ["_wantedAngle", -12]];

/* lookup and calculate input variables */
private _latitude = missionNamespace getVariable ["sunAngle_cache_latitude", -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude")];
missionNamespace setVariable ["sunAngle_cache_latitude", _latitude];
private _declination = (asin (sin 23.45 * sin EQUINOX_MAR));                    // current earth tilt irl to the sun in degrees
//private _hra = (360 * ((_date select 3) + (_date select 4) / 60 - 12) / 24);	// solar hour angle in degrees; 360 degrees per 24 hours, times the current hour
private _return = [];

private _hra = -tan _latitude * tan _declination;

/* Calculate the time at that angle */
private _hour = _wantedAngle + acos _hra / 15;
_hour = [_hour, -_hour] select (_hour < 0);

_return = _date;
_return set [3, floor _hour];
_return set [4, round ((_hour * 60) % 60)];

_return;