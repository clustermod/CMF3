#define MODULE aar
#define MODULE_BEAUTIFIED After Action Report (AAR)

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_AAR
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AAR
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AAR
#endif

#include "..\main\script_component.hpp"

#include "\a3\ui_f\hpp\definecommongrids.inc"

#define IDD_SPEC_DISPLAY 60000

#define IDC_TABTITLE 100
#define IDC_AUTHOR 200
#define IDC_MISSION 300
#define IDC_TACTICAL 301
#define IDC_NEXT 500
#define IDC_PREVIOUS 501

#define RSCREADER_W 20
#define RSCREADER_H 25

#define UI_GRID_W (5 * 0.5 * pixelW * pixelGrid)
#define UI_GRID_H (5 * 0.5 * pixelH * pixelGrid)
#define CUI_GRID_X (0.5)
#define CUI_GRID_Y (0.5)
#define CUI_GRID_W UI_GRID_W
#define CUI_GRID_H UI_GRID_H

#define LOG_FONTSIZE 0.7 * CUI_GRID_H

#define LINES_TOOLTIP QUOTE(Define the number of lines to be shown. 30 means the last 30 lines are shown. Use a small number to speed up the process. Use a very large number to display all lines.)