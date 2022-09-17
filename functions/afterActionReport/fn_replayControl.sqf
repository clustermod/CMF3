#include "script_component.hpp"
/*
 * Author: Eric
 * Handles the playback controller
 *
 * Arguments:
 * 0: Playback data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_myPlayback] call emf_afterActionReport_fnc_replayControl
 *
 * Public: No
 */

/*
 _this spawn {
     params ["_playbackData"];

     private _playbackLength = (_playbackData select 0) select 0;

     private _display = findDisplay 46 createDisplay "emf_afterActionReport_controller";
     (_display displayCtrl 200) sliderSetRange [0, _playbackLength];

     (_display displayCtrl 200) ctrlAddEventHandler ["SliderPosChanged", {
         params ["_control", "_newValue"];
         missionNameSpace setVariable [QGVAR(afterAction_replayUnifiedTime), _newValue, true];
     }];

     (_display displayCtrl 300) ctrlAddEventHandler ["ButtonClick", {
         params ["_control"];

         private _newValue = !(missionNameSpace getVariable [QGVAR(afterAction_replayPaused), false]);
         missionNameSpace setVariable [QGVAR(afterAction_replayPaused), _newValue, true];

         if (_newValue) then {
             ((ctrlParent _control) displayCtrl 301) ctrlSetText "rsc\data\icon_start_ca.paa";
         } else {
             ((ctrlParent _control) displayCtrl 301) ctrlSetText "rsc\data\icon_pause_ca.paa";
         };
     }];

     while {!(_display isEqualTo displayNull)} do {
         private _time = missionNameSpace getVariable [QGVAR(afterAction_replayUnifiedTime), 0];
         private _hrTime = [_time] call BIS_fnc_secondsToString;
         (_display displayCtrl 200) sliderSetPosition _time;
         (_display displayCtrl 201) ctrlSetText _hrTime;
         sleep 0.01;
     };
 };
