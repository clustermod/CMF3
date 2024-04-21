#include "script_component.hpp"
/*
 * Author: Eric
 * Returns weather descriptors
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * Weather Descriptors <ARRAY>
 *	- Description <STRING>
 *	- Temperature <STRING>
 *	- Wind Speed and Direction <STRING>
 *	- Humidity <STRING>
 *	- Moon Phase <STRING>
 * 
 * Example:
 * call cmf_environment_fnc_getWeatherDescriptors
 * 
 * Public: Yes
 */

private _date = date;

private _overcast = switch true do {
    case (overcast >= 0.0 && { overcast < 0.125 }): { "Clear" };
    case (overcast > 0.125 && { overcast < 0.375 }): { "Mostly Clear" };
    case (overcast > 0.375 && { overcast < 0.625 }): { "Partly Cloudy" };
    case (overcast > 0.625 && { overcast < 0.875 }): { "Mostly Cloudy" };
    case (overcast > 0.875 && { overcast <= 1 }): { "Cloudy" };
    default { "Clear" };
};

private _rain = switch true do {
    case (rain >= 0.0 && { rain < 0.125 }): { "Clear" };
    case (rain > 0.125 && { rain < 0.375 }): { "Light Shower" };
    case (rain > 0.375 && { rain < 0.625 }): { "Light Rain" };
    case (rain > 0.625 && { rain < 0.875 }): { "Rain" };
    case (rain > 0.875 && { rain <= 1 }): { "Heavy Rain" };
    default { "Clear" };
};

private _fog = switch true do {
    case (fog >= 0.0 && { fog < 0.125 }): { "Clear" };
    case (fog > 0.125 && { fog < 0.375 }): { "Light Fog" };
    case (fog > 0.375 && { fog < 0.625 }): { "Moderate Fog" };
    case (fog > 0.625 && { fog < 0.875 }): { "Fog" };
    case (fog > 0.875 && { fog <= 1 }): { "Heavy Fog" };
    default { "Clear" };
};

private _wind = format["%2° at %1m/s", [(wind call CBA_fnc_vect2Polar) select 0, 1, 2] call CBA_fnc_formatNumber, round ((wind call CBA_fnc_vect2Polar) select 1)];
private _humidity = format["%1", round ((ace_weather_currentHumidity * 100 * 10) / 10)] + "%";
private _temperature = format["%1°C", round (ambientTemperature select 0)];

private _moonPhase = switch true do {
    case (moonPhase date >= 0.0 && { moonPhase date < 0.25 }): { "New Moon" };
    case (moonPhase date > 0.25 && { moonPhase date < 0.5 }): { "Crescent Moon" };
    case (moonPhase date > 0.5 && { moonPhase date < 0.75 }): { "Quarter Moon" };
    case (moonPhase date > 0.75 && { moonPhase date < 0.9 }): { "Gibbous Moon" };
    case (moonPhase date > 0.9 && { moonPhase date <= 1.0 }): { "Full Moon" };
    default { "Clear" };
};

private _description = if (toUpper _rain != "CLEAR") then { _rain } else { if (toUpper _fog != "CLEAR") then { _fog } else { _overcast } };

[
    _description,
    _temperature,
    _wind,
    _humidity,
    _moonPhase
];