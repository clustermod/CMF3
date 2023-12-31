#include "script_component.hpp"

call FUNC(hideRespawns);

private _placeMapAction = call FUNC(shareMapActions);
["CAManBase", 1, ["ACE_SelfActions", "ACE_Equipment"], _placeMapAction, true] call ACE_interact_menu_fnc_addActionToClass;