#include "script_component.hpp"

[] call FUNC(updateViewDistance);

FUNC(changedControllableObject) = {
    params ["_object"];
    private _type = typeOf _object;
    
    if (_type == "") exitWith {};

    [{
        [QGVAR(changedControllableObject), _this] call CBA_fnc_localEvent;
    }, [_type]] call CBA_fnc_execNextFrame;
};

["unit", {[_this select 0] call FUNC(changedControllableObject)}, true] call CBA_fnc_addPlayerEventHandler;
["vehicle", {[_this select 1] call FUNC(changedControllableObject)}, true] call CBA_fnc_addPlayerEventHandler;
["ACE_controlledUAV", {[_this select 0] call FUNC(changedControllableObject)}] call CBA_fnc_addEventHandler;

[QGVAR(changedControllableObject), {
    params ["_type"];

    if (_type isKindOf "Man") exitWith {
        if ((missionNamespace getVariable [QGVAR(vehicleType), ""]) == "INFANTRY") exitWith {};
        GVAR(vehicleType) = "INFANTRY";
        [] call FUNC(updateViewDistance);
    };

    if (_type isKindOf "LandVehicle" || _type isKindOf "Ship") exitWith {
        if ((missionNamespace getVariable [QGVAR(vehicleType), ""]) == "VEHICLE") exitWith {};
        GVAR(vehicleType) = "VEHICLE";
        [] call FUNC(updateViewDistance);
    };

    if (_type isKindOf "Air") exitWith {
        if ((missionNamespace getVariable [QGVAR(vehicleType), ""]) == "AIR") exitWith {};
        GVAR(vehicleType) = "AIR";
        [] call FUNC(updateViewDistance);
    };
}] call CBA_fnc_addEventHandler;