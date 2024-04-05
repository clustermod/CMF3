#define MODULE logistics
#define MODULE_BEAUTIFIED Logistics

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_LOGISTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_LOGISTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOGISTICS
#endif

#include "..\main\script_component.hpp"