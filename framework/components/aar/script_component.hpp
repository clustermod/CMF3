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