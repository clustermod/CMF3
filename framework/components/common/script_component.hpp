#define MODULE common
#define MODULE_BEAUTIFIED Common

#define REQUIRED_ADDONS ["cba_settings"]
#define REQUIRED_MODULES []

#ifdef DEBUG_ENABLED_COMMON
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "..\main\script_component.hpp"

#define NOTIFICATION_M 0.01
#define NOTIFICATION_W 300 * pixelW
#define NOTIFICATION_BORDER_W 10 * pixelW
