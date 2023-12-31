#define MODULE vehicles
#define MODULE_BEAUTIFIED Vehicles

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES []

#ifdef DEBUG_ENABLED_VEHICLES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VEHICLES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VEHICLES
#endif

#include "..\main\script_component.hpp"

#define OFFROAD_BUMPSPEED 10
#define OFFROAD_DAMAGESPEED 80
#define OFFROAD_DAMAGEMODIFIER 100