#define MODULE respawn
#define MODULE_BEAUTIFIED Respawn

#define REQUIRED_ADDONS ["ace_interaction_menu"]
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_RESPAWN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_RESPAWN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_RESPAWN
#endif

#include "..\main\script_component.hpp"