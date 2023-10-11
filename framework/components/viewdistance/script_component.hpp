#define MODULE viewdistance
#define MODULE_BEAUTIFIED View Distance

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_VIEWDISTANCE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VIEWDISTANCE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VIEWDISTANCE
#endif

#include "..\main\script_component.hpp"
