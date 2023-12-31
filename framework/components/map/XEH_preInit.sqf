#include "script_component.hpp"

call FUNC(mapTexture);
call FUNC(resizeMarkers);

[QGVAR(writeText), FUNC(writeText)] call CBA_fnc_addEventHandler;
[QGVAR(drawBorder), FUNC(drawBorder)] call CBA_fnc_addEventHandler;
[QGVAR(drawArrow), FUNC(drawArrow)] call CBA_fnc_addEventHandler;
[QGVAR(drawRoute), FUNC(drawRoute)] call CBA_fnc_addEventHandler;
[QGVAR(coverMap), FUNC(coverMap)] call CBA_fnc_addEventHandler;

[{
    if ((cmf_player getVariable [QGVAR(visibleMap), false]) isEqualTo visibleMap) exitWith {};

    [cmf_player, QGVAR(visibleMap), visibleMap] call CBA_fnc_setVarNet;
}] call CBA_fnc_addPerFrameHandler;