#include "script_component.hpp"
/*
 * Author: Eric
 * Adds a CBA Keybind for CMF
 * 
 * Arguments:
 * 0: Category <ARRAY/STRING>
 * 1: Variable Name <STRING>
 * 2: Title <ARRAY/STRING>
 * 3: Down Code <CODE>
 * 4: Up Code <CODE>
 * 5: Keybind <ARRAY>
 * 	- DIK Key <NUMBER>
 *	- Shift, Ctrl, Alt <ARRAY>
 * 6: Hold Key <BOOLEAN>
 * 7: Hold Delay <NUMBER>
 * 8: Overwrite <NUMBER>
 * 
 * Return Value:
 * None
 * 
 * Example:
 * ["myCategory", ["My Setting", "My Tooltip"], "MySetting", {}, {}, [DIK_TAB, [false, true, false]]] call cmf_common_fnc_addKeybind;
 * 
 * Public: Yes
 */
params["_category", "_uniqueName", "_title", "_downCode", "_upCode", "_defaultKeybind", ["_holdKey", false], ["_holdDelay", 0], ["_overwrite", false]];

if (isNil QGVAR(clientKeybinds)) then {
    GVAR(clientKeybinds) = [] call CBA_fnc_hashCreate;
};

[_category, _uniqueName, _title, _downCode, _upCode, _defaultKeybind, _holdKey, _holdDelay, _overwrite] call CBA_fnc_addKeybind;

/* Update keybinds hash */
private _keybindCategory = [GVAR(clientKeybinds), _category, []] call CBA_fnc_hashGet;
_keybindCategory pushBack [_uniqueName, _title];
GVAR(clientKeybinds) = [GVAR(clientKeybinds), _category, _keybindCategory] call CBA_fnc_hashSet;