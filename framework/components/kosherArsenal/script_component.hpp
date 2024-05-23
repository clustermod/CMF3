#define MODULE kosherArsenal
#define MODULE_BEAUTIFIED Kosher Arsenal

#define REQUIRED_ADDONS ["ace_arsenal"]
#define REQUIRED_MODULES ["common"]

#ifdef DEBUG_ENABLED_KOSHERARSENAL
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_KOSHERARSENAL
    #define DEBUG_SETTINGS DEBUG_SETTINGS_KOSHERARSENAL
#endif

#include "..\main\script_component.hpp"

#include "\z\ace\addons\arsenal\defines.hpp"