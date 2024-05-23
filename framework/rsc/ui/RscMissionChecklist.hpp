#if __has_include("..\..\components\3den\script_component.hpp")
#include "..\..\components\3den\script_component.hpp"

class CMF_RscMissionChecklist {
    idd = -1;
    movingEnable = "true";
    onLoad = QUOTE(_this call FUNC(initDisplayChecklist));
    class ControlsBackground {
        class Background: ctrlStaticBackground {
            x = CUI_GRID_X - RSCCHECKLIST_W / 2 * CUI_GRID_W;
            y = CUI_GRID_Y - 13 * CUI_GRID_H;
            w = RSCCHECKLIST_W * CUI_GRID_W;
            h = RSCCHECKLIST_H * CUI_GRID_H;
        };

        class TitleHeader: ctrlStaticTitle {
            text = "Mission Checklist";
            x = CUI_GRID_X - RSCCHECKLIST_W / 2 * CUI_GRID_W;
            y = CUI_GRID_Y - 14 * CUI_GRID_H;
            w = RSCCHECKLIST_W * CUI_GRID_W;
            h = CUI_GRID_H;
        };
    };
    class Controls {
        class Group: ctrlControlsGroup {
            x = CUI_GRID_X - RSCCHECKLIST_W / 2 * CUI_GRID_W;
            y = CUI_GRID_Y - 13 * CUI_GRID_H;
            w = RSCCHECKLIST_W * CUI_GRID_W;
            h = RSCCHECKLIST_H * CUI_GRID_H - CUI_GRID_H - 3/5 * CUI_GRID_H;
            class Controls {
                class Content: RscListBox {
                    idc = IDC_CHECKLIST;
                    x = 0;
                    y = 0;
                    w = (RSCCHECKLIST_W - 0.2) * CUI_GRID_W;
                    h = RSCCHECKLIST_H * CUI_GRID_H;
                    style = ST_NO_RECT + ST_MULTI;
                    canModify = 0;
                    size = 0.7 * CUI_GRID_H;
                    shadow = 0;
                    colorBackground[] = {0,0,0,0.8};
                };
            };
        };

        class Close: ctrlButtonClose {
            x = CUI_GRID_X + RSCCHECKLIST_W / 2 * CUI_GRID_W - 5.2 * CUI_GRID_W;
            y = CUI_GRID_Y + RSCCHECKLIST_H * CUI_GRID_H - 14.2 * CUI_GRID_H;
            w = 5 * CUI_GRID_W;
            h = CUI_GRID_H;
        };
    };
};

#endif