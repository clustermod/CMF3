#define MODULE 3den
#define MODULE_BEAUTIFIED 3DEN

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES []

#ifdef DEBUG_ENABLED_3DEN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_3DEN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_3DEN
#endif

#include "..\main\script_component.hpp"

#include "\a3\ui_f\hpp\definecommongrids.inc"

#define IDC_CHECKLIST 200

#define RSCCHECKLIST_W 20
#define RSCCHECKLIST_H 30

#define UI_GRID_W (5 * 0.5 * pixelW * pixelGrid)
#define UI_GRID_H (5 * 0.5 * pixelH * pixelGrid)
#define CUI_GRID_X (0.5)
#define CUI_GRID_Y (0.5)
#define CUI_GRID_W UI_GRID_W
#define CUI_GRID_H UI_GRID_H

#define LOG_FONTSIZE 0.7 * CUI_GRID_H