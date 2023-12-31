#define MODULE curator
#define MODULE_BEAUTIFIED Curator

#define REQUIRED_ADDONS ["zen_main"]
#define REQUIRED_MODULES []

#ifdef DEBUG_ENABLED_ZEUS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ZEUS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ZEUS
#endif

#include "..\main\script_component.hpp"

#include "\a3\ui_f\hpp\definedikcodes.inc"