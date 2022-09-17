#include "script_component.hpp"
/*
 * Author: Eric
 * Converts azimuth directions to vectorDir
 *
 * Arguments:
 * 0: Direction <NUMBER>
 *
 * Return Value:
 * vectorDir <ARRAY>
 *
 * Example:
 * [270] call emf_utilities_fnc_azimuthToVectorDir
 *
 * Public: Yes
 */
params["_dir"];

// Determine quadrant and special cases then return
private "_return";
switch (true) do {
    case ((_dir > 0) && (_dir < 90) || (_dir > 270) && (_dir < 360)): { _return = [(tan _dir), 1, 0] };
    case ((_dir > 90) && (_dir < 270)): { _return = [-(tan _dir), -1, 0] };
    case (_dir == 90): { _return = [1, 0, 0] };
    case (_dir == 180): { _return = [0, -1, 0] };
    case (_dir == 270): { _return = [-1, 0, 0] };
    default { _return = [0, 1, 0] };
};

// Return vectorDir
_return
