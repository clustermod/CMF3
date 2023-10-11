#define MODULE kosherAI
#define MODULE_BEAUTIFIED Kosher AI

#define REQUIRED_ADDONS ["ace_arsenal"]
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_KOSHERAI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_KOSHERAI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_KOSHERAI
#endif

#include "..\main\script_component.hpp"