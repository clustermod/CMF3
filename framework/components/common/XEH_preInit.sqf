#include "script_component.hpp"

/* Change ACE carrying / draggin max carry weight */
ACE_maxWeightCarry = 1500;
ACE_maxWeightDrag = 1500;

/* Disable CTAB on ground vehicles */
cTab_vehicleClass_has_FBCB2 = [];

/* Create notification colors */
GVAR(notificationColors) = createHashMapFromArray [
    ["DEFAULT", [0.69, 0.69, 0.69, 0.50]],
    ["INFO", [0.00, 0.75, 0.75, 0.50]],
    ["DEBUG", [0.99, 0.42, 0.98, 0.50]],
    ["WARNING", [0.78, 0.78, 0.00, 0.50]],
    ["ERROR", [0.81, 0.20, 0.17, 0.50]]
];

/* Handle connection and disconnection messages */
call FUNC(chatHandler);