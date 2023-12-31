#define MODULE kosherGarage
#define MODULE_BEAUTIFIED Kosher Garage

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES ["common"]

#include "..\main\script_component.hpp"

#ifdef DEBUG_ENABLED_KOSHERGARAGE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_KOSHERGARAGE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_KOSHERGARAGE
#endif