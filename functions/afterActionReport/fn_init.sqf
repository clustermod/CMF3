#include "script_component.hpp"
/*
 * Author: Eric
 * Records for the after action replay. Saves movement and shot data for unit
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * ["example"] call emf_afterAction_fnc_init
 *
 * Public: No
 */

 // Get config setting
 private _enabled = ( CONFIG_PARAM_3(SETTINGS,init,recordAfterAction) ) isEqualTo 1;
 if !(_enabled) exitWith {};

// [isPlayer, side, group, name, movementData, firedData]
// [classname, movementData, firedData]

// Create variable to hold all captured data
GVAR(allCaptureData) = [];

 // Initialize units and vehicles present at mission start
 {
     private _unitID = GVAR(allCaptureData) pushBack [(isPlayer _x), (side _x), (groupId group _x), (name _x), [], []];
     [_unitID, _x, true] call FUNC(capture);
 } forEach allUnits;

 {
     private _unitID = GVAR(allCaptureData) pushBack [(typeof _x), [], []];
     [_unitID, _x, true] call FUNC(capture);
 } forEach entities [["Car", "Tank", "Air", "Ship"], [], false, true];

 // Make sure things are initialized
 GVAR(afterAction_r_initialized) = true;

 // Add it to new units and vehicles throughout the game
 [] spawn {
     systemChat "[EMF] [afteraction] Started Capture";
     while {!GVAR(EndCapture)} do {
         {
             private _unitID = GVAR(allCaptureData) pushBack [(isPlayer _x), (side _x), (groupId group _x), (name _x), [], []];
             [_unitID, _x, true] call FUNC(capture);
         } forEach allUnits;

         {
             private _unitID = GVAR(allCaptureData) pushBack [(typeof _x), [], []];
             [_unitID, _x, true] call FUNC(capture);
         } forEach entities [["Car", "Tank", "Air", "Ship"], [], false, true];
         uiSleep 1;
     };
     systemChat "[EMF] [afteraction] Stopped Capture";
 };
