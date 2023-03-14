/*
 * Author: Eric
 * Will fullheal unit when placed into vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [myMEV] execVM "rsc\scripts\fullhealVehicle.sqf"
 *
 * Public: Yes
 */

params ["_veh"];

kat_pharma_originalSwayFactor = 0;

_veh addEventHandler ["GetIn", {
	_this spawn {
		params ["_vehicle", "", "_unit", ""];

		if (count crew _vehicle > 0) then {
			private _medic = ((crew _vehicle) select 0);
			if (isPlayer _unit) then {
				[[_medic, _unit], {
					private _handle = [format ["%1 is working on you", name (_this select 0)], -1, -1, 10, 0, 0, ("cmf_layer_medical" call BIS_fnc_rscLayer)] spawn BIS_fnc_dynamicText;
					sleep 10;
					[(_this select 0), (_this select 1)] call ace_medical_treatment_fnc_fullHeal;
					terminate _handle;
					("cmf_layer_medical" call BIS_fnc_rscLayer) cutText ["","plain"];
					private _handle = ["You've been healed", -1, -1, 4, 0, 0, ("cmf_layer_medicalDone" call BIS_fnc_rscLayer)] spawn BIS_fnc_dynamicText;

				}] remoteExec ["spawn", _unit];
			} else {
				[_medic, _unit] call ace_medical_treatment_fnc_fullHeal;
			}
		};
	};
}];
