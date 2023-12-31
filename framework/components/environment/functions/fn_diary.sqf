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
 * call cmf_gameplay_fnc_environment
 *
 * Public: No
 */

[{ !isNull player && { alive player } }, {
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
            private _weather = call FUNC(getWeatherDescriptors);

            private _weatherText =  [
                format["<font size='15'>%1</font>", _weather select 0],
                format["<font size='16'>%1</font>", _weather select 1],
                format["<font size='11' color='#fcba03'>Wind: <font color='#ffffff'>%1</font></font>", _weather select 2],
                format["<font size='11' color='#fcba03'>Humidity: <font color='#ffffff'>%1</font></font>", _weather select 3],
                format["<font size='11' color='#fcba03'>Moon Phase: <font color='#ffffff'>%1</font></font>", _weather select 4]
            ];
            _weatherText = _weatherText joinString "<br/>";

            /* Get Dawn and Dusk Times */
            private _twilight = call FUNC(getTwilight);
            _twilight = _twilight apply {
                _x params ["_name", "_time"];
                _time params ["_hour", "_minute"];
                private _string = format["<font size='13' color='#fcba03'>%1:%2 <font color='#ffffff'>| %3</font></font>", [_hour, 2] call CBA_fnc_formatNumber, [_minute, 2] call CBA_fnc_formatNumber, _name];

                if ((date select 3) < _hour || (date select 3) < _hour && { (date select 4) < _minute } ) then {
                    private _hours = _hour - (date select 3);
                    private _minutes = abs (_minute - (date select 4)) max 0;
                    _string = _string + format [" <font size='13' color='#fcba03'>%1h %2m</font>", _hours, _minutes];
                };

                _string;
            };
            _twilight = _twilight joinString "<br/>";

            player createDiaryRecord ["cmf_environment", ["Weather", _weatherText]];
            player createDiaryRecord ["cmf_environment", ["Dawn & Dusk", _twilight]];
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;