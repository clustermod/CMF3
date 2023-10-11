#define MODULE utility
#define MODULE_BEAUTIFIED Utility

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_UTILITY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_UTILITY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_UTILITY
#endif

#include "..\main\script_component.hpp"
