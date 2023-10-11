#include "\a3\ui_f\hpp\definedikcodes.inc"
#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes the viewdistance component and loads player's previous settings
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_viewdistance_fnc_init
 *
 * Public: No
 */
 SCRIPT(init);

[] spawn {
    if (!hasInterface) exitWith {};

    waitUntil { time > 0 };

    /* Load saved settings */
    GVAR(maxView) = if (isNil QGVAR(maxView)) then { 12000 } else { GVAR(maxView) };
    GVAR(maxObj) = if (isNil QGVAR(maxObj)) then { 12000 } else { GVAR(maxObj) };

    GVAR(footSyncMode) = profileNamespace getVariable [QGVAR(footSyncMode), 0];
    GVAR(footSyncPercentage) = profileNamespace getVariable [QGVAR(footSyncPercentage), 0.8];
    GVAR(carSyncMode) = profileNamespace getVariable [QGVAR(carSyncMode), 0];
    GVAR(carSyncPercentage) = profileNamespace getVariable [QGVAR(carSyncPercentage), 0.8];
    GVAR(airSyncMode) = profileNamespace getVariable [QGVAR(airSyncMode), 0];
    GVAR(airSyncPercentage) = profileNamespace getVariable [QGVAR(airSyncPercentage), 0.8];

    GVAR(foot) = (profileNamespace getVariable [QGVAR(foot),viewDistance]) min GVAR(maxView);
    GVAR(car) = (profileNamespace getVariable [QGVAR(car),viewDistance]) min GVAR(maxView);
    GVAR(air) = (profileNamespace getVariable [QGVAR(air),viewDistance]) min GVAR(maxView);

    GVAR(footObj) = (profileNamespace getVariable [QGVAR(footObj),viewDistance]) min GVAR(maxObj) min GVAR(maxView);
    GVAR(footObj) = if (GVAR(footSyncMode) isEqualTo 1) then { GVAR(foot) * GVAR(footSyncPercentage) } else { GVAR(footObj) };
    GVAR(carObj) = (profileNamespace getVariable [QGVAR(carObj),viewDistance]) min GVAR(maxObj) min GVAR(maxView);
    GVAR(carObj) = if (GVAR(carSyncMode) isEqualTo 1) then { GVAR(car) * GVAR(carSyncPercentage) } else { GVAR(carObj) };
    GVAR(airObj) = (profileNamespace getVariable [QGVAR(airObj),viewDistance]) min GVAR(maxObj) min GVAR(maxView);
    GVAR(airObj) = if (GVAR(airSyncMode) isEqualTo 1) then { GVAR(air) * GVAR(airSyncPercentage) } else { GVAR(airObj) };

    GVAR(footTerrain) = (profileNamespace getVariable [QGVAR(footTerrain),25]) min 48.99 max 3.125;
    GVAR(carTerrain) = (profileNamespace getVariable [QGVAR(carTerrain),25]) min 48.99 max 3.125;
    GVAR(airTerrain) = (profileNamespace getVariable [QGVAR(airTerrain),25]) min 48.99 max 3.125;

    /* Set vehicle type (0: foot, 1: car, 2: air) */
    GVAR(vehType) = 0;

    /* Register keybinds */
    [LSTRING(settings_category_displayname), QGVAR(dec_viewdistance), LSTRING(setting_decrease_vd_displayname), {[0] call FUNC(keyDown)}, "", [26, [false, true, false]], true] call CBA_fnc_addKeybind;
    [LSTRING(settings_category_displayname), QGVAR(inc_viewdistance), LSTRING(settings_increase_vd_displayname), {[1] call FUNC(keyDown)}, "", [27, [false, true, false]], true] call CBA_fnc_addKeybind;

    [LSTRING(settings_category_displayname), QGVAR(open_settings), LSTRING(settings_open_settings_displayname), {call FUNC(openDialog)}, "", [43, [false, true, false]], false] call CBA_fnc_addKeybind;

    [LSTRING(settings_category_displayname), QGVAR(dec_terrain_quality), LSTRING(settings_decrease_terrain_displayname), {[-1] call FUNC(keyDownTerrain)}, "", [26, [true, false, false]], true] call CBA_fnc_addKeybind;
    [LSTRING(settings_category_displayname), QGVAR(inc_terrain_quality), LSTRING(settings_increase_terrain_displayname), {[1] call FUNC(keyDownTerrain)}, "", [27, [true, false, false]], true] call CBA_fnc_addKeybind;

    /* Begin initialization */
    waitUntil {!isNull player};
    waitUntil {!isNull findDisplay 46};

    /* Reset obj view distance so game doesn't lag when browsing menues and so on, if FOV method was used during the game */
    (findDisplay 46) displayAddEventHandler ["Unload", { call FUNC(updateSettings) }];

    [] call FUNC(updateVehType);
    [] call FUNC(updateSettings);

    /* Detect when to change setting type */
    [] spawn {
        for "_i" from 0 to 1 step 0 do {
            private _currentVehicle = vehicle player;
            waitUntil {_currentVehicle != vehicle player};
            [] call FUNC(updateVehType);
            if (
                (GVAR(vehType) isEqualTo 0 && GVAR(footSyncMode) isEqualTo 2) ||
                (GVAR(vehType) isEqualTo 1 && GVAR(carSyncMode) isEqualTo 2) ||
                (GVAR(vehType) isEqualTo 2 && GVAR(airSyncMode) isEqualTo 2)
            ) then {
                [1] call FUNC(updateSettings);
                switch (GVAR(vehType)) do {
                    case 0: {setTerrainGrid GVAR(footTerrain)};
                    case 1: {setTerrainGrid GVAR(carTerrain)};
                    case 2: {setTerrainGrid GVAR(airTerrain)};
                };
                [4] call FUNC(updateSettings)
            } else {
                [] call FUNC(updateSettings);
            };
        };
    };

    [] spawn {
        for "_i" from 0 to 1 step 0 do {
            private _UAVstatus = if ((UAVControl (getConnectedUAV player) select 1) isEqualTo "") then { 0 } else { 1 };
            waitUntil { _UAVstatus != if ((UAVControl (getConnectedUAV player) select 1) isEqualTo "") then { 0 } else { 1 } };
            [] call FUNC(updateVehType);
            if (
                (GVAR(vehType) isEqualTo 0 && GVAR(footSyncMode) isEqualTo 2) ||
                (GVAR(vehType) isEqualTo 1 && GVAR(carSyncMode) isEqualTo 2) ||
                (GVAR(vehType) isEqualTo 2 && GVAR(airSyncMode) isEqualTo 2)
            ) then {
                [1] call FUNC(updateSettings);
                switch (GVAR(vehType)) do {
                    case 0: {setTerrainGrid GVAR(footTerrain)};
                    case 1: {setTerrainGrid GVAR(carTerrain)};
                    case 2: {setTerrainGrid GVAR(airTerrain)};
                };
                [4] call FUNC(updateSettings)
            } else {
                [] call FUNC(updateSettings);
            };
        };
    };

    [] spawn {
        for "_i" from 0 to 1 step 0 do {
            private _currentZoom = (([0.5,0.5] distance2D worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2 * 30) / 10;
            waitUntil {_currentZoom != (([0.5,0.5] distance2D worldToScreen positionCameraToWorld [0,3,4]) * (getResolution select 5) / 2 * 30) / 10};
            if (
                (GVAR(vehType) isEqualTo 0 && GVAR(footSyncMode) isEqualTo 2) ||
                (GVAR(vehType) isEqualTo 1 && GVAR(carSyncMode) isEqualTo 2) ||
                (GVAR(vehType) isEqualTo 2 && GVAR(airSyncMode) isEqualTo 2)
            ) then {[4] call FUNC(updateSettings)};
        };
    };
};
