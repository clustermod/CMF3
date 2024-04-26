#include "..\..\components\viewdistance\script_component.hpp"

class GVAR(menu) {
    idd = -1;
    access = 1;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = QUOTE(call FUNC(dialogInit));
    onUnload = "";
    class controlsBackground {};

    class controls {
        class title: RscText {
            text = "CMF: Viewdistance";
            SizeEx = (GUI_GRID_H * 1.2);
            x = SLIDER_X;
            y = SLIDER_Y(0);
            w = SLIDER_WIDTH;
            h = SLIDER_HEIGHT;
        };

        class viewdistance: RscXSliderH {
            idc = IDC_SLIDER_VIEWDISTANCE;
            x = SLIDER_X;
            y = SLIDER_Y(1);
            w = SLIDER_WIDTH;
            h = SLIDER_HEIGHT;
            sliderRange[] = {200, 40000};
            sliderStep = 10;
            colorBackground[] = {0, 0, 0, 0.5};
            color[] = {1, 1, 1, 0.5};
            colorActive[] = {1, 1, 1, 0.5};
            tooltip = "View Distance";
            onSliderPosChanged = QUOTE(call FUNC(updateSlider));
            onMouseButtonUp = QUOTE(call FUNC(updateViewDistance));
        };

        class viewdistanceLabel: RscText {
            idc = IDC_LABEL_VIEWDISTANCE;
            text = "View Distance: ?m";
            x = LABEL_X;
            y = SLIDER_Y(1);
            w = SLIDER_WIDTH;
            h = SLIDER_HEIGHT;
        };

        class objectViewdistance: viewdistance {
            idc = IDC_SLIDER_OBJECTS;
            y = SLIDER_Y(2);
            sliderRange[] = {100, 20000};
            tooltip = "Object View Distance";
        };

        class objectViewdistanceLabel: viewdistanceLabel {
            idc = IDC_LABEL_OBJECTS;
            text = "Object View Distance: ?m";
            y = SLIDER_Y(2);
        };

        class pipViewdistance: viewdistance {
            idc = IDC_SLIDER_PIP;
            y = SLIDER_Y(3);
            sliderRange[] = {100, 40000};
            sliderStep = 50;
            tooltip = "PIP View Distance";
        };

        class pipViewdistanceLabel: viewdistanceLabel {
            idc = IDC_LABEL_PIP;
            text = "PIP View Distance: ?m";
            y = SLIDER_Y(3);
        };

        class shadowViewdistance: viewdistance {
            idc = IDC_SLIDER_SHADOW;
            y = SLIDER_Y(4);
            sliderRange[] = {10, 600};
            tooltip = "Shadow View Distance";
        };

        class shadowViewdistanceLabel: viewdistanceLabel {
            idc = IDC_LABEL_SHADOW;
            text = "Shadow View Distance: ?m";
            y = SLIDER_Y(4);
        };

        class terrainGrid: RscXSliderH {
            idc = IDC_SLIDER_TERRAIN;
            x = SLIDER_X;
            y = SLIDER_Y(5);
            w = SLIDER_WIDTH;
            h = SLIDER_HEIGHT;
            sliderRange[] = {3.125, 25};
            colorBackground[] = {0, 0, 0, 0.5};
            color[] = {1, 1, 1, 0.5};
            colorActive[] = {1, 1, 1, 0.5};
            tooltip = "Terrain Grid (lower means higher detail)";
            onSliderPosChanged = QUOTE(call FUNC(updateSlider));
        };

        class terrainGridLabel: viewdistanceLabel {
            idc = IDC_LABEL_TERRAIN;
            text = "Terrain Grid: ?";
            y = SLIDER_Y(5);
        };

        class buttonInfantry: RscButtonMenu {
            idc = IDC_BUTTON_INFANTRY;
            text = "Infantry";
            style = 2 + 12 + 64 + 128;
            x = BUTTON_X(0);
            y = SLIDER_Y(6);
            w = BUTTON_W;
            h = SLIDER_HEIGHT;
            colorBackground[] = {0, 0, 0, 0.5};
            colorBackgroundActive[] = {0, 0, 0, 0};
            color[] = {1, 1, 1, 1};
            colorActive[] = {1, 1, 1, 0.5};
            tooltip = "Infantry View Distance";
            onButtonClick = QUOTE(call FUNC(updateCategory));
            class Attributes {
                font = "PuristaLight";
                color = "#E5E5E5";
                align = "center";
                shadow = "false";
            };
        }

        class buttonVehicle: buttonInfantry {
            idc = IDC_BUTTON_VEHICLE;
            text = "Vehicle";
            x = BUTTON_X(1);
            tooltip = "Ground Vehicle View Distance";
        }

        class buttonAir: buttonInfantry {
            idc = IDC_BUTTON_AIR;
            text = "Air";
            x = BUTTON_X(2);
            tooltip = "Air View Distance";
        }
    };

    class objects {};
};