#if __has_include("..\..\components\aar\script_component.hpp")
#include "..\..\components\aar\script_component.hpp"

class CMF_RscAfterActionReader {
    idd = -1;
    movingEnable = "true";
    onLoad = QUOTE(_this call FUNC(initDisplayReader));
    class ControlsBackground {
        class BackgroundDisable: ctrlStaticBackgroundDisable {};
        class BackgroundDisableTiles: ctrlStaticBackgroundDisableTiles {};
        class Background: ctrlStaticBackground {
            x = CUI_GRID_X - RSCREADER_W / 2 * CUI_GRID_W;
            y = CUI_GRID_Y - 13 * CUI_GRID_H;
            w = RSCREADER_W * CUI_GRID_W;
            h = RSCREADER_H * CUI_GRID_H;
        };

        class TitleHeader: ctrlStaticTitle {
            idc = IDC_TABTITLE;
            text = "After Action Report (0)";
            x = CUI_GRID_X - RSCREADER_W / 2 * CUI_GRID_W;
            y = CUI_GRID_Y - 14 * CUI_GRID_H;
            w = RSCREADER_W * CUI_GRID_W;
            h = CUI_GRID_H;
        };
    };

    class Controls {
        class Group: ctrlControlsGroup {
            x = CUI_GRID_X - RSCREADER_W / 2 * CUI_GRID_W;
            y = CUI_GRID_Y - 13 * CUI_GRID_H;
            w = RSCREADER_W * CUI_GRID_W;
            h = RSCREADER_H * CUI_GRID_H - CUI_GRID_H - 3/5 * CUI_GRID_H;
            class Controls {
                class authorTitle: RscText {
                    text = "Author";
                    x = 0.01;
                    y = 0.02;
                    w = (RSCREADER_W - 1.4) * CUI_GRID_W;
                    h = 0.1;
                    style = ST_NO_RECT + ST_MULTI;
                    canModify = 0;
                    sizeEx = 0.7 * CUI_GRID_H;
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    font = "EtelkaMonospacePro";
                };

                class author: ctrlStructuredText {
                    idc = IDC_AUTHOR;
                    text = "";
                    x = 0.017;
                    y = 0.045;
                    w = (RSCREADER_W - 1.4) * CUI_GRID_W;
                    h = 0.03;
                    style = ST_NO_RECT + ST_VCENTER;
                    canModify = 0;
                    size = 0.7 * CUI_GRID_H;
                    shadow = 0;
                    colorBackground[] = {0,0,0,0.4};
                    class Attributes {
                        font = "EtelkaMonospacePro";
                    };
                };

                class missionTitle: authorTitle {
                    text = "Mission Feedback";
                    x = 0.01;
                    y = 0.1;
                    w = (RSCREADER_W - 1.4) * CUI_GRID_W;
                    h = 0.1;
                };

                class missionContent: author {
                    idc = IDC_MISSION;
                    text = "No registered reports";
                    x = 0.017;
                    y = 0.13;
                    w = (RSCREADER_W - 1.4) * CUI_GRID_W;
                    h = 0.25;
                    style = ST_NO_RECT + ST_MULTI;
                };

                class tacticalTitle: missionTitle {
                    text = "Tactical Feedback";
                    x = 0.01;
                    y = 0.4;
                    w = (RSCREADER_W - 1.4) * CUI_GRID_W;
                    h = 0.1;
                };

                class tacticalContent: missionContent {
                    idc = IDC_TACTICAL;
                    text = "";
                    x = 0.017;
                    y = 0.43;
                    w = (RSCREADER_W - 1.4) * CUI_GRID_W;
                    h = 0.25;
                };
            };
        };

        class Next: ctrlButton {
            idc = IDC_NEXT;
            text = "Next";
            x = CUI_GRID_X + RSCREADER_W / 2 * CUI_GRID_W - 5.2 * CUI_GRID_W;
            y = CUI_GRID_Y + RSCREADER_H * CUI_GRID_H - 14.2 * CUI_GRID_H;
            w = 5 * CUI_GRID_W;
            h = CUI_GRID_H;
        };

        class Previous: ctrlButton {
            idc = IDC_PREVIOUS;
            text = "PREVIOUS";
            x = CUI_GRID_X + RSCREADER_W / 2 * CUI_GRID_W - 19.8 * CUI_GRID_W;
            y = CUI_GRID_Y + RSCREADER_H * CUI_GRID_H - 14.2 * CUI_GRID_H;
            w = 5 * CUI_GRID_W;
            h = CUI_GRID_H;
        };
    };
};

#endif