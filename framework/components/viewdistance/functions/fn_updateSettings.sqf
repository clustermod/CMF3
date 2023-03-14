#include "script_component.hpp"
/*
 * Author: Eric
 * Update settings
 *
 * Arguments:
 * 0: Update Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["view"] call cmf_viewdistance_fnc_updateSettings
 *
 * Public: No
 */
SCRIPT(updateSettings);

private _updateType = [_this, 0, 0, [0]] call BIS_fnc_param;

private _fnc_fovViewdistance = {
	private ["_ret"];

	private _minViewDistance = [_this, 0, 0, [0]] call BIS_fnc_param;
	_ret = _minViewDistance;

	private _zoom = round (([0.5,0.5] distance2D worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2 * 30) / 10;
	if (_zoom >= 1) then {
		_ret = _minViewDistance + ((12000 / 74) * (_zoom - 1)) min viewDistance;
	};

	_ret
};

switch (_updateType) do {
	case 1: {
		switch (GVAR(vehType)) do {
			case 0: {setViewDistance GVAR(foot)};
			case 1: {setViewDistance GVAR(car)};
			case 2: {setViewDistance GVAR(air)};
		};
	};
	case 2: {
		switch (GVAR(vehType)) do {
			case 0: {setObjectViewDistance GVAR(footObj)};
			case 1: {setObjectViewDistance GVAR(carObj)};
			case 2: {setObjectViewDistance GVAR(airObj)};
		};
	};
	case 4: {
		switch (GVAR(vehType)) do {
			case 0: {setObjectViewDistance ([GVAR(footObj)] call _fnc_fovViewdistance)};
			case 1: {setObjectViewDistance ([GVAR(carObj)] call _fnc_fovViewdistance)};
			case 2: {setObjectViewDistance ([GVAR(airObj)] call _fnc_fovViewdistance)};
		};
	};
	default {
		switch (GVAR(vehType)) do {
			case 0: {setViewDistance GVAR(foot); setObjectViewDistance GVAR(footObj)};
			case 1: {setViewDistance GVAR(car); setObjectViewDistance GVAR(carObj)};
			case 2: {setViewDistance GVAR(air); setObjectViewDistance GVAR(airObj)};
		};
	};
};

if (_updateType isEqualTo 0) then {
	switch (GVAR(vehType)) do {
		case 0: {setTerrainGrid GVAR(footTerrain)};
		case 1: {setTerrainGrid GVAR(carTerrain)};
		case 2: {setTerrainGrid GVAR(airTerrain)};
	};
};
