#include "script_component.hpp"
/*
 * Author: Eric
 * Make unit a hostage
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 * 
 * Example:
 * [this, true, true] call cmf_ai_fnc_hostage
 * 
 * Public: No
 */
params ["_unit", ["_captive", true], ["_blindfold", false]];

_unit disableAI "FSM";
_unit disableAI "AUTOCOMBAT";
[_unit] joinSilent createGroup civilian;
_unit setBehaviour "CARELESS";
_unit setUnloadInCombat [false, false];
_unit setVariable ["lambs_danger_disableAI", true, true];

GVAR(hostage_translateStance) = {
    params ["_stance"];

    if (_stance isEqualTo "STAND") exitWith { "UP" };
    if (_stance isEqualTo "CROUCH") exitWith { "MIDDLE" };
    if (_stance isEqualTo "PRONE") exitWith { "DOWN" };

    "";
};

GVAR(hostage_releaseFNC) = {
    params ["_hostage", "_target"];

    _hostage setVariable [QGVAR(hostage_owner), objNull, true];
    [_hostage] joinSilent createGroup civilian;
    [_hostage getVariable QGVAR(hostage_handler)] call CBA_fnc_removePerFrameHandler;
};

GVAR(hostage_followPlayerFNC) = {
    params ["_hostage", "_target"];

    _hostage setVariable [QGVAR(hostage_owner), _target, true];
    [_hostage] joinSilent createGroup side _target;
    
    private _handle = [{
        (_this select 0) params ["_hostage", "_target"];

        if (!alive _target) exitWith {
            _target setVariable [QGVAR(hostage_owner), objNull, true];
            [_hostage] joinSilent createGroup civilian;
            [_hostage getVariable QGVAR(hostage_handler)] call CBA_fnc_removePerFrameHandler;
        };

        if ((vehicle _target) isEqualTo _target) then {
            if (vehicle _hostage != _hostage) then {
                unassignVehicle _hostage;
            };

            [_hostage] doMove (_target modelToWorld [0, -0.5, 0]);
            _hostage setUnitPos ([stance _target] call GVAR(hostage_translateStance));
        } else {
            if (vehicle _hostage != _hostage) exitWith {
                _hostage moveInCargo [vehicle _target, (vehicle _target) getCargoIndex _hostage];
            };

            private _getSeat = [vehicle _target] call ace_captives_fnc_findEmptyNonFFVCargoSeat;
            _getSeat params ["_cargoIndex"];
            if (_cargoIndex isEqualTo -1) exitWith {};

            _hostage assignAsCargoIndex [vehicle _target, _cargoIndex];
            [_hostage] orderGetIn true;
        }
    }, 0.3, [_hostage, _target]] call CBA_fnc_addPerFrameHandler;

    _hostage setVariable [QGVAR(hostage_handler), _handle, true];
};

if (_captive) then {
    [_unit, true] call ACE_captives_fnc_setHandcuffed;
};

/* Follow player action */
private _followAction = [QGVAR(hostageFollow), "Follow Me!", "", 
    GVAR(hostage_followPlayerFNC), 
    { 
        isNull ((_this select 0) getVariable [QGVAR(hostage_owner), objNull]) &&
        { !((_this select 0) getVariable ["ace_captives_isHandcuffed", false]) }
    }
] call ace_interact_menu_fnc_createAction;

/* Stop following action */
private _stopAction = [QGVAR(hostageFollow), "Stay Here!", "", 
    GVAR(hostage_releaseFNC), 
    { 
        !isNull ((_this select 0) getVariable [QGVAR(hostage_owner), objNull])
    }
] call ace_interact_menu_fnc_createAction;

[_unit, 0, ["ACE_MainActions"], _followAction] call ace_interact_menu_fnc_addActionToObject;
[_unit, 0, ["ACE_MainActions"], _stopAction] call ace_interact_menu_fnc_addActionToObject;

