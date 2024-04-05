#define MODULE menu
#define MODULE_BEAUTIFIED Menu

#define REQUIRED_ADDONS ["A3_Functions_F", "ace_interact_menu"]
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_MENU
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MENU
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MENU
#endif

#include "..\main\script_component.hpp"