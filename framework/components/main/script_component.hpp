#ifndef MODULE
    #define MODULE main
    #define MODULE_BEAUTIFIED Main
    #define REQUIRED_ADDONS []
    #define REQUIRED_MODULES []
#endif

/* Disable sqf-vm linting errors for include lookups */
#pragma sls disable file SQFVM-70014
#pragma sls disable file SQFVM-10004

#include "script_mod.hpp"

#ifdef DEBUG_ENABLED_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "script_macros.hpp"
