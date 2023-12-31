#define MODULE map
#define MODULE_BEAUTIFIED Map

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_MAP
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAP
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAP
#endif

#include "..\main\script_component.hpp"