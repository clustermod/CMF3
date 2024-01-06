#include "script_component.hpp"

call FUNC(setLivesModule);
call FUNC(forceArsenalModule);
call FUNC(ammoboxModule);
call FUNC(resetKosherRoleModule);
call FUNC(kosherForceCloseModule);
call FUNC(disableFreezeTime);
call FUNC(toggleSpectatorModule);
call FUNC(addRallypointModule);
call FUNC(removeRallypointModule);
call FUNC(playerInfo);
call FUNC(safestartPhases);
call FUNC(safestartCutoffPhases);

GVAR(zeusInfoShow) = true;

/* curator displayInit */
private _displayInitEvent = {
    params ["_self"];

    [findDisplay 312] call FUNC(initDisplayCurator);

    [
        { isNull findDisplay 312 },
        {
            params ["_displayInitEvent"];

            [
                { !isNull findDisplay 312 },
                _displayInitEvent,
                [_displayInitEvent]
            ] call CBA_fnc_waitUntilAndExecute;
        },
        [_self]
    ] call CBA_fnc_waitUntilAndExecute;
};

[
    { !isNull findDisplay 312 },
    _displayInitEvent,
    [_displayInitEvent]
] call CBA_fnc_waitUntilAndExecute;

[QGVAR(toggleZeusInfo), {
    GVAR(zeusInfoShow) = !GVAR(zeusInfoShow);
}] call CBA_fnc_addEventHandler;

/* Show icon for rallypoints and artillery */
addMissionEventHandler ["Draw3D", {
    if (isNull curatorCamera || !GVAR(zeusInfoShow)) exitWith {};
    
    {
        drawIcon3D [getMissionPath "components\respawn\data\icon_ace_rallypoint_place_ca.paa", [1,1,1,0.7], ASLToAGL getPosASLVisual _x, 0.5, 0.5, 0];
    } forEach EGVAR(respawn,rallypoints);

    {
        _x params ["_side", "_target", "_mainSalvo"];
        drawIcon3D ["a3\ui_f\data\gui\cfg\communicationmenu\artillery_ca.paa", [1,1,1,0.7], _target, 0.5, 0.5, 0, format ["Fire Mission (%1): %2", _side, _mainSalvo]];
    } forEach EGVAR(ai,artilleryTargets);
}];