#define MODULE gameplay
#define MODULE_BEAUTIFIED Gameplay

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_GAMEPLAY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_GAMEPLAY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_GAMEPLAY
#endif

#include "..\main\script_component.hpp"