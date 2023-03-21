#include "script_component.hpp"
/*
 * Author: Eric
 * Creates an environment overview for mission in diary
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_gameplay_fnc_environment
 *
 * Public: No
 */

waituntil {!isNull player && alive player};
player createDiarySubject ["cmf_environment", "Environment"];

addMissionEventHandler ["Map", {
	params ["_mapIsOpened"];

    if (!_mapIsOpened) then {
        /* Remove outdated environment */
        {
            player removeDiaryRecord ["cmf_environment", _x select 8]
        } forEach (player allDiaryRecords "cmf_environment");
    } else {
        /* Date */
		private _date = date;

		private _overcast = switch (true) do {
			case (overcast >= 0.0 && overcast < 0.125): { "Clear" };
			case (overcast > 0.125 && overcast < 0.375): { "Mostly Clear" };
			case (overcast > 0.375 && overcast < 0.625): { "Partly Cloudy" };
			case (overcast > 0.625 && overcast < 0.875): { "Mostly Cloudy" };
			case (overcast > 0.875 && overcast <= 1): { "Cloudy" };
			default { "Clear" };
		};

		private _rain = switch (true) do {
			case (rain >= 0.0 && rain < 0.125): { "Clear" };
			case (rain > 0.125 && rain < 0.375): { "Light Shower" };
			case (rain > 0.375 && rain < 0.625): { "Light Rain" };
			case (rain > 0.625 && rain < 0.875): { "Rain" };
			case (rain > 0.875 && rain <= 1): { "Heavy Rain" };
			default { "Clear" };
		};

		private _fog = switch (true) do {
			case (fog >= 0.0 && fog < 0.125): { "Clear" };
			case (fog > 0.125 && fog < 0.375): { "Light Fog" };
			case (fog > 0.375 && fog < 0.625): { "Moderate Fog" };
			case (fog > 0.625 && fog < 0.875): { "Fog" };
			case (fog > 0.875 && fog <= 1): { "Heavy Fog" };
			default { "Clear" };
		};

		private _wind = format["%2° at %1m/s", [(wind call CBA_fnc_vect2Polar) select 0, 1, 2] call CBA_fnc_formatNumber, round ((wind call CBA_fnc_vect2Polar) select 1)];
		private _humidity = format["%1", humidity] + "%";
		private _temperature = format["%1°C", round (ambientTemperature select 0)];

		private _moonPhase = switch (true) do {
			case ((moonPhase date) >= 0.0 && (moonPhase date) < 0.25): { "New Moon" };
			case ((moonPhase date) > 0.25 && (moonPhase date) < 0.5): { "Crescent Moon" };
			case ((moonPhase date) > 0.5 && (moonPhase date) < 0.75): { "Quarter Moon" };
			case ((moonPhase date) > 0.75 && (moonPhase date) < 0.9): { "Gibbous Moon" };
			case ((moonPhase date) > 0.9 && (moonPhase date) <= 1.0): { "Full Moon" };
			default { "Clear" };
		};

		private _description = if (toUpper _rain != "CLEAR") then { _rain } else { if (toUpper _fog != "CLEAR") then { _fog } else { _overcast } };

		private _weatherText =  [
			format["<font size='15'>%1</font>", _description],
			format["<font size='16'>%1</font>", _temperature],
			format["<font size='11' color='#fcba03'>Wind: <font color='#ffffff'>%1</font></font>", _wind],
			format["<font size='11' color='#fcba03'>Humidity: <font color='#ffffff'>%1</font></font>", _humidity],
			format["<font size='11' color='#fcba03'>Moon Phase: <font color='#ffffff'>%1</font></font>", _moonPhase]
		];
		_weatherText = _weatherText joinString "<br/>";

		/* Get Dawn and Dusk Times */
		_dawnDuskText = [
			_date call {
				[_this, -2] call EFUNC(utility,getTimeOfSunAngle) params ["", "", "", "_hour", "_minute"];
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", _hour, [(_minute), 2] call CBA_fnc_formatNumber, "Astronomical Dawn"];
			},
			_date call {
				[_this, -6] call EFUNC(utility,getTimeOfSunAngle) params ["", "", "", "_hour", "_minute"];
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", _hour, [(_minute), 2] call CBA_fnc_formatNumber, "Nautical Dawn"];
			},
			_date call {
				[_this, -12] call EFUNC(utility,getTimeOfSunAngle) params ["", "", "", "_hour", "_minute"];
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", _hour, [(_minute), 2] call CBA_fnc_formatNumber, "Civil Dawn"];
			},
			_date call {
				private _sunrise = (_this call BIS_fnc_sunriseSunsetTime) select 0;
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", floor _sunrise, [((_sunrise * 60) % 60), 2] call CBA_fnc_formatNumber, "Sunrise"];
			},
			_date call {
				private _sundown = (_this call BIS_fnc_sunriseSunsetTime) select 1;
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", floor _sundown, [((_sundown * 60) % 60), 2] call CBA_fnc_formatNumber, "Sunset"];
			},
			_date call {
				[_this, 12] call EFUNC(utility,getTimeOfSunAngle) params ["", "", "", "_hour", "_minute"];
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", _hour, [(_minute), 2] call CBA_fnc_formatNumber, "Civil Dusk"];
			},
			_date call {
				[_this, 18] call EFUNC(utility,getTimeOfSunAngle) params ["", "", "", "_hour", "_minute"];
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", _hour, [(_minute), 2] call CBA_fnc_formatNumber, "Nautical Dusk"];
			},
			_date call {
				[_this, 24] call EFUNC(utility,getTimeOfSunAngle) params ["", "", "", "_hour", "_minute"];
				format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", _hour, [(_minute), 2] call CBA_fnc_formatNumber, "Astronomical Dusk"];
			}
		];
		_dawnDuskText = _dawnDuskText joinString "<br/>";

        player createDiaryRecord ["cmf_environment", ["Weather", _weatherText]];
        player createDiaryRecord ["cmf_environment", ["Dawn & Dusk (not accurate as of v2.1.1.46)", _dawnDuskText]];
    };
}];