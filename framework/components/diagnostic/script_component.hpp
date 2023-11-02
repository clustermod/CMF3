#define MODULE diagnostic
#define MODULE_BEAUTIFIED Diagnostic

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#include "..\main\script_component.hpp"

#ifdef DEBUG_ENABLED_DIAGNOSTIC
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DIAGNOSTIC
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DIAGNOSTIC
#endif