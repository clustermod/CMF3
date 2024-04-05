#include "..\..\components\diagnostic\script_component.hpp"

// @TODO: Finish this UI
class GVAR(tool) {
    idd = -1;
    access = 1;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = QUOTE(call FUNC(dialogInit));
    onUnload = "";
    class controlsBackground {};

    class controls {
        class title: RscText {
            text = QUOTE(FRAMEWORK: Debug Console);
            SizeEx = (GUI_GRID_H * 1.2);
            x = DIALOG_X(0);
            y = DIALOG_Y(0);
            w = CONTROL_WIDTH(5);
            h = CONTROL_HEIGHT(1.3);
        };
    };
};