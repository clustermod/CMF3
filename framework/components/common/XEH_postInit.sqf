#include "script_component.hpp"

/* Create cmf_player */
cmf_player = player;
["unit", {
    params ["_unit"];

    if !(_unit isKindOf "Man") exitWith {};

    cmf_player = _unit;
}] call CBA_fnc_addPlayerEventHandler;

/* Create CMF Info Diary */
[] spawn FUNC(diary);

/* Remove statistics diary */
cmf_player removeDiarySubject "Statistics";

/* Remove team diary */
cmf_player removeDiarySubject "Units";

/* Create notification colors */
GVAR(notificationColors) = createHashMapFromArray [
    ["DEFAULT", [0.69, 0.69, 0.69, 0.50]],
    ["INFO", [0.00, 0.75, 0.75, 0.50]],
    ["DEBUG", [0.99, 0.42, 0.98, 0.50]],
    ["WARNING", [0.78, 0.78, 0.00, 0.50]],
    ["ERROR", [0.81, 0.20, 0.17, 0.50]]
];