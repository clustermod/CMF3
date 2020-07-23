/*
 * Author: KillzoneKid, Eric
 * Keeps a consistent size on map markers regrardless of player map zoom.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call EMF_fnc_resizeMapMarkers
 *
 * public: Yes
*/

disableSerialization;

[] spawn {
    waitUntil {!isNull findDisplay 12};

    // Create map controls for user defined variables
    (findDisplay 12) ctrlCreate ["BTN_ToggleResize", -1];
    (findDisplay 12) ctrlCreate ["EDT_MarkerSize", -1];
    (findDisplay 12) ctrlCreate ["ST_MarkerSizeText", -1];

    // Change map marker size
    findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", {
        if (visibleMap && (profileNamespace getVariable ['EMF_RMM_Enabled', true])) then {
              // get the user defined size and apply to all markers
              private _scale = (profileNamespace getVariable ['EMF_RMM_SIZE', 0.2]) / ctrlMapScale (_this select 0);
              {
                  private _m = "#markerSize_" + _x;
                  if (markerShape _x == "ICON" && markerType _x != "respawn_inf") then {
                      if (isNil {missionNamespace getVariable _m}) then {
                          missionNamespace setVariable [_m, markerSize _x];
                      };
                      _x setMarkerSizeLocal [
                          ((missionNamespace getVariable _m) select 0) * _scale,
                          ((missionNamespace getVariable _m) select 1) * _scale
                      ];
                  };
              } forEach allMapMarkers;
        } else {
          {
              // If user disables this feature reset map marker to normal size
              if (markerShape _x == "ICON" && markerType _x != "respawn_inf") then {
                  _x setMarkerSizeLocal [1,1];
              };
          } forEach allMapMarkers;
        };
    }];
};
