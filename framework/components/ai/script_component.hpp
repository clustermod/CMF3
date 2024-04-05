#define MODULE ai
#define MODULE_BEAUTIFIED AI

#define REQUIRED_ADDONS ["lambs_danger"]
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_AI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AI
#endif

#include "..\main\script_component.hpp"