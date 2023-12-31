#define MODULE organization
#define MODULE_BEAUTIFIED Organization

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_ORGANIZATION
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ORGANIZATION
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ORGANIZATION
#endif

#include "..\main\script_component.hpp"