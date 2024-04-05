#define MODULE player
#define MODULE_BEAUTIFIED Player

#define REQUIRED_ADDONS ["ace_hearing"]
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_PLAYER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_PLAYER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PLAYER
#endif

#include "..\main\script_component.hpp"

#define IDD_SPEC_DISPLAY 60000
