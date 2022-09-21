#include "script_component.hpp"
/*
 * Author: Eric
 * Update vehicle type
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_viewdistance_fnc_updateSettings
 *
 * Public: No
 */
SCRIPT(updateVehType);

GVAR(inUAV) = if ((if ((UAVControl (getConnectedUAV player) select 1) isEqualTo "") then { 0 } else { 1 }) isEqualTo 0) then { false } else { true };

if (GVAR(inUAV)) then {
	switch (true) do {
		case (getConnectedUAV player isKindOf "LandVehicle" || getConnectedUAV player isKindOf "Ship"): {
			GVAR(vehType) = 1;
		};
		case (getConnectedUAV player isKindOf "Man"): {
			GVAR(vehType) = 0;
		};
		default {
			GVAR(vehType) = 2;
		};
	};
} else {
	switch (true) do {
		case (vehicle player isKindOf "LandVehicle" || vehicle player isKindOf "Ship"): {
			GVAR(vehType) = 1;
		};
		case (vehicle player isKindOf "Air"): {
			GVAR(vehType) = 2;
		};
		default {
			GVAR(vehType) = 0;
		};
	};
};
