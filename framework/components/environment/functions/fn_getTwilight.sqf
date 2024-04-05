#include "script_component.hpp"
/*
 * Author: Willem-Matthijs Crielaard, Eric
 * Returns the times of twilight for that day. Horribly unoptimized :(
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Twilight <ARRAY>
 *
 * Example:
 * call cmf_environment_fnc_getTwilight
 *
 * Public: yes
 */

private _twilight = [];
private _date = date;

if (!isNil QGVAR(twilight)) exitWith {
    GVAR(twilight);
};

for '_h' from 0 to 23 do {
    _date set [3, _h];
    for '_m' from 0 to 59 do {
        _date set [4, _m];
        (_date call cmf_environment_fnc_sunAngle) params ["_sunElevation", "_sunAzimuth"];
        
        /* Dawn */
        if (_twilight findIf { "Astronomical Dawn" in _x } isEqualTo -1 && { _sunElevation >= -18 && { _sunElevation < -12 && { _h < 12 } } }) then { _twilight pushBack ["Astronomical Dawn", [_h, _m]] };
        if (_twilight findIf { "Nautical Dawn" in _x } isEqualTo -1 && { _sunElevation >= -12 && { _sunElevation < -6 && { _h < 12 } } }) then { _twilight pushBack ["Nautical Dawn", [_h, _m]] };
        if (_twilight findIf { "Civil Dawn" in _x } isEqualTo -1 && { _sunElevation >= -6 && { _sunElevation < 0 && { _h < 12 } } }) then { _twilight pushBack ["Civil Dawn", [_h, _m]] };
        if (_twilight findIf { "Sunrise" in _x } isEqualTo -1 && { _sunElevation >= 0 && { _h < 12 } }) then { _twilight pushBack ["Sunrise", [_h, _m]] };
        
        /* Dusk */
        if (_twilight findIf { "Sunset" in _x } isEqualTo -1 && { _sunElevation >= 0 && { _h > 12 } }) then { _twilight pushBack ["Sunset", [_h, _m]] };
        if (_twilight findIf { "Civil Dusk" in _x } isEqualTo -1 && { _sunElevation >= -6 && { _sunElevation < 0 && { _h > 12 } } }) then { _twilight pushBack ["Civil Dusk", [_h, _m]] };
        if (_twilight findIf { "Nautical Dusk" in _x } isEqualTo -1 && { _sunElevation >= -12 && { _sunElevation < -6 && { _h > 12 } } }) then { _twilight pushBack ["Nautical Dusk", [_h, _m]] };
        if (_twilight findIf { "Astronomical Dusk" in _x } isEqualTo -1 && { _sunElevation >= -18 && { _sunElevation < -12 && { _h > 12 } } }) then { _twilight pushBack ["Astronomical Dusk", [_h, _m]] };
    };
};

GVAR(twilight) = _twilight;
publicVariable QGVAR(twilight);
_twilight;