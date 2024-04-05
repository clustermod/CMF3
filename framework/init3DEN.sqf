/*
 * Gets executed when 3DEN has loaded. Code put in here will be run while in 3DEN.
 */

/* Run CMF */
[] execVM "components\main\XEH_MODULE.sqf";

0 call compile preprocessFileLineNumbers "markers.sqf";