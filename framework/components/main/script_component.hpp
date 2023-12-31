#ifndef MODULE
    #define MODULE main
    #define MODULE_BEAUTIFIED Main
#endif

#define REQUIRED_ADDONS []
#define REQUIRED_MODULES []

#include "script_mod.hpp"

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "script_macros.hpp"
