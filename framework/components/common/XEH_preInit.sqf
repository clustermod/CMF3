#include "script_component.hpp"

/* Change ACE carrying / draggin max carry weight */
ACE_maxWeightCarry = 1500;
ACE_maxWeightDrag = 1500;

/* Disable CTAB on ground vehicles */
cTab_vehicleClass_has_FBCB2 = [];

/* Handle connection and disconnection messages */
call FUNC(chatHandler);