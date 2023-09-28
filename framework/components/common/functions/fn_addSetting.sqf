#include "script_component.hpp"
/*
 * Author: Eric
 * Adds a CMF setting for configuring cmf
 * 
 * Arguments:
 * 0: Variable Name <STRING>
 * 1: Setting Type <STRING>
 * 2: Title <ARRAY/STRING>
 * 3: Category <STRING>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myVariable", "CHECKBOX", ["My Setting", "My Tooltip"], "Setting Category"] call cmf_common_fnc_addSetting;
 * 
 * Public: Yes
 */
params["_variable", "_type", "_title", "_category"];

// @TODO: Show settings on zeus display start if there is no config