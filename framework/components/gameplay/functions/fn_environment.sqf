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

[{ !isNull player && alive player }, {
    player createDiarySubject ["cmf_environment", "Environment"];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) then {
            /* Remove outdated environment */
            {
                player removeDiaryRecord ["cmf_environment", _x select 8]
            } forEach (player allDiaryRecords "cmf_environment");
        } else {
            private _date = date;
            private _weather = [] call EFUNC(utility,getWeatherDescriptors);

            private _weatherText =  [
                format["<font size='15'>%1</font>", _weather select 0],
                format["<font size='16'>%1</font>", _weather select 1],
                format["<font size='11' color='#fcba03'>Wind: <font color='#ffffff'>%1</font></font>", _weather select 2],
                format["<font size='11' color='#fcba03'>Humidity: <font color='#ffffff'>%1</font></font>", _weather select 3],
                format["<font size='11' color='#fcba03'>Moon Phase: <font color='#ffffff'>%1</font></font>", _weather select 4]
            ];
            _weatherText = _weatherText joinString "<br/>";

            /* Get Dawn and Dusk Times */
            _dawnDuskText = [
                _date call {
                    private _sunrise = (_this call BIS_fnc_sunriseSunsetTime) select 0;
                    format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", floor _sunrise, [((_sunrise * 60) % 60), 2] call CBA_fnc_formatNumber, "Sunrise"];
                },
                _date call {
                    private _sundown = (_this call BIS_fnc_sunriseSunsetTime) select 1;
                    format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", floor _sundown, [((_sundown * 60) % 60), 2] call CBA_fnc_formatNumber, "Sunset"];
                }
            ];
            _dawnDuskText = _dawnDuskText joinString "<br/>";

            player createDiaryRecord ["cmf_environment", ["Weather", _weatherText]];
            player createDiaryRecord ["cmf_environment", ["Dawn & Dusk", _dawnDuskText]];
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;