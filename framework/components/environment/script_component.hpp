#define MODULE environment
#define MODULE_BEAUTIFIED Environment

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_ENVIRONMENT
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ENVIRONMENT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ENVIRONMENT
#endif

#include "..\main\script_component.hpp"
